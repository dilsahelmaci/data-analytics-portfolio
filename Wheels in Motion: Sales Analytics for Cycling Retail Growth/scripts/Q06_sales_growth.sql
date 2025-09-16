/*
===============================================================================
Q6. Are our sales growing?

Purpose:
    - 6.1) Measure sales growth year-over-year (YoY) to assess overall performance.
    - 6.2) Analyze monthly sales trends with a 3-month moving average to observe seasonality.
    - 6.3) Analyze quarterly sales trends with a 4-quarter moving average to smooth long-term patterns.
    - 6.4) Evaluate average order value (AOV) as a key customer spending metric.

SQL Features Used:
    - SUM, COUNT, AVG
    - GROUP BY, ORDER BY
    - DATE functions (YEAR, DATETRUNC, DATEPART, FORMAT)
    - Window functions (LAG and moving averages)
    - NULLIF, COALESCE
    - CTEs
===============================================================================
*/
-- 6.1) Calculate year-over-year (YoY) sales growth
WITH yearly AS(
    SELECT 
        YEAR(order_date) AS order_year, 
        SUM(sales_amount) AS total_revenue
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date)
), 
growth AS(
    SELECT
        order_year,
        total_revenue,
        LAG(total_revenue) OVER(ORDER BY order_year) AS prior_year_revenue
    FROM yearly
)
SELECT 
    order_year,
    total_revenue, 
    prior_year_revenue, 
    total_revenue - COALESCE(prior_year_revenue, 0) AS yoy_change, 
    CAST(100.0 * (total_revenue - COALESCE(prior_year_revenue, 0))
       / NULLIF(prior_year_revenue, 0) AS DECIMAL(10,2)) AS yoy_percentage
FROM growth
ORDER BY order_year;

-- 6.2) Monthly sales trends with 3-month moving average (revenue over current + 2 prior months)
WITH base AS(
    SELECT 
        DATETRUNC(month, order_date) AS month_start, 
        order_number,
        sales_amount
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
), 
monthly AS(
    SELECT
        month_start, 
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_revenue
    FROM base
    GROUP BY month_start
)
SELECT 
    FORMAT(month_start, 'yyyy-MM') AS year_month, 
    total_revenue, 
    total_orders,
    CAST((total_revenue / NULLIF(total_orders, 0)) AS DECIMAL(18, 2)) AS avg_order_value,
    CAST(
        AVG(CAST(total_revenue AS DECIMAL(18,2)))
        OVER (ORDER BY month_start ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
        AS DECIMAL(18,2)
    ) AS moving_avg_revenue_3m
FROM monthly
ORDER BY month_start;

-- 6.3) Quarterly sales trends with 4-quarter moving average (current + 3 prior quarters)
WITH base_quarter AS (
    SELECT
        DATETRUNC(quarter, order_date) AS quarter_start,
        order_number,
        sales_amount
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
),
quarterly AS (
    SELECT
        quarter_start,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_revenue
    FROM base_quarter
    GROUP BY quarter_start
),
moving AS (
    SELECT
        quarter_start,
        CONCAT(YEAR(quarter_start), '-Q', DATEPART(QUARTER, quarter_start)) AS year_quarter,
        total_orders,
        total_revenue,
        CAST(total_revenue / NULLIF(total_orders, 0) AS DECIMAL(18,2)) AS avg_order_value,
        CAST(
            AVG(CAST(total_revenue AS DECIMAL(18,2)))
                OVER (ORDER BY quarter_start ROWS BETWEEN 3 PRECEDING AND CURRENT ROW)
            AS DECIMAL(18,2)
        ) AS moving_avg_revenue_4q
    FROM quarterly
),
with_trend AS (
    SELECT
        quarter_start,
        year_quarter,
        total_orders,
        total_revenue,
        avg_order_value,
        moving_avg_revenue_4q,
        -- QoQ change in the moving average
        CAST(
            moving_avg_revenue_4q
            - LAG(moving_avg_revenue_4q) OVER (ORDER BY quarter_start)
            AS DECIMAL(18,2)
        ) AS mov_avg_qoq_change
    FROM moving
)
SELECT
    year_quarter,
    total_revenue,
    total_orders,
    avg_order_value,
    moving_avg_revenue_4q,
    mov_avg_qoq_change,
    CASE
        WHEN mov_avg_qoq_change IS NULL THEN 'N/A'
        WHEN ABS(mov_avg_qoq_change) < 0.01 THEN 'Same'
        WHEN mov_avg_qoq_change > 0 THEN 'Increasing'
        ELSE 'Decreasing'
    END AS growth_status
FROM with_trend
ORDER BY quarter_start;

-- 6.4) Calculate average order value (AOV)
SELECT
    SUM(sales_amount) AS total_revenue,
    COUNT(DISTINCT order_number) AS total_orders,
    CAST(SUM(sales_amount) / NULLIF(COUNT(DISTINCT order_number), 0) AS DECIMAL(18,2)) AS avg_order_value
FROM gold.fact_sales
WHERE order_date IS NOT NULL;