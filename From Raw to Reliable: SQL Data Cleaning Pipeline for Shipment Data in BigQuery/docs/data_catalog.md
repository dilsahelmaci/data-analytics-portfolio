# 📖 Data Catalog — Shipments Cleaning Project

This document describes all fields present across the three layers of the Medallion architecture: the raw source data, the staging table, and the final fact view.

---

## 🥉 Raw Layer (Bronze) — `raw_shipments`

Direct copy of the source CSV. No transformations applied. All original quality issues are preserved here for auditability.

| Column | Type | Description |
|---|---|---|
| `shipment_id` | STRING | Unique identifier for each shipment (e.g. `SHP-1001`) |
| `origin_warehouse` | STRING | Name of the originating warehouse — inconsistent casing and whitespace in source |
| `destination_city` | STRING | City of delivery destination — inconsistent casing, whitespace, and some missing values |
| `destination_state` | STRING | US state abbreviation — inconsistent casing (e.g. `TX`, `tx`, `il`) |
| `carrier` | STRING | Freight carrier name — inconsistent casing across records |
| `ship_date` | STRING | Date shipment was sent — stored as string with six different format patterns |
| `delivery_date` | STRING | Date shipment was delivered — same format inconsistencies as `ship_date`; some missing |
| `weight_kg` | FLOAT | Shipment weight in kilograms — contains negative values and zeros used as placeholders |
| `freight_cost` | FLOAT | Cost of freight in USD — contains outliers and some missing values |
| `shipment_status` | STRING | Current status of the shipment — inconsistent casing (e.g. `Delivered`, `DELIVERED`, `delivered`) |
| `items_count` | INTEGER | Number of items in the shipment — contains negative values and zeros |
| `damage_reported` | STRING | Whether damage was reported (`Yes` / `No`) — stored as string with NULLs, empty strings, and literal `"NULL"` |

---

## 🥈 Staging Laye (Silver) — `stg_shipments`

Fully cleaned and standardised version of the raw data. Each column has been processed through nine sequential cleaning steps. The `shipment_status` column is dropped in this layer as it was not used in cleaning logic and is not carried into the fact layer.

| Column | Type | Description | Cleaning Applied |
|---|---|---|---|
| `shipment_id` | STRING | Unique shipment identifier | No changes |
| `origin_warehouse` | STRING | Warehouse name | Trimmed + INITCAP |
| `destination_city` | STRING | Delivery city | Trimmed + INITCAP; empty → `'Unknown'` |
| `destination_state` | STRING | US state abbreviation | Trimmed + UPPER; empty → `'Unknown'` |
| `carrier` | STRING | Carrier name | Trimmed + INITCAP |
| `damage_reported` | STRING | Damage flag (`Yes` / `No` / NULL) | Trimmed + INITCAP; empty strings and literal `'NULL'` → `NULL` |
| `ship_date` | DATE | Parsed ship date | Converted from STRING using 6 format patterns via `SAFE.PARSE_DATE`; unparseable → `NULL` |
| `delivery_date` | DATE | Parsed delivery date | Same as `ship_date` |
| `transit_days` | INTEGER | Days between ship and delivery | Calculated via `DATE_DIFF(delivery_date, ship_date, DAY)` |
| `data_quality_flag` | STRING | Date validation result | `'VALID'`, `'INVALID'`, `'SAME DAY DELIVERY'`, `'INVALID SHIP DATE'`, `'NOT DELIVERED OR INVALID DATE'` |
| `weight_kg` | FLOAT | Shipment weight (kg) | Negative → `ABS()`; zero → `NULL` |
| `items_count` | INTEGER | Number of items | Negative → `ABS()`; zero → `NULL` |
| `original_freight_cost` | FLOAT | Freight cost before outlier capping | Preserved for reference |
| `freight_cost` | FLOAT | Freight cost after outlier capping | Capped at IQR bounds (Winsorisation); negative → `ABS()` |
| `was_outlier` | BOOLEAN | Whether freight cost was an outlier | `TRUE` if original value was outside IQR bounds |

---

## 🥇 Fact Layer (Gold) — `fct_shipments`

A view built on top of `stg_shipments`. Exposes the clean columns and adds derived business metrics. Columns like `original_freight_cost` and `was_outlier` are excluded from this layer as they are internal pipeline audit fields.

| Column | Type | Description |
|---|---|---|
| `shipment_id` | STRING | Unique shipment identifier |
| `origin_warehouse` | STRING | Cleaned warehouse name |
| `destination_city` | STRING | Cleaned destination city |
| `destination_state` | STRING | Cleaned state abbreviation (uppercase) |
| `carrier` | STRING | Cleaned carrier name |
| `ship_date` | DATE | Parsed and validated ship date |
| `delivery_date` | DATE | Parsed and validated delivery date |
| `transit_days` | INTEGER | Number of days between ship and delivery |
| `data_quality_flag` | STRING | Date quality classification |
| `weight_kg` | FLOAT | Cleaned shipment weight (kg) |
| `items_count` | INTEGER | Cleaned number of items |
| `freight_cost` | FLOAT | Outlier-capped freight cost (USD) |
| `cost_per_kg` | FLOAT | Freight cost divided by weight — `ROUND(SAFE_DIVIDE(freight_cost, weight_kg), 2)` |
| `ship_month` | STRING | Month of shipment formatted as `YYYY-MM` — for time-series grouping |
| `delivery_speed` | STRING | Categorical delivery speed: `'Fast'` (≤2 days), `'Normal'` (≤5 days), `'Slow'` (>5 days), `'Unknown'` |
| `freight_cost_band` | STRING | Cost tier: `'Low Cost'` (<$50), `'Medium Cost'` (<$200), `'High Cost'` (≥$200) |

---

## ⚠️ Known Data Quality Issues (Raw Layer)

The following issues were identified in the raw source data and addressed in the staging layer:

- **6 different date formats** across `ship_date` and `delivery_date`
- **Negative weights** in 5 records; treated as data entry errors and corrected with `ABS()`
- **Negative item counts** in 6 records; same treatment
- **Zero weights and item counts** in several records; replaced with `NULL` as zeros are not meaningful for physical shipments
- **Duplicate shipments** — records with identical business keys but different `shipment_id` values; earliest ID retained
- **Impossible delivery dates** — delivery occurring before shipment; flagged as `'INVALID'` in `data_quality_flag`
- **Extreme freight cost outliers** — values of `$15,000` and `$11,312` identified via IQR; capped rather than deleted
- **Missing destination city or state** in a small number of records; replaced with `'Unknown'`
- **Literal string `"NULL"`** used in `damage_reported`; converted to proper `NULL`
