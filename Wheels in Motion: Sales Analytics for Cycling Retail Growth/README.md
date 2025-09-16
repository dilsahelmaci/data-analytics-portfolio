# 🚴🏻‍♀️ Wheels in Motion: Sales Analytics for Cycling Retail Growth

*Delivering actionable sales, customer, and product insights for cycling retail through advanced SQL analytics and in-depth business reporting.*

---

## 🚦 Project Summary

This project takes a deep dive into the sales, product, and customer data of a global cycling retailer by using advanced SQL analytics and a business-first mindset.  
By translating raw warehouse data into segmented insights, we reveal **what sells, who buys, and where the growth opportunities are**.  
From identifying best-selling bike categories and high-value customer cohorts, to highlighting seasonal demand patterns and operational bottlenecks, the analysis delivers a **full-cycle view of the business**.

**Each finding is designed to support smarter marketing, targeted merchandising, and more effective customer engagement so that decision-makers can turn data into real competitive advantage.**

---

**Data:**  
- CSV files (`gold.dim_customers.csv`, `gold.dim_products.csv`, `gold.fact_sales.csv`) from the [**golden layer**](https://github.com/DataWithBaraa/sql-data-analytics-project/tree/main/datasets/csv-files) of a modern data architecture, already curated and business-ready.

**Tech & Approach:**  
- SQL (Azure Data Studio) for all data analysis and reporting
- Advanced SQL features:  
  - Common Table Expressions (CTEs)  
  - Window functions (RANK, PERCENT_RANK, moving averages)  
  - Aggregation and segmentation  
  - Complex JOINs across normalized warehouse tables  
  - Cohort and lifetime value analysis  
  - Dynamic business logic with CASE statements  
  - Outlier and anomaly flagging for data errors, quality issues, and unexpected trends
- Outputs and insights based on table snapshots from SQL query results
- Structured, actionable reporting for business decision-makers

---

## 🌟 STAR Breakdown

### **SITUATION**
A global cycling retailer operates across multiple countries, selling everything from premium bikes to components, apparel, and accessories.  
The business needed segmented, actionable analytics to identify which products, customers, and geographies should drive their next stage of growth. This required targeted analysis; not just for reporting, but to support strategic, data-driven decision-making.

### **TASK**
- Map the customer base by geography, demographics, and engagement patterns
- Break down the product mix to identify both top and underperforming items
- Track sales trends across yearly, monthly, and seasonal cycles to highlight critical inflection points
- Surface high-value customer segments and drivers of repeat purchase
- Assess shipping efficiency and uncover data quality bottlenecks
- Deliver concrete recommendations for marketing, assortment, and operations strategy

### **ACTION**
- Wrote layered SQL queries for nine core business questions, leveraging CTEs, window functions, and grouping logic
- Produced clear tables and result snapshots (see `/reports/images`) for each sub-question to turn raw data into business stories
- Performed cohort, customer segment, and profitability analyses to reveal actionable patterns
- Spotted data quality issues (e.g., “Unknown” values) and highlighted critical gaps for the business team
- Summarized all findings in a detailed `/reports/report.md`, connecting every insight directly to business use cases

### **RESULT**
- **Market Leaders:** US, Australia, and UK account for more than 70% of customers and sales revenue.
- **Product Focus:** Bikes (especially road and mountain types) and Components are primary revenue drivers, while Accessories and Clothing support loyalty and margin growth.
- **Seasonal Cycles:** Sales peak in summer and at year-end, highlighting key promotional windows.
- **Customer Value:** Top buyers and early customers generate most of the revenue, while recent signups contribute less and are less loyal.
- **Segment Playbook:** Revenue is nearly balanced by gender; the 31–40 age group seems the most valuable segment across regions.
- **Operational Insights:** Uniform 7-day shipping delays suggest a need for deeper process tracking and possible efficiency improvements.
- **Data Quality:** Missing or ambiguous entries are flagged as unknown for future data quality improvement.

### **RECOMMENDATIONS**
- Prioritize marketing and inventory investment in core markets and best-selling products.
- Target mature customer segments with tailored offers; test strategies to grow engagement among younger and older age groups.
- Align promotions with seasonal peaks and use bundled offers to support sales in slower months.
- Address "n/a" data entries to enable sharper targeting and analytics.
- Upsell maintenance services and accessories to strengthen customer lifetime value.
- Enhance shipping data granularity to identify and address operational improvement opportunities.
---

## 📁 Project Structure
```
sales-analytics/
│
├── datasets/                                               # Source data (gold layer, business-ready)
│   ├── gold.dim_customers.csv                              # Customer dimension table
│   ├── gold.dim_products.csv                               # Product dimension table
│   └── gold.fact_sales.csv                                 # Fact table with all sales transactions
│
├── docs/                                                   # Documentation and supporting materials
│   └── data_catalog.md                                     # Data dictionary and column definitions
│
├── reports/                                                # Analytical outputs and visual summaries
│   ├── report.md                                           # Full business analysis and recommendations
│   └── images/                                             # Table snapshots and visual outputs per question
│       ├── Q01_1_customer_country_distribution.png
│       ├── Q01_2_customer_gender_distribution.png
│       ├── Q01_3_customer_marital_distribution.png
│       ├── Q01_4_customer_age_distribution.png
│       ├── Q02_1_product_distribution_bycategories.png
│       ├── Q02_2_product_distribution_bysubcategories.png
│       ├── Q02_3_product_stats_summary_bycategory.png
│       ├── Q02_4_product_maintanence_distribution.png
│       ├── Q03_1_total_sales_overview.png
│       ├── Q03_2_sales_byyear_trend.png
│       ├── Q03_3_sales_bymonth_trend.png
│       ├── Q03_4_sales_seasonality_trend.png
│       ├── Q04_1_revenue_bycustomers_top10.png
│       ├── Q04_2_revenue_bycategory.png
│       ├── Q04_3_revenue_bysubcategories_top10.png
│       ├── Q04_4_revenue_bycountry.png
│       ├── Q05_1_customer_lifetime_value.png
│       ├── Q05_2_customer_cohort_analysis.png
│       ├── Q06_1_yoy_sales_growth.png
│       ├── Q06_2_monthly_trend_movingaverage.png
│       ├── Q06_3_quarterly_trend_movingaverage.png
│       ├── Q06_4_average_order_value.png
│       ├── Q07_1_highvolume_lowrevenue_products.png
│       ├── Q07_2_repeat_purchase_bymaintenance.png
│       ├── Q07_3_category_profitability.png
│       ├── Q08_1_average_shipping_delay.png
│       ├── Q08_2_shipping_delay_bycategory_country.png
│       ├── Q09_1_revenue_bygender.png
│       ├── Q09_2_revenue_byagegroup.png
│       ├── Q09_3_revenue_bycountry.png
│       ├── Q09_4_category_preference_withincountry.png
│       └── Q09_5_contributing_customersegments_top10.png
│
├── scripts/                                                # Modular SQL scripts for each business question
│   ├── 00_init_database.sql
│   ├── 01_schema_exploration.sql
│   ├── Q01_customer_demographics.sql
│   ├── Q02_product_overview.sql
│   ├── Q03_sales_performance.sql
│   ├── Q04_top_customers_products.sql
│   ├── Q05_customer_value.sql
│   ├── Q06_sales_growth.sql
│   ├── Q07_product_profitability.sql
│   ├── Q08_operational_efficiency.sql
│   └── Q09_customer_segments.sql
│
└── README.md                                               # Project summary, approach, and STAR breakdown
```