/*
===============================================================================
Q7. Which products are underperforming or drive long-term value?

Purpose:
    - 7.1) Identify products with high sales volume but low revenue (low-margin).
    - 7.2) Compare repeat-purchase behavior for maintenance-required products.
    - 7.3) Rank product categories by profitability (revenue, cost, margin, rate).

SQL Features Used:
    - SUM, COUNT, AVG
    - GROUP BY, ORDER BY, JOINs
    - CASE expressions
    - Window functions (PERCENT_RANK)
    - CTEs
===============================================================================
*/
-- 7.1) Identify products with high sales volume but low revenue
WITH product_agg AS (
    SELECT
        f.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        SUM(f.quantity) AS total_quantity,
        SUM(f.sales_amount) AS total_revenue,
        COUNT(DISTINCT f.order_number) AS total_orders
    FROM gold.fact_sales AS f
    INNER JOIN gold.dim_products AS p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY f.product_key, p.product_name, p.category, p.subcategory
),
scored AS (
    SELECT
        *,
        PERCENT_RANK() OVER (ORDER BY total_quantity DESC) AS volume_perc,
        PERCENT_RANK() OVER (ORDER BY total_revenue  DESC) AS revenue_perc
    FROM product_agg
)
SELECT
    product_name,
    category,
    subcategory,
    total_quantity,
    total_revenue,
    total_orders,
    volume_perc,
    revenue_perc
FROM scored
WHERE total_orders >= 5
  AND volume_perc >= 0.80   -- top 20% by volume
  AND revenue_perc <  0.50  -- bottom 50% by revenue
ORDER BY volume_perc DESC, revenue_perc ASC;

-- 7.2) Repeat-purchase rate by subcategory: maintenance vs non-maintenance
WITH lines AS (
    SELECT
        f.order_number,
        f.customer_key,
        p.subcategory,
        CASE
            WHEN p.maintenance = 'Yes' THEN 1
            ELSE 0
        END AS is_maintenance
    FROM gold.fact_sales f
    INNER JOIN gold.dim_products p
      ON p.product_key = f.product_key
    WHERE f.order_date IS NOT NULL
),
pairs AS (
    -- One row per with # of distinct orders
    SELECT
        subcategory,
        is_maintenance,
        customer_key,
        COUNT(DISTINCT order_number) AS orders_for_pair
    FROM lines
    GROUP BY subcategory, is_maintenance, customer_key
),
agg AS (
    SELECT
        subcategory,
        is_maintenance,
        COUNT(*) AS customer_subcat_pairs,
        SUM(CASE WHEN orders_for_pair >= 2 THEN 1 ELSE 0 END) AS repeat_pairs
    FROM pairs
    GROUP BY subcategory, is_maintenance
)
SELECT
    subcategory,
    CASE WHEN is_maintenance = 1 THEN 'Maintenance' ELSE 'Non-maintenance' END AS is_maintenance,
    customer_subcat_pairs,
    repeat_pairs,
    CAST(100.0 * repeat_pairs / NULLIF(customer_subcat_pairs, 0) AS DECIMAL(5,2)) AS repeat_rate_percentage
FROM agg
WHERE customer_subcat_pairs >= 50
ORDER BY repeat_rate_percentage DESC, customer_subcat_pairs DESC, subcategory, is_maintenance;

-- 7.3) Rank categories by profitability
WITH enriched AS (
    SELECT
        p.category AS category,
        f.order_number,
        f.quantity,
        CAST(f.sales_amount AS DECIMAL(18,2)) AS line_revenue,
        CAST(p.cost AS DECIMAL(18,2)) AS unit_cost
    FROM gold.fact_sales AS f
    INNER JOIN gold.dim_products AS p
      ON p.product_key = f.product_key
    WHERE f.order_date IS NOT NULL
),
agg AS (
    SELECT
        category,
        SUM(line_revenue) AS revenue,
        SUM(CAST(quantity AS DECIMAL(18,2)) * unit_cost) AS cost,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT order_number) AS orders
    FROM enriched
    GROUP BY category
),
products_per_category AS (
    SELECT
        category,
        COUNT(DISTINCT product_key) AS num_products
    FROM gold.dim_products
    GROUP BY category
)
SELECT
    a.category,
    a.revenue,
    a.cost,
    (a.revenue - a.cost) AS gross_margin,
    CAST(100.0 * (a.revenue - a.cost) / NULLIF(a.revenue, 0) AS DECIMAL(6,2)) AS margin_rate_percantage,
    a.total_quantity,
    a.orders,
    p.num_products
FROM agg AS a
LEFT JOIN products_per_category AS p
  ON p.category = a.category
ORDER BY gross_margin DESC, margin_rate_percantage DESC;