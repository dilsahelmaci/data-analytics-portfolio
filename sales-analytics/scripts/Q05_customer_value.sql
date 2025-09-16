/*
===============================================================================
Q5. What is the value of our customers?

Purpose:
    - 5.1) Calculate customer lifetime value (CLV) for each customer.
    - 5.2) Perform cohort analysis based on customer signup year.

SQL Features Used:
    - SUM, COUNT, AVG
    - GROUP BY, ORDER BY
    - Window function: PERCENT_RANK
    - DATE function
    - CTEs
===============================================================================
*/
-- 5.1) Calculate customer lifetime value (CLV), total orders, and average order value per customer
SELECT
    c.customer_key, 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
    COALESCE(SUM(f.sales_amount), 0) AS total_revenue, 
    COUNT(DISTINCT f.order_number) AS total_orders, 
    CAST(COALESCE(CAST(SUM(f.sales_amount) AS DECIMAL(10,2)), 0)
         / NULLIF(COUNT(DISTINCT f.order_number), 0) AS DECIMAL(10,2)) AS avg_order_value
FROM gold.dim_customers c
LEFT JOIN gold.fact_sales f 
    ON c.customer_key = f.customer_key
GROUP BY c.customer_key, CONCAT(c.first_name, ' ', c.last_name)
ORDER BY total_revenue DESC, avg_order_value DESC; 

-- 5.2) Perform cohort analysis based on customer signup year
WITH base AS(
    SELECT
        c.customer_key, 
        YEAR(c.create_date) AS signup_year,
        COALESCE(SUM(f.sales_amount), 0) AS customer_revenue
    FROM gold.dim_customers c
    LEFT JOIN gold.fact_sales f
        ON c.customer_key = f.customer_key
    WHERE c.create_date IS NOT NULL
    GROUP BY c.customer_key, YEAR(c.create_date)
    )
SELECT 
    signup_year, 
    SUM(customer_revenue) AS total_revenue,
    COUNT(DISTINCT customer_key) AS total_customers,
    CAST(SUM(customer_revenue)
        / NULLIF(COUNT(DISTINCT customer_key), 0) AS DECIMAL(10,2)
    ) AS avg_revenue_per_customer
FROM base
GROUP BY signup_year
ORDER BY signup_year;