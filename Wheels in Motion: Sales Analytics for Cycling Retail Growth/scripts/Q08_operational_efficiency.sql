/*
===============================================================================
Q8. How efficient are our operations?
===============================================================================
Purpose:
    - 8.1) Measure average shipping delay (shipping_date – order_date).
    - 8.2) Identify product categories and customer countries with the longest delays.

SQL Features Used:
    - DATEDIFF
    - SUM, COUNT, AVG
    - GROUP BY, ORDER BY, JOINs
    - CTEs
===============================================================================
*/
-- Prepare common base table for operational metrics
IF OBJECT_ID('tempdb..#base') IS NOT NULL DROP TABLE #base;

SELECT
    f.order_number,
    f.order_date,
    f.shipping_date,
    p.category,
    c.country,
    -- shipping delay in days (if dates missing, then assign as NULL)
    CASE 
        WHEN f.order_date IS NOT NULL 
         AND f.shipping_date IS NOT NULL
        THEN DATEDIFF(day, f.order_date, f.shipping_date)
        ELSE NULL
    END AS delay_days
INTO #base
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products  AS p ON p.product_key  = f.product_key
LEFT JOIN gold.dim_customers AS c ON c.customer_key = f.customer_key
WHERE f.order_date IS NOT NULL;

-- 8.1) Overall average shipping delay
SELECT
    COUNT(*) AS lines_total, -- all rows in #base
    COUNT(delay_days) AS lines_with_delay, -- non-NULL delay_days
    COUNT(*) - COUNT(delay_days) AS lines_missing_delay,
    CAST(AVG(CAST(delay_days AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS avg_delay_days
FROM #base;

-- 8.2) Longest delays by category and country (combined ranking; top 10 of each dimension)
WITH dim_delays AS (
    -- Category
    SELECT
        'Category' AS dim_type,
        COALESCE(category, 'Unknown') AS dim_value,
        COUNT(*) AS lines,
        CAST(AVG(CAST(delay_days AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS avg_delay_days
    FROM #base
    WHERE delay_days IS NOT NULL
    GROUP BY COALESCE(category, 'Unknown')

    UNION ALL

    -- Country
    SELECT
        'Country' AS dim_type,
        COALESCE(country, 'Unknown') AS dim_value,
        COUNT(*) AS lines,
        CAST(AVG(CAST(delay_days AS DECIMAL(10,2))) AS DECIMAL(10,2)) AS avg_delay_days
    FROM #base
    WHERE delay_days IS NOT NULL
    GROUP BY COALESCE(country, 'Unknown')
),
ranked AS (
    SELECT
        dim_type,
        dim_value,
        lines,
        avg_delay_days,
        DENSE_RANK() OVER (PARTITION BY dim_type ORDER BY avg_delay_days DESC) AS rank
    FROM dim_delays
)
SELECT
    dim_type,
    dim_value,
    lines,
    avg_delay_days
    --rank
FROM ranked
WHERE rank <= 10
ORDER BY dim_type, rank;

-- Drop the temporary base table
DROP TABLE #base;