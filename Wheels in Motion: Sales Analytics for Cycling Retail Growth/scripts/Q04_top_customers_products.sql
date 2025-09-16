/*
===============================================================================
Q4. Which customers, products, and markets drive the most revenue?

Purpose:
    - 4.1) Identify the top 10 customers ranked by total sales revenue.
    - Determine which product 4.2) categories and 4.3) subcategories generate the most revenue.
    - 4.4) Measure revenue contribution by country.

SQL Features Used:
    - SUM
    - GROUP BY, ORDER BY
    - TOP (for ranking)
    - JOINs
    - COALESCE / NULLIF (to handle missing values)
===============================================================================
*/
-- 4.1) Identify the top 10 customers by total revenue
SELECT TOP 10
    c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(f.sales_amount) as total_revenue
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c 
    ON f.customer_key = c.customer_key
GROUP BY c.customer_key, CONCAT(c.first_name, ' ', c.last_name)
ORDER BY total_revenue DESC, customer_name; 

-- 4.2) Determine top categories by total revenue
SELECT
    COALESCE(p.category, 'Unknown') AS category,
    SUM(f.sales_amount) AS total_revenue,
    CAST(100.0 * SUM(f.sales_amount)
        / SUM(SUM(f.sales_amount)) OVER() AS DECIMAL(10,2)) AS category_percentage
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
    ON f.product_key = p.product_key
GROUP BY COALESCE(p.category, 'Unknown')
ORDER BY total_revenue DESC;

-- 4.3) Determine the top 10 subcategories by total revenue
SELECT TOP 10
    COALESCE(p.category, 'Unknown') AS category,
    COALESCE(p.subcategory, 'Unknown') AS subcategory,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
    ON f.product_key = p.product_key
GROUP BY COALESCE(p.category, 'Unknown'), COALESCE(p.subcategory, 'Unknown')
ORDER BY total_revenue DESC;

-- 4.4) Analyze revenue contribution by country
SELECT
    COALESCE(NULLIF(c.country, 'n/a'), 'Unknown') AS country,
    SUM(f.sales_amount) AS total_revenue, 
    CAST(100.0 * SUM(f.sales_amount)
        / SUM(SUM(f.sales_amount)) OVER() AS DECIMAL(10,2)) AS country_percentage
FROM gold.fact_sales f 
LEFT JOIN gold.dim_customers c 
    ON f.customer_key = c.customer_key
GROUP BY COALESCE(NULLIF(c.country, 'n/a'), 'Unknown')
ORDER BY total_revenue DESC; 