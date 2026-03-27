CREATE OR REPLACE VIEW `data-cleaning-sql-491409.shipments_cleaning.fct_shipments` AS
SELECT
  shipment_id,
  origin_warehouse,
  destination_city,
  destination_state,
  carrier,
  ship_date,
  delivery_date,
  transit_days,
  data_quality_flag,
  weight_kg,
  items_count,
  freight_cost,
  ROUND(SAFE_DIVIDE(freight_cost, weight_kg), 2) AS cost_per_kg,
  FORMAT_DATE('%Y-%m', ship_date) AS ship_month,
  CASE
    WHEN transit_days IS NULL THEN 'Unknown'
    WHEN transit_days <= 2 THEN 'Fast'
    WHEN transit_days <= 5 THEN 'Normal'
    ELSE 'Slow'
  END AS delivery_speed,
  CASE
    WHEN freight_cost < 50 THEN 'Low Cost'
    WHEN freight_cost < 200 THEN 'Medium Cost'
    ELSE 'High Cost'
  END AS freight_cost_band
FROM `data-cleaning-sql-491409.shipments_cleaning.stg_shipments`;