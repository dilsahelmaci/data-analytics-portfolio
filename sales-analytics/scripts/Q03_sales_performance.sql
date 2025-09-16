/*
===============================================================================
Q3. How are our sales performing overall?

Purpose:
    - 3.1) Calculate total revenue, number of orders, and total quantity sold.
    - Analyze sales trends over time:
        - 3.2) Yearly totals
        - 3.3) Monthly evolution (timeline view)
        - 3.4) Seasonality (month-of-year patterns across all years)

SQL Features Used:
    - SUM, COUNT, DISTINCT
    - GROUP BY, ORDER BY
    - DATE functions (YEAR, MONTH, DATETRUNC)
    - FORMAT (for labeling year-month)
===============================================================================
*/
-- 3.1) Calculate total revenue (total sales amount), number of orders, and quantity sold
SELECT 
    SUM(sales_amount) AS total_revenue,
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
ORDER BY total_revenue DESC; 

-- 3.2) Analyze sales trends by year
SELECT 
    YEAR(order_date) AS order_year,
    SUM(sales_amount) AS total_revenue,
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- 3.3) Analyze sales trends over time by month
SELECT
    FORMAT(DATETRUNC(month, order_date), 'yyyy-MM') AS order_year_month,
    SUM(sales_amount) AS total_revenue,
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(quantity) AS total_quantity 
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date); 

-- 3.4) Analyze sales seasonality across months (all years combined here)
SELECT 
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_revenue,
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY order_month;