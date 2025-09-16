/*
===============================================================================
Q1. Who are our customers?

Purpose:
    - 1.1) Identify which countries our customers come from.
    - Understand demographic distribution by 1.2) gender and 1.3) marital status.
    - 1.4) Group customers into main age brackets for segmentation.

SQL Features Used:
    - COUNT, GROUP BY, ORDER BY
    - Window function: SUM() OVER ()
    - CASE expressions
    - DATEDIFF
    - CTEs
===============================================================================
*/
-- 1.1) Identify which country our customers come from and their distribution
SELECT 
    CASE WHEN country IN ('n/a','NA','N/A','unknown') THEN 'Unknown' ELSE country END AS country,
    COUNT(*) AS customer_count,
    CAST(100.0 * COUNT(*)
        / SUM(COUNT(*)) OVER () AS DECIMAL(10,2)) AS customer_percentage
FROM gold.dim_customers
GROUP BY country
ORDER BY customer_percentage DESC; 

-- 1.2) Examine gender distribution of the customers
SELECT
    CASE WHEN gender IN ('n/a','NA','N/A','unknown') THEN 'Unknown' ELSE gender END AS gender, 
    COUNT(*) AS customer_count, 
    CAST(100.0 * COUNT(*)
        / SUM(COUNT(*)) OVER () AS DECIMAL(10,2)) AS gender_percentage
FROM gold.dim_customers
GROUP BY gender
ORDER BY gender_percentage DESC;

-- 1.3) Examine marital status of the customers
SELECT
    CASE WHEN marital_status IN ('n/a','NA','N/A','unknown') THEN 'Unknown' ELSE marital_status END AS marital_status, 
    COUNT(*) AS customer_count, 
    CAST(100.0 * COUNT(*)
        / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) AS marital_percentage
FROM gold.dim_customers
GROUP BY marital_status
ORDER BY marital_percentage DESC; 

-- 1.4) Identify age distribution of the customers
WITH customers_age AS(
SELECT
    customer_key,
    birthdate,
    -- Approximate ages based on year difference
    DATEDIFF(year, birthdate, GETDATE()) AS customer_age, 
    CASE 
        WHEN DATEDIFF(year, birthdate, GETDATE()) < 20 THEN 'Under 20'
        WHEN DATEDIFF(year, birthdate, GETDATE()) BETWEEN 20 AND 30 THEN '20-30'
        WHEN DATEDIFF(year, birthdate, GETDATE()) BETWEEN 31 AND 40 THEN '31-40'
        WHEN DATEDIFF(year, birthdate, GETDATE()) BETWEEN 41 AND 50 THEN '41-50'
        WHEN DATEDIFF(year, birthdate, GETDATE()) BETWEEN 51 AND 60 THEN '51-60'
        ELSE 'Above 60'
    END AS age_group
FROM gold.dim_customers
WHERE birthdate IS NOT NULL
)
SELECT 
    age_group,
    COUNT(*) AS customer_count,
    CAST(100.0 * COUNT(*)
        / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) AS age_group_percentage
FROM customers_age
GROUP BY age_group
ORDER BY age_group_percentage DESC; 