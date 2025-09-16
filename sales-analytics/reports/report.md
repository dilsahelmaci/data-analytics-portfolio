# 🚴🏻‍♀️ Sales Analytics Report

This sales analytics report provides a strategic overview of a cycling-focused retail business. The analysis reveals a mature, geographically diverse customer base, with the US, Australia, and UK as key markets. Bikes and Components dominate both revenue and product mix, with high-value models and seasoned customer cohorts leading sales. Seasonal patterns show strong peaks in summer and year-end months. Operational findings suggest improvement opportunities in data quality and shipping precision. These insights support focused strategies for customer engagement, product positioning, and long-term profitability.

---

## Q1. Who are our customers?

**Goal:** Understand customer demographics across geography, gender, marital status, and age groups.

### 1.1 [Customer distribution by country](images/Q01_1_customer_country_distribution.png)  
- The majority of customers are concentrated in the **United States**, then followed by **Australia** and **United Kingdom**.  
- Secondary market includes **France**, **Germany**, and **Canada**. 
- A small fraction of customers are marked as **Unknown**.

### 1.2 [Gender distribution](images/Q01_2_customer_gender_distribution.png)
- The customer base is almost perfectly balanced, with **males** (50.54%) and **females** (49.38%) making up nearly equal shares.

### 1.3 [Marital status distribution](images/Q01_3_customer_marital_distribution.png)
- The majority of customers are **married (~54.16%)**, while **single customers make up 45.84%**, which shows a fairly balanced customer demographics in terms of marital distribution.

### 1.4 [Age distribution](images/Q01_4_customer_age_distribution.png)
- The largest age group is **41–50 (34.55%)**, followed closely by **above 60 (32.56%)** and **51–60 (29.58%)**, while only **3.31% of customers fall in the 31–40 age group**.

**Recommendations (Q1):**
- **Prioritize core markets** like the **US, Australia, and UK**, where most customers are concentrated.  
- **Develop campaigns for mature age groups (40+)**, who represent over **95%** of the customer base.  
- **Maintain a neutral, inclusive brand tone** to engage both **male and female** customers equally.  
- **Improve data completeness** by resolving unknown entries (e.g., country, gender), which limits targeting precision.  
- **Explore segmented messaging** for **married vs. single customers** to increase personalization and conversion.

---

## Q2. What products do we sell?

**Goal:** Explore product distribution, pricing characteristics, and maintenance requirements.

### 2.1 [Product distribution by category](images/Q02_1_product_distribution_bycategories.png)
- The **Components** category makes up the largest share of products (**43.05%**, 127 products), followed by **Bikes** (**32.88%**, 97 products).
- **Clothing** (**11.86%**) and **Accessories** (**9.83%**) contribute smaller but notable portions to the product catalog.
- A small percentage (**2.37%**) of products are listed under **Unknown**, possibly indicating potential data quality issues.

### 2.2 [Product distribution by subcategory](images/Q02_2_product_distribution_bysubcategories.png)
- **Road Bikes (14.58%)**, **Mountain Bikes (10.85%)**, and **Touring Bikes (7.46%)** make up the majority of products within the **Bike** category, reflecting strong product variety in core bike offerings.
- In the **Components** category, top subcategories include **Road Frames (11.19%)**, **Mountain Frames (9.49%)**, and **Touring Frames (6.10%)**, followed by items like **Wheels (4.75%)**, **Saddles (3.05%)**, and **Handlebars (2.71%)**.
- **Clothing** is mostly composed of **Jerseys (2.71%)**, **Shorts (2.37%)**, and **Gloves (2.03%)**, with other apparel like Socks, Tights, and Bib-Shorts each contributing around ~1%.
- Within **Accessories**, the most prominent are **Tires and Tubes (3.73%)**, while other subcategories like **Helmets**, **Bottles and Cages**, **Lights**, and **Bike Stands** each contribute approximately 1% or less.
- A small fraction of items (2.37%) are categorized under **Unknown**, indicating potential data cleaning opportunities.

### 2.3 [Product cost statistics by category](images/Q02_3_product_stats_summary_bycategory.png)
- **Bikes** have the highest average product cost at **949.44**, with prices ranging from **295.00** to **2171.00**, and a large standard deviation of **587.83**, indicating wide pricing variety across bike models.
- **Components** come next with an average of **264.72**, ranging from **0.00** (likely an error or placeholder) to **869.00**, and also show significant price variability (**std: 266.95**).
- **Clothing** and **Accessories** are low-cost categories, with average costs of **24.80** and **13.17**, respectively, and narrow price ranges suitable as entry-level or cross-sell items.
- The **Unknown** category includes 7 products (avg: **28.57**) with low price spread (**std: 8.06**), suggesting these are low-cost items but **lack proper categorization**.

### 2.4 [Maintenance requirement distribution](images/Q02_4_product_maintanence_distribution.png)
- **Most Accessories** require maintenance (**75.86%**), though **24.14%** are maintenance-free.
- **All Bikes (100%) require maintenance**, which aligns with expectations given their mechanical nature.
- **Clothing** is entirely maintenance-free (**100%**).
- **Components** also show a high need for maintenance (**84.25%**, 107 out of 127), confirming their technical role in the product ecosystem.
- The **Unknown** category again contains 7 entries, all with undefined maintenance status, indicating missing data that should be cleaned or clarified.

**Recommendations (Q2):**
- Focus on **Bikes and Components**, the largest and highest-value categories, for premium positioning and upsell opportunities.
- Use **Clothing and Accessories** as affordable entry points or cross-sell items.
- Offer **maintenance plans** for high-maintenance products (Bikes, Components) to drive repeat business.
- **Recategorize unknown product labels** to improve catalog accuracy.
- Highlight top subcategories (e.g., **Road Bikes**, **Road Frames**, **Tires and Tubes**) in targeted campaigns.
- Review pricing anomalies (e.g., **0.00 costs**) to correct potential data issues.

---

## Q3. How are our sales performing overall?

**Goal:** Assess overall revenue, order activity, and temporal patterns.

### 3.1 [Total sales overview](images/Q03_1_total_sales_overview.png)  
- Total revenue is approximately **29.36M**, with **27,659 orders** placed and **60,423 items** sold.

### 3.2 [Yearly sales trend](images/Q03_2_sales_byyear_trend.png)
- Revenue grew significantly from **43.4K in 2010** to a peak of **16.34M in 2013**, reflecting rapid business expansion.
- In **2014**, revenue sharply declined to **45.6K**, which likely indicates **incomplete or early-year data** rather than an actual slowdown.

### 3.3 [Monthly sales trend](images/Q03_3_sales_bymonth_trend.png)  
- Sales consistently **peak between May and August**, especially in **2013**, where revenue reached over **1.6M–1.7M per month** during these months.
- In contrast, **winter months like December to February** generally show **lower revenue**, such as **December 2012 (~624K)** and **January 2013 (~857K)**.
- This clear pattern suggests strong **seasonality aligned with warmer months**, typical for cycling-related sales.
- **Small note:** The sharp decline seen in **2014** is due to having only **January data**, and should not be interpreted as a business downturn.

### 3.4 [Seasonality sales trend](images/Q03_4_sales_seasonality_trend.png)  
- Contrary to typical expectations for cycling-related products, **December leads with the highest revenue (3.21M)**, followed by **November (2.98M)** and **October (2.92M)**, highlighting a **strong end-of-year sales surge**, possibly due to **holiday promotions** or **year-end discounts**.  
- **June (2.94M)** and **July (2.41M)** also show high performance, aligning with **seasonal outdoor activity peaks**.  
- **January (1.87M)** and **February (1.74M)** report the **lowest revenue**, suggesting **weaker post-holiday demand**.

**Recommendations (Q3):**
- Align **inventory planning and marketing campaigns** with peak periods, especially **summer (May–August)** and **year-end (Oct–Dec)**.
- Investigate the **year-end sales surge**, such as discounts or holiday demand, and consider making it a recurring strategy.
- Boost sales during **off-peak months** (Jan–Feb) using targeted **promotions or bundled offers**.
- **Would be better to exclude 2014** from annual trend analysis, as it contains **only January data**, which could mislead performance evaluations.

---

## Q4. Which customers, products, and markets drive the most revenue?

**Goal:** Identify key revenue drivers across customers, products, and geographies.

### 4.1 [Top 10 customers](images/Q04_1_revenue_bycustomers_top10.png)
- Top 10 customers each generate around **13K in revenue**, with the highest at **13,294**.
- Collectively, these top customers contribute about **132K**, accounting for **~0.45% of total revenue**.

### 4.2 [Revenue by category](images/Q04_2_revenue_bycategory.png) 
- Bikes generate the highest revenue at 28.32M, making them the dominant product category (96.46%).
- Accessories (0.70M) and Clothing (0.34M) contribute significantly less, suggesting their role is more complementary.

### 4.3 [Revenue by subcategory](images/Q04_3_revenue_bysubcategories_top10.png)  
- **Road Bikes (14.52M)** and **Mountain Bikes (9.95M)** are the top-performing subcategories by revenue, followed by **Touring Bikes (3.84M)**.
- These **high-value bike models** contribute significantly to total revenue, far outpacing Accessories and Clothing. 

### 4.4 [Revenue by country](images/Q04_4_revenue_bycountry.png)
- **United States (9.16M)** and **Australia (9.06M)** are the top revenue-generating markets, followed by the **United Kingdom (3.39M)**, collectively account for 73.62% of the total revenue.
- **Germany (2.89M)**, **France (2.64M)**, and **Canada (1.98M)** contribute moderately.
- A small portion of revenue (**226.8K**) is attributed to entries with **unspecified country data**, which may limit precise regional strategy and market segmentation.

**Recommendations (Q4):**
- **Double down on bike sales**, especially **high-value models** like Road and Mountain Bikes, which dominate revenue.
- **Retain high-spending customers** through loyalty programs or exclusive offers to encourage repeat purchases.
- **Leverage strong markets** like the US, Australia, and the UK with localized campaigns and regional partnerships.
- **Explore growth opportunities** in underperforming but promising markets like Germany, France, and Canada.
- **Address missing country data** to sharpen market insights and improve geo-targeted strategies.

---

## Q5. What is the value of our customers?

**Goal:** Understand customer-level profitability and repeat patterns.

### 5.1 [Customer lifetime value](images/Q05_1_customer_lifetime_value.png)
- The top customer has a total CLV of **13,294**, based on **5 orders** and an average order value of **2,659**.
- The top 10 customers each have CLVs ranging from **9,702** to **13,294**.

### 5.2 [Cohort analysis by signup year](images/Q05_2_customer_cohort_analysis.png)
- The **2008 cohort** generated **11.1M** in revenue from **4,352 customers**, averaging **2,551 per customer**, suggesting strong long-term value.
- The **2009 cohort** brought in **18.25M** from **14,132 customers**, with a lower average revenue per customer (**1,291**), indicating broader reach but lower individual value.
- **Older cohorts still deliver strong revenue per customer**, while later cohorts show a decline, possibly due to **lower retention or engagement levels**.

**Recommendations (Q5):**
- Focus on **retaining high-CLV customers** through personalized engagement or loyalty initiatives.
- Investigate why **recent cohorts show lower average revenue per customer**, and consider improving **onboarding, product fit**, or **post-sale engagement** to increase long-term value.
---

## Q6. Are our sales growing?

**Goal:** Measure growth patterns at yearly, monthly, and quarterly levels.

### 6.1 [Year-over-year (YoY) growth](images/Q06_1_yoy_sales_growth.png) 
- Revenue grew from **43.4K in 2010** to **16.34M in 2013**, with the **highest YoY increase in 2013 (179.8%)**.
- **2012 saw a -17.4% decline**, breaking the early growth trend.
- The **-99.7% drop in 2014** is expected due to having data only for **January**, not reflective of actual performance.

### 6.2 [Monthly trends with moving average](images/Q06_2_monthly_trend_movingaverage.png) 
- Monthly revenue peaked at **1.87M in December 2013**, with consistently high values from **May to October 2013**.
- The **3-month moving average** reached its highest at **1.72M in December 2013**, confirming a strong upward trend toward year-end.
- Seasonal **summer peaks** (June–August) are clearly visible each year.
- The **3-month moving average** minimizes short-term fluctuations and clearly highlights recurring **seasonal upswings** in revenue performance.

### 6.3 [Quarterly trends with moving average](images/Q06_3_quarterly_trend_movingaverage.png)
- The **4-quarter moving average** rose steadily from **2010-Q4 (43.4K)** to **2011-Q4 (17.69M)**, indicating strong early growth.
- From **2012-Q1 (17.57M)** to **2012-Q4 (14.61M)**, the moving average **declined consistently**, signaling a slowdown.
- In **2013**, growth resumed, reaching a peak of **40.86M** by **2013-Q4**.
- A sharp drop to **34.28M in 2014-Q1** reflects **incomplete data**, as only one month was recorded.

### 6.4 [Average order value](images/Q06_4_average_order_value.png)
- The **average order value (AOV)** is **1,061**, based on **29.35M total revenue** and **27,657 orders**.
- This figure represents the typical amount spent per order across the entire dataset.

**Recommendations (Q6):**
- **Capitalize on strong seasonal patterns** by aligning promotions, product launches, and inventory planning with the **May–October peak months**.
- **Investigate the 2012 slowdown** to identify potential operational or market issues that may reoccur.
- **Maintain focus on order value stability** by ensuring product bundling and upselling strategies do not compromise average spend per order.
---

## Q7. Which products are underperforming or drive long-term value?

**Goal:** Detect low-margin products, repeat behavior, and category profitability.

### 7.1 [High-volume, low-revenue products](images/Q07_1_highvolume_lowrevenue_products.png)
- All listed **Mountain Bikes** variants (e.g., *Mountain-100 Silver* and *Mountain-100 Black*) show **high sales volumes**, with quantities between **36 and 58 units**.
- Despite similar volumes, their **revenue contribution varies** widely, suggesting price differences or potential margin variance.

### 7.2 [Repeat-purchase by maintenance flag](images/Q07_2_repeat_purchase_bymaintenance.png) 
- **Maintenance subcategories** like *Road Bikes* (26.1%), *Mountain Bikes* (21.4%), and *Tires and Tubes* (9.4%) show the **highest repeat purchase rates**.
- In contrast, most **non-maintenance items** (e.g., *Shorts*, *Fenders*, *Vests*) have **repeat rates below 1%**.
- This actually indicates that **maintenance-related products drive stronger long-term engagement** and recurring customer behavior.
### 7.3 [Category profitability](images/Q07_3_category_profitability.png)
- **Bikes** generate the highest **revenue (28.31M)** and **gross margin (11.11M)** but have the **lowest margin rate (39.2%)**.
- **Accessories** yield the **highest margin rate (62.8%)** despite lower revenue, indicating efficient profitability.
- **Clothing** shows a moderate margin rate of **40.2%**, contributing to overall profit mix with fewer orders.

**Recommendations (Q7):**
- **Reassess pricing and cost structure** of high-volume Mountain Bikes to optimize profitability across variants.
- **Prioritize maintenance-related products** (e.g., Road and Mountain Bikes, Tires) in retention strategies due to their higher repeat purchase rates.
- **Leverage high-margin Accessories** in promotions or bundles to enhance profit without significantly raising volume.

---

## Q8. How efficient are our operations?

**Goal:** Assess shipping efficiency and highlight bottlenecks.

### 8.1 [Average shipping delay](images/Q08_1_average_shipping_delay.png) 
- All **60,379 order lines** include valid delay data, avergaing **7.0 days**.
- No missing records, but delay duration suggests room for operational improvement.

### 8.2 [Longest delays by category & country](images/Q08_2_shipping_delay_bycategory_country.png)
- All orders show a **uniform 7-day delay**, with no variation across product categories or countries.
- This suggests either **standardized delivery times** or **incomplete operational granularity**.
- In real-world scenarios, this analysis would help pinpoint **logistics bottlenecks** by region or product line.

**Recommendations (Q8):**
- **Reevaluate the fixed 7-day delivery window** for improvement opportunities.  
- Improve **data granularity** to detect actual operational delays.  
- Ensure accurate delay tracking across regions and products.
---

## Q9. How do different customer segments behave?

**Goal:** Compare demographics and preferences across segments.

### 9.1 [Revenue by gender](images/Q09_1_revenue_bygender.png)
- Revenue is nearly evenly split: **Female (50.4%)**, **Male (49.5%)**.  
- Only **0.1%** of revenue comes from customers with **unknown gender**.

### 9.2 [Revenue by age group](images/Q09_2_revenue_byagegroup.png)
- **31–40** is the top revenue group (**38.6%**), followed by **41–50 (27.8%)**.  
- Customers **under 30** and **above 60** contribute less than **18% combined**.  
- **Unknown age group** accounts for only **0.2%** of revenue.

### 9.3 [Revenue by country](images/Q09_3_revenue_bycountry.png)  
- **United States (31.22%)** and **Australia (30.87%)** lead revenue contribution.  
- The **UK (11.55%)**, **Germany (9.86%)**, and **France (9.0%)** follow as mid-tier markets.  
- **Canada (6.74%)** shows moderate engagement compared to other countries.  

### 9.4 [Category preference within countries](images/Q09_4_category_preference_withincountry.png)  
- **Bikes dominate across all countries**, contributing over **90.00%** of revenue in most markets.  
- **Australia (97.70%)** and **Germany (97.04%)** are the most bike-heavy regions. Also, in **France (96.59%)** and **United Kingdom (96.79%)**, bikes are the primary revenue driver.
- In general, **Accessories and Clothing** play a **minor role**. 

### 9.5 [Top contributing customer segments](images/Q09_5_contributing_customersegments_top10.png)
- Leading contributors are **females aged 31–40 in Australia (6.66%)** and **males aged 31–40 in Australia (5.92%)**.  
- The **31–40 age group** dominates across both genders and countries, especially in **Australia** and the **United States**.

**Recommendations (Q9):**
- Prioritize the **31–40 age group** in marketing campaigns, especially in **Australia** and the **United States**, where revenue concentration is highest.
- Maintain balance in gender-targeted strategies.
- Explore growth opportunities in **younger (<30)** and **older (>60)** segments through tailored promotions or product offerings.
- **Bikes dominate** across all countries; consider **diversifying product mix** to boost **Accessories and Clothing** performance as well.

---
## Final Strategic Recommendations

**Dominate Core Markets with Targeted Growth**
 - Intensify marketing and assortment on Road and Mountain Bikes in the US, Australia, and UK, leveraging region-specific campaigns.
- Pursue share gains in Germany and France using performance analytics and partnerships to unlock hidden demand.

**Power Segmentation with Advanced Analytics**
- Make **31–40 age group** the primary target while keeping campaigns gender-balanced.
 - Integrate behavioral insights to personalize offers and messaging across cohorts, driving CLV expansion and loyalty.

**Maximize Margins Through Seasonal Planning**
- Use dynamic forecasting models to optimize inventory for summer and year-end surges.
- Pilot time-limited bundles and exclusive product launches in slower months (Jan–Feb), leveraging historical sales data for tactical promotions.

**Champion Data Quality for Competitive Advantage**
- Implement automated data quality checks (e.g., duplicate detection, missing attributes) and real-time data lineage mapping to ensure analytic reliability.
- Standardize country, category, and shipping metrics, and create a single source of truth to accelerate decision speed and reduce operational risk.

**Drive Recurring Value with Product Innovation**
- Launch subscription-based maintenance packages and up-sell high-margin Accessories, targeting segments with high repeat rates.
- Apply learnings from cohort analysis to improve onboarding, retention, and customer advocacy.

---
