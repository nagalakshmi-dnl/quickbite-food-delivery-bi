# QuickBite Food Delivery — Data Dictionary

## 1. Purpose

This document describes the main fields used in the QuickBite Food Delivery Business Intelligence project.

The project uses a layered data approach:

- **Raw layer:** `order_history_raw`
- **Clean / Silver layer:** `order_history_clean`
- **Business / Gold layer:** SQL business queries and validation outputs
- **BI layer:** Power BI dashboard

The Power BI dataset was loaded from the cleaned CSV exported from MySQL.

## 2. Core Order Fields

| Field | Description | Usage |
|---|---|---|
| `order_id` | Unique identifier for an order | Order counting and transaction-level analysis |
| `customer_id` | Customer identifier | Customer count and customer-level analysis |
| `restaurant_name` | Restaurant associated with the order | Restaurant revenue, complaints, ratings and operational analysis |
| `city` | Order city | Geographic filtering and analysis |
| `order_status` | Current order outcome/status | Delivery outcome and revenue analysis |
| `delivery_partner` | Delivery partner associated with the order | Delivery-partner analysis |
| `order_datetime` | Combined order date and time | Time-based analysis |
| `order_date` | Date portion of the order timestamp | Daily and monthly trends |
| `order_time` | Time portion of the order timestamp | Hour-level analysis |
| `order_year` | Year derived from the order date | Year filtering |
| `order_month` | Numeric month derived from the order date | Monthly analysis |
| `month_name` | Month name derived from the order date | Monthly dashboard visuals |
| `day_name` | Day name derived from the order date | Day-level analysis |
| `order_hour` | Hour extracted from order time | Hourly and peak-hour analysis |

## 3. Business Classification Fields

| Field | Description | Business Logic |
|---|---|---|
| `meal_period` | Classifies the order into a meal period | Breakfast, Lunch, Snacks, Dinner, Late Night |
| `order_value_band` | Groups orders by total order value | Low < 300; Medium 300–700; High > 700 |
| `weekend_flag` | Identifies weekend orders | Weekend / Weekday |
| `peak_hour_flag` | Identifies peak operating periods | Peak for 12–14 and 19–21; otherwise Normal |
| `feedback_given` | Indicates whether customer feedback was recorded | Yes / No |
| `complaint_flag` | Standardized complaint indicator | Yes when a complaint exists; otherwise No |
| `cancellation_flag` | Indicates cancellation classification | Derived from cancellation information |
| `cancellation_reason` | Specific reason for an actual cancellation | Customer, Zomato, merchant/device, kitchen capacity or stock-related reasons |

## 4. Operational Fields

| Field | Description | Usage |
|---|---|---|
| `distance_km` | Standardized delivery distance in kilometers | Delivery distance analysis |
| `kpt_duration_clean` | Cleaned Kitchen Preparation Time | Kitchen efficiency analysis |
| `rider_wait_time_clean` | Cleaned rider waiting time | Delivery operations analysis |
| `rating_clean` | Cleaned customer rating | Customer satisfaction analysis |
| `items_in_order` | Text description of menu items in the order | Kept as text; not treated as a numeric item count |

## 5. Financial Fields

| Field | Description | Usage |
|---|---|---|
| `total` | Original order total | Revenue analysis |
| `restaurant_discount_promo` | Restaurant promotional discount | Discount analysis |
| `restaurant_discount_flatoffs` | Restaurant flat-off discount | Discount analysis |
| `gold_discount` | Gold membership discount | Discount analysis |
| `brand_pack_discount` | Brand/package discount | Discount analysis |
| `total_discount` | Combined discount amount | Discount investment analysis |
| `net_revenue` | Revenue field used by the BI layer | Revenue and KPI calculations |

### Total Discount Logic

`total_discount` is calculated as the sum of the available discount components using null-safe handling:

```text
restaurant_discount_promo
+ restaurant_discount_flatoffs
+ gold_discount
+ brand_pack_discount
```

## 6. Data Quality Notes

The Power BI dataset was loaded from a CSV exported from MySQL. During CSV parsing, malformed records were removed before the final Power BI import.

Therefore:

- MySQL source validation contains **21,321** rows.
- The final Power BI dataset contains approximately **21,305** rows.
- Some Power BI totals differ slightly from the original MySQL totals because of this documented population difference.
- `items_in_order` remains a text field because it contains menu descriptions rather than a reliable numeric item count.
