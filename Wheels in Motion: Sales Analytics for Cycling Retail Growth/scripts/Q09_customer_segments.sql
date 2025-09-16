/*
===============================================================================
Q9. How do different customer segments behave?

Purpose:
    - Analyze revenue split across key demographics: 
        - 9.1) gender
        - 9.2) age group
        - 9.3) country
    - 9.4) Identify category preferences within each country.
    - 9.5) Highlight top contributing segments (gender-age-country) driving the most revenue

SQL Features Used:
    - SUM, COUNT
    - GROUP BY, ORDER BY, JOINs
    - CASE expressions (for age groups, normalization of Unknowns)
    - Window functions (SUM() OVER() for percentages)
===============================================================================
*/
-- Prepare common seg table for demographics
IF OBJECT_ID('tempdb..#seg') IS NOT NULL DROP TABLE #seg;

SELECT
    f.order_number,
    CAST(f.sales_amount AS DECIMAL(18,2)) AS sales_amount,
    CASE WHEN c.gender IS NULL OR c.gender = 'n/a' THEN 'Unknown' ELSE c.gender END AS gender,
    CASE WHEN c.country IS NULL OR c.country = 'n/a' THEN 'Unknown' ELSE c.country END AS country,
    p.category,
    CASE 
        WHEN c.birthdate IS NOT NULL AND f.order_date IS NOT NULL
        THEN DATEDIFF(year, c.birthdate, f.order_date)
        ELSE NULL
    END AS customer_age
INTO #seg
FROM gold.fact_sales AS f
JOIN gold.dim_customers AS c 
    ON f.customer_key = c.customer_key
JOIN gold.dim_products AS p 
    ON f.product_key  = p.product_key
WHERE f.order_date IS NOT NULL;

-- Prepare common seg_age table for age_group
IF OBJECT_ID('tempdb..#seg_age') IS NOT NULL DROP TABLE #seg_age;

SELECT
    order_number,
    sales_amount,
    gender,
    country,
    category,
    CASE 
        WHEN customer_age IS NULL THEN 'Unknown'
        WHEN customer_age < 20 THEN 'Under 20'
        WHEN customer_age BETWEEN 20 AND 30 THEN '20-30'
        WHEN customer_age BETWEEN 31 AND 40 THEN '31-40'
        WHEN customer_age BETWEEN 41 AND 50 THEN '41-50'
        WHEN customer_age BETWEEN 51 AND 60 THEN '51-60'
        ELSE 'Above 60'
    END AS age_group
INTO #seg_age
FROM #seg;

-- 9.1) Revenue split by gender
SELECT
    gender,
    SUM(sales_amount) AS total_revenue,
    CAST(
      100.0 * SUM(sales_amount)
      / NULLIF(SUM(SUM(sales_amount)) OVER (), 0)
      AS DECIMAL(5,2)
    ) AS percentage_of_total
FROM #seg_age
GROUP BY gender
ORDER BY total_revenue DESC;

-- 9.2) Revenue split by age group
SELECT
    age_group,
    SUM(sales_amount) AS total_revenue,
    CAST(
      100.0 * SUM(sales_amount)
      / NULLIF(SUM(SUM(sales_amount)) OVER (), 0)
      AS DECIMAL(5,2)
    ) AS percentage_of_total
FROM #seg_age
GROUP BY age_group
ORDER BY total_revenue DESC;

-- 9.3) Revenue split by country
SELECT
    country,
    SUM(sales_amount) AS total_revenue,
    CAST(
      100.0 * SUM(sales_amount)
      / NULLIF(SUM(SUM(sales_amount)) OVER (), 0)
      AS DECIMAL(5,2)
    ) AS percentage_of_total
FROM #seg_age
GROUP BY country
ORDER BY total_revenue DESC;

-- 9.4) Category preference within country
SELECT
    country,
    category,
    SUM(sales_amount) AS total_revenue,
    CAST(
      100.0 * SUM(sales_amount)
      / NULLIF(SUM(SUM(sales_amount)) OVER (PARTITION BY country), 0)
      AS DECIMAL(5,2)
    ) AS percentage_within_country
FROM #seg_age
GROUP BY country, category
ORDER BY country, percentage_within_country DESC;

-- 9.5) Top contributing customer segments (all combined)
SELECT TOP 10
    gender,
    age_group,
    country,
    SUM(sales_amount) AS total_revenue,
    CAST(
      100.0 * SUM(sales_amount)
      / NULLIF(SUM(SUM(sales_amount)) OVER (), 0)
      AS DECIMAL(5,2)
    ) AS percentage_of_total
FROM #seg_age
GROUP BY gender, age_group, country
ORDER BY total_revenue DESC;

-- Drop the temporary tables
DROP TABLE #seg;
DROP TABLE #seg_age;
