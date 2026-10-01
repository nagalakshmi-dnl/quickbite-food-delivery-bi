# QuickBite Food Delivery — Data Quality Notes

## 1. Purpose

This document records important data-quality observations, transformations and validation decisions made during the QuickBite project.

The goal is to make the analytical workflow transparent and reproducible.

## 2. Source vs Power BI Population

The MySQL source validation contained:

```text
21,321 rows
```

The final Power BI dataset contained approximately:

```text
21,305 rows
```

The difference occurred during CSV export/import because some records were malformed when parsed by the CSV workflow. Those error records were removed before the final Power BI dataset was used.

Therefore, some Power BI totals differ slightly from the original MySQL totals.

This is a documented data-ingestion limitation rather than an intentional change to the underlying business logic.

## 3. Restaurant Data Quality

The source data contained invalid values in the restaurant field that represented promotional text rather than restaurant names.

Examples included values similar to:

```text
60% off upto Rs.120
Buy 1 Get 1
Flat 15% off
```

These invalid restaurant values were filtered out in Power Query.

The final dashboard therefore uses six valid restaurants:

1. Aura Pizzas
2. Dilli Burger Adda
3. Masala Junction
4. Swaad
5. Tandoori Junction
6. The Chicken Junction

## 4. Order Value Band

Blank `order_value_band` values were removed from the Power BI reporting layer.

The classification used is:

```text
Low     < 300
Medium  300–700
High    > 700
```

## 5. Ratings

Most records do not contain a customer rating.

The cleaned rating field is therefore treated as numeric only where a valid rating is available.

The dashboard uses the average of valid `rating_clean` values rather than treating missing ratings as zero.

## 6. Items in Order

`items_in_order` contains menu-item descriptions.

It was intentionally kept as a text field.

A numeric `item_count` was not created because the source text does not provide a sufficiently reliable structured item count for this project.

## 7. Complaint Handling

Complaint values were standardized into a simple flag:

```text
Yes → complaint exists
No  → blank/null complaint treated as no complaint
```

Source validation identified:

```text
No  = 20,852
Yes = 469
```

## 8. Cancellation Handling

Cancellation was not inferred from every non-delivered status.

The project uses explicit cancellation reasons for the actual cancellation metric:

- Cancelled by Customer
- Cancelled by Zomato
- Merchant device issue
- Kitchen is full
- Items out of stock

Source validation identified 186 actual cancellation records, corresponding to an actual cancellation rate of approximately 0.87%.

The Power BI population difference results in a one-record difference in the displayed cancellation breakdown.

## 9. Delivery Partner

The cleaned dataset contains a single delivery partner category:

```text
Zomato Delivery
```

Because there was no meaningful multi-partner comparison, the original delivery-partner chart was removed and replaced with a customer feedback visual.

## 10. Data Validation

Key MySQL validation results included:

| Metric | Source Result |
|---|---:|
| Total rows | 21,321 |
| Delivered orders | 21,131 |
| Rated orders | 2,491 |
| Total complaints | 469 |
| Average KPT | 17.33 |
| Average rider wait | 4.83 |
| Average delivery distance | 4.17 km |
| Delivery success rate | 99.11% |
| Actual cancellation rate | 0.87% |

These values were used as reference points during Power BI QA.

## 11. Known Limitation

The final Power BI report is based on the cleaned CSV population rather than the complete 21,321-row MySQL population.

Consequently, small differences can appear between MySQL and Power BI for:

- Revenue totals
- Restaurant revenue
- Monthly revenue
- Order counts
- Customer counts
- Cancellation breakdowns

The calculations and DAX logic were validated; the differences are attributable to the documented Power BI data population difference.
