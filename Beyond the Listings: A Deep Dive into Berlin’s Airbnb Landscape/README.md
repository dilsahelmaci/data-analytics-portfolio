# 🏡 Beyond the Listings: A Deep Dive into Berlin’s Airbnb Landscape

*An advanced data analytics project designed to uncover strategic insights from real-world Airbnb listings data.*

## 🎯 Project Overview

This project goes beyond basic exploration to **answer data-driven business questions** using Berlin’s Airbnb listings. Through thoughtful data cleaning, feature engineering, and in-depth analysis, the goal is to uncover pricing dynamics, host strategies, and neighborhood trends. The findings support **actionable recommendations** for Airbnb stakeholders, hosts, and guests alike.

---

**Data Source:** [Get the Data | Inside Airbnb - Berlin Listings](http://insideairbnb.com/get-the-data.html)  
**Dataset:** `listings.csv` (as of March 15, 2025)  
**Tools Used:** Python · Pandas · Seaborn · Matplotlib · GeoPandas · Folium · Jupyter Notebooks

---

## 🌟 STAR Breakdown

### **SITUATION**

Inside Airbnb provided a raw dataset of **13,945 Airbnb listing entries** in Berlin, spanning **79 columns** including pricing, host details, location, amenities, and guest reviews. Although the dataset file was rich in data, the mixed formats, inconsistencies, and missing values in the dataset made it unsuitable for direct business analysis. Therefore, substantial preprocessing and targeted analytics were required to generate actionable and data-driven insights. 

### **TASK**
- Transform the raw dataset into a clean, analysis-ready dataset by selecting relevant columns/features, handling missing data, and engineering meaningful features.
- Investigate specific business questions such as:
  - What drives price variation across Berlin?
  - Which amenities and host traits are linked to higher guest demand?
  - Where are the most underpriced or high-performing neighborhoods?
- Deliver clear, evidence-based recommendations for decision-makers in the Airbnb ecosystem

### **ACTION**

#### 🧹 Notebook 1: Data Cleaning and Feature Engineering
- Selected **15 strategically important features** from the original 79 columns
- Cleaned, formatted, and engineered new features:
  - Converted `price` strings to numeric values
  - Parsed `host_since` into a numerical `host_experience_years` feature
  - Transformed `amenities` string into structured `amenities_list`; computed `amenities_count`
  - Converted categorical fields (`room_type`, `neighbourhood_cleansed`, `neighbourhood_group_cleansed`) for efficient grouping
- Handled missing values using targeted imputation strategies:
  - Imputed `review_scores_rating` with median
  - Assumed missing `host_is_superhost` status as “False”
  - Removed rows with critical missing `price` data
- Flagged and removed extreme outliers (>99th percentile in price)
- Exported the cleaned, analysis-ready dataset as `listings_cleaned.csv` (8,898 entries)

#### 📊 Notebook 2: Business-Driven Data Analysis
- Addressed business-critical questions through structured analysis:
- Explored key features:
  - **Districts & neighbourhoods** (spatial price variations and hidden gem areas)
  - **Room types** (price, popularity, availability trends)
  - **Superhost vs. regular hosts performance** (impact on demand and pricing)
  - **Amenity count & host experience** (correlations with price and reviews)
- Used powerful visualizations:
  - Geospatial maps, distribution plots, category breakdowns, and correlation heatmaps
  - Interactive Folium map showing neighborhood-level pricing and listing density

### **RESULT**
- Produced a **reproducible, cleaned dataset with 15 features along with strong analytical integrity**
- Extracted and visualized key business insights:
  - **Price ranges:** The majority of listings fall within the €50–€150/night range. The market is right-skewed, with only a few luxury outliers above €500.
  - **Geographical insights:** Central districts like Mitte, Kreuzberg, and Pankow command the highest prices and listing densities, while outer areas like Marzahn-Hellersdorf and Reinickendorf offer affordability with lower supply.
  - **Hidden value:** Even within the same district, price variation exists—some local “hidden gems” combine low prices with high guest ratings.
  - **Supply vs. demand clusters:** Listings and guest reviews are highly concentrated in central neighbourhoods, confirming strong demand alignment.
  - **Room type trends:** Entire homes dominate the market, while hotel rooms top the price scale. Shared rooms are rare, cheaper, and have higher availability.
  - **Superhost impact:** Superhosts represent about one-third of listings. They receive more bookings but do not charge substantially more.
  - **Amenity impact:** Listings with more amenities tend to command higher prices and attract more reviews. Essentials like Wi-Fi and kitchens are nearly universal; extras drive performance.
  - **Correlations:** Moderate negative correlations suggest listings with more reviews, better amenities, and experienced hosts tend to have lower availability, likely due to higher booking demand.

### **RECOMMENDATIONS**
- **For Hosts:** Prioritize essential and high-impact amenities, aim for superhost status, and benchmark pricing against local competition
- **For Guests:** Look beyond tourist centers—affordable “hidden gems” offer value with strong reviews and high ratings
- **For Airbnb:** Enhance amenity-based filters, refine dynamic pricing by district, and spotlight undervalued but high-potential neighborhoods

---

## 📁 Project Structure
```
├── data
│   └── listings.csv                          # Raw dataset from Inside Airbnb
│   └── listings_cleaned.csv                  # Cleaned, analysis-ready dataset
│   └── berlin_bezirke.geojson                # Berlin district boundaries used for spatial visualizations
│
├── images
│   └── berlin_folium_map.png                 # Screenshot of the interactive Folium map for GitHub rendering
│
├── notebooks
│   └── 01_data_cleaning_wrangling.ipynb      # Cleaning and preprocessing
│   └── 02_business_analysis.ipynb            # Business-focused analysis and visualizations
│
└── README.md                                 # Project summary and STAR breakdown
```
---
### ⚠️ Copyright & Usage Notice

All code, analysis, and documentation in this repository are original work by me, Dilsah Nur Elmaci.

If you would like to reference, reuse, or learn from any part of this project, please **reach out or provide clear attribution**.  

I kindly ask that you do not copy or reproduce these materials without permission. Thank you for respecting my work! 💌

---
