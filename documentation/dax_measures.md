# QuickBite Food Delivery — DAX Measures

This document records the primary DAX measures used in the QuickBite Power BI dashboard.

> Note: The exact Power BI table name in the completed report may appear as `order_history_clean_`. The examples below use that final table name where applicable.

## 1. Core KPI Measures

### Total Orders

```DAX
Total Orders =
COUNT(order_history_clean_[order_id])
```

### Total Revenue

```DAX
Total Revenue =
SUM(order_history_clean_[net_revenue])
```

### Average Order Value

```DAX
Average Order Value =
AVERAGE(order_history_clean_[net_revenue])
```

### Average Rating

```DAX
Average Rating =
AVERAGE(order_history_clean_[rating_clean])
```

### Total Customers

```DAX
Total Customers =
DISTINCTCOUNT(order_history_clean_[customer_id])
```

### Total Restaurants

```DAX
Total Restaurants =
DISTINCTCOUNT(order_history_clean_[restaurant_name])
```

## 2. Customer & Operations Measures

### Total Complaints

```DAX
Total Complaints =
CALCULATE(
    COUNTROWS(order_history_clean_),
    order_history_clean_[complaint_flag] = "Yes"
)
```

### Average KPT

```DAX
Average KPT =
AVERAGE(order_history_clean_[kpt_duration_clean])
```

### Average Rider Wait

```DAX
Average Rider Wait =
AVERAGE(order_history_clean_[rider_wait_time_clean])
```

### Average Delivery Distance

```DAX
Average Delivery Distance =
AVERAGE(order_history_clean_[distance_km])
```

## 3. Delivery Performance

### Delivered Orders

```DAX
Delivered Orders =
CALCULATE(
    [Total Orders],
    order_history_clean_[order_status] = "Delivered"
)
```

### Delivery Success %

```DAX
Delivery Success % =
DIVIDE(
    [Delivered Orders],
    [Total Orders],
    0
)
```

## 4. Financial Measures

### Total Discounts

```DAX
Total Discounts =
SUM(order_history_clean_[total_discount])
```

### Revenue per Customer

```DAX
Revenue per Customer =
DIVIDE(
    [Total Revenue],
    [Total Customers]
)
```

## 5. Cancellation Measures

### Actual Cancellation Count

The project treats the following as actual cancellation reasons:

- Cancelled by Customer
- Cancelled by Zomato
- Merchant device issue
- Kitchen is full
- Items out of stock

```DAX
Actual Cancellation Count =
CALCULATE(
    COUNTROWS(order_history_clean_),
    order_history_clean_[cancellation_reason] IN {
        "Cancelled by Customer",
        "Cancelled by Zomato",
        "Merchant device issue",
        "Kitchen is full",
        "Items out of stock"
    }
)
```

### Actual Cancellation Rate

```DAX
Actual Cancellation Rate =
DIVIDE(
    [Actual Cancellation Count],
    [Total Order Count],
    0
)
```

## 6. Dashboard Usage

These measures support the five dashboard pages:

- Executive Overview
- Revenue & Sales Analysis
- Customer & Operations
- Delivery Performance & Operational Efficiency
- Insights & Business Recommendations

The measures are designed to respond to report filters and slicers such as:

- City
- Restaurant
- Month
- Order Status
- Delivery Partner
- Meal Period
- Peak Hour

## 7. Validation Approach

DAX KPI results were compared against MySQL source calculations during QA.

Small differences in some totals are expected because the final Power BI CSV contained approximately 21,305 records compared with 21,321 records in the MySQL source after malformed CSV records were removed.
