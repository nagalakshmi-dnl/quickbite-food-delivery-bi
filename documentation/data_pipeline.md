# QuickBite Food Delivery — Data Pipeline

## 1. Pipeline Overview

The QuickBite project follows a structured analytical pipeline:

```text
Raw Food Delivery Data
        ↓
MySQL Raw Layer
        ↓
Data Profiling
        ↓
Data Cleaning
        ↓
Feature Engineering
        ↓
Business / Gold Queries
        ↓
Data Validation & QA
        ↓
CSV Export for Power BI
        ↓
Power BI Data Model & DAX
        ↓
5-Page BI Dashboard
        ↓
Business Insights
```

## 2. Raw Layer

The original food delivery dataset is loaded into:

```text
order_history_raw
```

The raw layer preserves the source data before business transformations are applied.

The SQL project includes scripts for database creation, raw table creation, raw data loading and profiling.

## 3. Data Profiling

The profiling stage checks the structure and quality of the source data, including:

- Row counts
- Column structure
- Missing values
- Duplicate records
- Distinct values
- Status distributions
- Date and time fields
- Restaurant values
- Rating availability
- Operational fields

## 4. Clean / Silver Layer

The cleaned analytical table is:

```text
order_history_clean
```

Data cleaning includes standardizing fields, handling missing values and preparing fields for analytics.

Key engineered attributes include:

- `order_datetime`
- `order_date`
- `order_time`
- `order_year`
- `order_month`
- `month_name`
- `day_name`
- `order_hour`
- `meal_period`
- `delivery_partner`
- `distance_km`
- `rating_clean`
- `kpt_duration_clean`
- `rider_wait_time_clean`
- `total_discount`
- `net_revenue`
- `order_value_band`
- `weekend_flag`
- `peak_hour_flag`
- `feedback_given`
- `complaint_flag`
- `cancellation_flag`
- `cancellation_reason`

## 5. Feature Engineering Rules

### Meal Period

Orders are classified into:

- Breakfast
- Lunch
- Snacks
- Dinner
- Late Night

The final dataset did not contain Breakfast orders.

### Distance Standardization

Distance values are converted into numeric kilometers. Examples include:

```text
<1km → 0.50 km
3km  → 3.00 km
```

### Order Value Band

```text
Low     → order value < 300
Medium  → order value from 300 to 700
High    → order value > 700
```

### Weekend Flag

Orders are classified as:

```text
Weekday
Weekend
```

### Peak Hour Flag

Peak periods are:

```text
12:00–14:00
19:00–21:00
```

Other hours are classified as Normal.

### Complaint Flag

Blank or null complaint values are standardized as:

```text
No
```

An existing complaint is represented as:

```text
Yes
```

### Total Discount

The individual discount fields are combined using null-safe logic to create:

```text
total_discount
```

### Net Revenue

The order `total` is used as:

```text
net_revenue
```

## 6. Gold / Business Layer

The Gold layer consists of SQL business queries used to answer questions such as:

- Revenue by restaurant
- Revenue by month
- Revenue by meal period
- Revenue by order status
- Order value distribution
- Discount impact
- Customer ratings
- Customer complaints
- Delivery outcomes
- Kitchen preparation performance
- Rider wait time
- Peak-hour performance
- Cancellation reasons

## 7. Validation

SQL validation was performed before building the Power BI dashboard.

Examples of validated source metrics include:

- Total rows: 21,321
- Delivered orders: 21,131
- Rated orders: 2,491
- Total complaints: 469
- Average KPT: approximately 17.33
- Average rider wait: approximately 4.83
- Average delivery distance: approximately 4.17 km
- Delivery success rate: approximately 99.11%
- Actual cancellation rate: approximately 0.87%

## 8. Power BI Load

A cleaned CSV exported from the MySQL Result Grid was imported into Power BI because the direct MySQL-to-Power BI connection was not used in the final desktop workflow.

During CSV import, malformed records were removed. The final Power BI population was approximately 21,305 rows.

This population difference is documented and explains small differences between some MySQL source totals and Power BI totals.

## 9. Power BI Reporting Layer

The final Power BI report contains five pages:

1. Executive Overview
2. Revenue & Sales Analysis
3. Customer & Operations
4. Delivery Performance & Operational Efficiency
5. Insights & Business Recommendations

The report uses DAX measures for KPI calculations and interactive slicers for business analysis.
