# 🏡 Beyond the Listings: A Deep Dive into Berlin’s Airbnb Landscape

*An end-to-end data wrangling and EDA project built to extract actionable insights from real-world Airbnb listings data.*

## 🎯 Project Overview

This project transforms a raw export of Berlin Airbnb listings into a streamlined, insight-rich dataset. By applying robust data cleaning and exploratory analysis techniques, the goal was to surface meaningful trends in pricing, location, host behavior, and guest demand—and ultimately to generate strategic recommendations for Airbnb stakeholders, hosts, and guests alike.

---

**Data Source:** [Get the Data | Inside Airbnb - Berlin Listings](http://insideairbnb.com/get-the-data.html)  
**Dataset:** `listings.csv` (as of March 15, 2025)  
**Tools Used:** Python · Pandas · Seaborn · Matplotlib · GeoPandas · Folium · Jupyter Notebooks

---

## 🌟 STAR Breakdown

### **SITUATION**

Inside Airbnb provided a raw dataset of **13,945 Airbnb listing entries** in Berlin, spanning **79 columns** including pricing, host details, location, amenities, and guest reviews. Although the dataset file was rich in data, the mixed formats, inconsistencies, and missing values in the dataset made it too unwieldy for direct analysis. Therefore, transformation into a concise, insightful format was necessary to enable us to explore pricing patterns, neighbourhood dynamics, and host strategies in Berlin’s Airbnb market.

### **TASK**
- Transform the raw dataset into a clean, analysis-ready dataset by selecting relevant columns/features, handling missing data, and engineering meaningful features.
- Performed a structured exploratory data analysis to:
  - Profile Berlin's Airbnb pricing landscape 
  - Analyze the impact of location, amenities, host experience, and room types on price and demand
  - Detect pricing anomalies and high-potential neighbourhoods
  - Deliver data-driven recommendations and insights for hosts, guests, and the Airbnb platform

### **ACTION**

#### 🧹 Notebook 1: Data Cleaning and Wrangling
- Selected **15 core business-relevant features** from the original 79 columns
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

#### 📊 Notebook 2: Exploratory Data Analysis (EDA)
- Analyzed listing statistics across districts and neighbourhoods to uncover spatial pricing trends and local market dynamics
- Explored key features:
  - **Districts & neighbourhoods** (spatial price variations and hidden gem areas)
  - **Room types** (price, popularity, availability trends)
  - **Superhost vs. regular hosts performance** (impact on demand and pricing)
  - **Amenity count & host experience** (correlations with price and reviews)
- Visualized with:
  - Histograms, boxplots, bar charts, scatter plots, and correlation heatmaps
  - Interactive Folium map with layered price choropleths and listing clusters

### **RESULT**
- Produced a **reproducible, cleaned dataset with 15 features along with strong analytical integrity**
- Delivered clear business insights:
  - **Price distribution:** The majority of listings fall within the €50–€150/night range. The market is right-skewed, with only a few luxury outliers above €500.
  - **Spatial trends:** Central districts like Mitte, Kreuzberg, and Pankow command the highest prices and listing densities, while outer areas like Marzahn-Hellersdorf and Reinickendorf offer affordability with lower supply.
  - **Neighbourhood insights:** Even within the same district, price variation exists—some local “hidden gems” combine low prices with high guest ratings.
  - **Supply vs. demand:** Listings and guest reviews are highly concentrated in central neighbourhoods, confirming strong demand alignment.
  - **Room types:** Entire homes dominate the market, while hotel rooms top the price scale. Shared rooms are rare, cheaper, and have higher availability.
  - **Superhost impact:** Superhosts represent about one-third of listings. They receive more bookings but do not charge substantially more.
  - **Amenities:** Listings with more amenities tend to command higher prices and attract more reviews. Essentials like Wi-Fi and kitchens are nearly universal; extras drive performance.
  - **Correlations:** Moderate negative correlations suggest listings with more reviews, better amenities, and experienced hosts tend to have lower availability, likely due to higher booking demand.

### **RECOMMENDATIONS**
- **For Hosts:** Prioritize essential and high-impact amenities, aim for superhost status, and benchmark pricing against local competition
- **For Guests:** Look beyond tourist centers—affordable “hidden gems” offer value with strong reviews and high ratings
- **For Airbnb:** Enhance amenity-based filters, refine dynamic pricing by district, and promote lesser-known but high-performing neighbourhoods

---

## 📁 Project Structure
```
├── data
│   └── listings.csv                          # Raw dataset from Inside Airbnb
│   └── listings_cleaned.csv                  # Cleaned, analysis-ready dataset
│   └── berlin_bezirke.geojson                # Berlin district boundaries used for spatial visualizations
│
├── images
│   └── berlin_folium_map.png                 # Static screenshot of the Folium map for GitHub rendering
│
├── notebooks
│   └── 01_data_cleaning_wrangling.ipynb      # Cleaning and preprocessing
│   └── 02_exploratory_data_analysis.ipynb    # EDA, visualizations, and interpretations
│
└── README.md                                 # Project summary and STAR breakdown
```
---

