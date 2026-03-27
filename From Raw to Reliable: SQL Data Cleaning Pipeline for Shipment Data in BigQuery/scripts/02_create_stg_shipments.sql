CREATE OR REPLACE TABLE `data-cleaning-sql-491409.shipments_cleaning.stg_shipments` AS
WITH raw_data AS (
  SELECT *
  FROM `data-cleaning-sql-491409.shipments_cleaning.raw_shipments`
),

-- =========================================================
-- Step 1: Trim whitespace
-- =========================================================
step_1_trim AS (
  SELECT
    shipment_id,
    TRIM(origin_warehouse) AS origin_warehouse,
    TRIM(destination_city) AS destination_city,
    TRIM(destination_state) AS destination_state,
    TRIM(carrier) AS carrier,
    TRIM(damage_reported) AS damage_reported,
    TRIM(ship_date) AS ship_date,
    TRIM(delivery_date) AS delivery_date,
    weight_kg,
    freight_cost,
    items_count
  FROM raw_data
),

-- =========================================================
-- Step 2: Standardize casing
-- =========================================================
step_2_standardize AS (
  SELECT
    shipment_id,
    INITCAP(origin_warehouse) AS origin_warehouse,
    INITCAP(destination_city) AS destination_city,
    UPPER(destination_state) AS destination_state,
    INITCAP(carrier) AS carrier,
    INITCAP(damage_reported) AS damage_reported,
    ship_date,
    delivery_date,
    weight_kg,
    freight_cost,
    items_count
  FROM step_1_trim
),

-- =========================================================
-- Step 3: Handle NULL-like strings and missing values
-- =========================================================
step_3_handle_nulls AS (
  SELECT
    shipment_id,
    origin_warehouse,
    COALESCE(NULLIF(destination_city, ''), 'Unknown') AS destination_city,
    COALESCE(NULLIF(destination_state, ''), 'Unknown') AS destination_state,
    carrier,
    CASE
      WHEN UPPER(damage_reported) = 'NULL' OR damage_reported = '' THEN NULL
      ELSE damage_reported
    END AS damage_reported,
    NULLIF(ship_date, '') AS ship_date,
    NULLIF(delivery_date, '') AS delivery_date,
    weight_kg,
    freight_cost,
    items_count
  FROM step_2_standardize
),

-- =========================================================
-- Step 4: Fix numeric issues
-- =========================================================
step_4_numeric_cleaning AS (
  SELECT
    shipment_id,
    origin_warehouse,
    destination_city,
    destination_state,
    carrier,
    damage_reported,
    ship_date,
    delivery_date,
    CASE
      WHEN weight_kg < 0 THEN ABS(weight_kg)
      WHEN weight_kg = 0 THEN NULL
      ELSE weight_kg
    END AS weight_kg,
    CASE
      WHEN freight_cost < 0 THEN ABS(freight_cost)
      ELSE freight_cost
    END AS freight_cost,
    CASE
      WHEN items_count < 0 THEN ABS(items_count)
      WHEN items_count = 0 THEN NULL
      ELSE items_count
    END AS items_count
  FROM step_3_handle_nulls
),

-- =========================================================
-- Step 5: Parse dates
-- =========================================================
step_5_dates AS (
  SELECT
    *,
    COALESCE(
      SAFE.PARSE_DATE('%Y-%m-%d', ship_date),
      SAFE.PARSE_DATE('%d/%m/%Y', ship_date),
      SAFE.PARSE_DATE('%m/%d/%Y', ship_date),
      SAFE.PARSE_DATE('%Y/%m/%d', ship_date),
      SAFE.PARSE_DATE('%B %d %Y', ship_date),
      SAFE.PARSE_DATE('%b %d %Y', ship_date)
    ) AS ship_date_cleaned,
    COALESCE(
      SAFE.PARSE_DATE('%Y-%m-%d', delivery_date),
      SAFE.PARSE_DATE('%d/%m/%Y', delivery_date),
      SAFE.PARSE_DATE('%m/%d/%Y', delivery_date),
      SAFE.PARSE_DATE('%Y/%m/%d', delivery_date),
      SAFE.PARSE_DATE('%B %d %Y', delivery_date),
      SAFE.PARSE_DATE('%b %d %Y', delivery_date)
    ) AS delivery_date_cleaned
  FROM step_4_numeric_cleaning
),

-- =========================================================
-- Step 6: Add date quality flag
-- =========================================================
step_6_date_validation AS (
  SELECT
    *,
    DATE_DIFF(delivery_date_cleaned, ship_date_cleaned, DAY) AS transit_days,
    CASE
      WHEN delivery_date_cleaned IS NULL THEN 'NOT DELIVERED OR INVALID DATE'
      WHEN ship_date_cleaned IS NULL THEN 'INVALID SHIP DATE'
      WHEN DATE_DIFF(delivery_date_cleaned, ship_date_cleaned, DAY) < 0 THEN 'INVALID'
      WHEN DATE_DIFF(delivery_date_cleaned, ship_date_cleaned, DAY) = 0 THEN 'SAME DAY DELIVERY'
      ELSE 'VALID'
    END AS data_quality_flag
  FROM step_5_dates
),

-- =========================================================
-- Step 7: Remove duplicates
-- =========================================================
step_7_deduplicated AS (
  SELECT * EXCEPT(row_num)
  FROM (
    SELECT
      *,
      ROW_NUMBER() OVER (
        PARTITION BY
          origin_warehouse,
          destination_city,
          destination_state,
          carrier,
          ship_date_cleaned,
          delivery_date_cleaned,
          CAST(weight_kg AS STRING),
          CAST(freight_cost AS STRING), 
          items_count
        ORDER BY shipment_id
      ) AS row_num
    FROM step_6_date_validation
  )
  WHERE row_num = 1
),

-- =========================================================
-- Step 8: Calculate IQR bounds for freight_cost
-- =========================================================
iqr_stats AS (
  SELECT
    APPROX_QUANTILES(freight_cost, 100)[OFFSET(25)] AS q1,
    APPROX_QUANTILES(freight_cost, 100)[OFFSET(75)] AS q3
  FROM step_7_deduplicated
  WHERE freight_cost IS NOT NULL AND freight_cost > 0
),

bounds AS (
  SELECT
    -- q1,
    -- q3,
    ROUND(q1 - 1.5 * (q3 - q1), 2) AS lower_bound,
    ROUND(q3 + 1.5 * (q3 - q1), 2) AS upper_bound
  FROM iqr_stats
),

-- =========================================================
-- Step 9: Cap outliers
-- =========================================================
final_cleaned AS (
  SELECT
    d.shipment_id,
    d.origin_warehouse,
    d.destination_city,
    d.destination_state,
    d.carrier,
    d.damage_reported,
    d.ship_date_cleaned AS ship_date,
    d.delivery_date_cleaned AS delivery_date,
    d.transit_days,
    d.data_quality_flag,
    d.weight_kg,
    d.items_count,
    d.freight_cost AS original_freight_cost,
    CASE
      WHEN d.freight_cost > b.upper_bound THEN b.upper_bound
      WHEN d.freight_cost < b.lower_bound THEN b.lower_bound
      ELSE d.freight_cost
    END AS freight_cost,
    CASE
      WHEN d.freight_cost > b.upper_bound OR d.freight_cost < b.lower_bound THEN TRUE
      ELSE FALSE
    END AS was_outlier
  FROM step_7_deduplicated AS d
  CROSS JOIN bounds AS b
)

SELECT *
FROM final_cleaned;