/*
===============================================================================
Q2. What products do we sell?

Purpose:
    - Explore the distribution of products across 2.1) categories and 2.2) subcategories.
    - 2.3) Calculate the min, max, avg, stdev, and median product costs by category.
    - 2.4) Identify how many products require maintenance.

SQL Features Used:
    - COUNT, AVG, MIN, MAX, STDEV
    - GROUP BY, ORDER BY
    - Window functions: SUM() OVER(), PERCENTILE_CONT() OVER()
    - CASE expressions
    - CTEs
===============================================================================
*/
-- 2.1) Analyze product distribution across only categories
SELECT
    COALESCE(category, 'Unknown') AS category, 
    COUNT(*) AS product_count, 
    CAST(100.0 * COUNT(*)
        / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) AS product_percentage
FROM gold.dim_products
GROUP BY COALESCE(category, 'Unknown')
ORDER BY product_count DESC; 

-- 2.2) Analyze product distribution across categories and subcategories
SELECT
    COALESCE(category, 'Unknown') AS category, 
    COALESCE(subcategory, 'Unknown') AS subcategory,
    COUNT(*) AS product_count, 
    CAST(100.0 * COUNT(*)
        / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) AS product_percentage
FROM gold.dim_products
GROUP BY COALESCE(category, 'Unknown'), COALESCE(subcategory, 'Unknown')
ORDER BY category, product_count DESC; 

-- 2.3) Calculate min, max, avg, stdev, and median product costs by category
WITH base AS (
  SELECT
    COALESCE(category, 'Unknown') AS category,
    CAST(cost AS DECIMAL(10,2)) AS cost
  FROM gold.dim_products
  WHERE cost IS NOT NULL
),
stats AS (
  SELECT
    category,
    COUNT(*) AS product_count,
    MIN(cost) AS min_product_cost,
    MAX(cost) AS max_product_cost,
    CAST(AVG(cost) AS DECIMAL(10,2)) AS avg_product_cost,
    CAST(STDEV(cost) AS DECIMAL(10,2)) AS std_product_cost
  FROM base
  GROUP BY category
),
median AS (
  SELECT DISTINCT
    category,
    CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY cost) OVER (PARTITION BY category)
        AS DECIMAL(10,2)
    ) AS median_product_cost
  FROM base
)
-- summary table for stats
SELECT
  s.category,
  s.product_count,
  s.min_product_cost,
  s.max_product_cost,
  s.avg_product_cost,
  s.std_product_cost,
  m.median_product_cost
FROM stats s
JOIN median m 
  ON m.category = s.category
ORDER BY s.avg_product_cost DESC;

-- 2.4) Calculate the distribution of products requiring maintenance by category
SELECT
    COALESCE(category, 'Unknown') AS category,
    CASE 
        WHEN maintenance IS NULL THEN 'Unknown'
        WHEN maintenance = 'Yes' THEN 'Requires maintenance'
        ELSE 'No maintenance'
    END AS maintenance_status,
    COUNT(*) AS product_count,
    CAST(100.0 * COUNT(*)
        / SUM(COUNT(*)) OVER (PARTITION BY COALESCE(category, 'Unknown')) AS DECIMAL(10,2)) AS maintenance_category_percentage
FROM gold.dim_products
GROUP BY
  COALESCE(category, 'Unknown'),
  CASE WHEN maintenance IS NULL THEN 'Unknown' WHEN maintenance = 'Yes' THEN 'Requires maintenance' ELSE 'No maintenance' END
ORDER BY category, product_count DESC;