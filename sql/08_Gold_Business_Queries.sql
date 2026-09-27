/*=========================================================
Project : Food Delivery Business Intelligence Platform
Layer   : Gold Layer
File    : 08_Gold_Business_Queries.sql
Purpose : Business Intelligence Queries for Decision Making
Author  : Naga Lakshmi Devanaboina
=========================================================*/

-- SECTION 1 — Executive Dashboard KPIs

-- Total Orders

SELECT
COUNT(*) AS Total_Orders
FROM order_history_clean;

-- Total Revenue

SELECT
ROUND(SUM(net_revenue),2) AS Total_Revenue
FROM order_history_clean;

-- Average Order Value

SELECT
ROUND(AVG(net_revenue),2) AS Average_Order_Value
FROM order_history_clean;

-- Delivery Success Rate

SELECT

ROUND(
COUNT(CASE WHEN order_status='Delivered' THEN 1 END)
*100.0
/
COUNT(*),2
) AS Delivery_Success_Rate

FROM order_history_clean;

-- SECTION 2 — Revenue Analytics

-- Revenue by Meal Period

SELECT

meal_period,

COUNT(*) AS Orders,

ROUND(SUM(net_revenue),2) AS Revenue

FROM order_history_clean

GROUP BY meal_period

ORDER BY Revenue DESC;

-- Revenue by Order Value Band

SELECT

order_value_band,

COUNT(*) Orders,

ROUND(SUM(net_revenue),2) Revenue

FROM order_history_clean

GROUP BY order_value_band

ORDER BY Revenue DESC;

-- Discount Impact

SELECT

ROUND(SUM(total_discount),2) AS Total_Discount,

ROUND(AVG(total_discount),2) AS Average_Discount

FROM order_history_clean;

-- SECTION 3 — Restaurant Analytics

-- Top 10 Restaurants by Revenue

SELECT

restaurant_name,

COUNT(*) Orders,

ROUND(SUM(net_revenue),2) Revenue

FROM order_history_clean

GROUP BY restaurant_name

ORDER BY Revenue DESC

LIMIT 10;

-- Highest Rated Restaurants

SELECT

restaurant_name,

ROUND(AVG(rating_clean),2) Average_Rating,

COUNT(rating_clean) Reviews

FROM order_history_clean

WHERE rating_clean IS NOT NULL

GROUP BY restaurant_name

HAVING Reviews>=20

ORDER BY Average_Rating DESC;

-- Restaurants with Most Complaints

SELECT

restaurant_name,

COUNT(*) Complaints

FROM order_history_clean

WHERE complaint_flag='Yes'

GROUP BY restaurant_name

ORDER BY Complaints DESC;

-- SECTION 4 — Customer Analytics

-- Repeat Customers

SELECT

customer_id,

COUNT(*) Orders

FROM order_history_clean

GROUP BY customer_id

HAVING Orders>1

ORDER BY Orders DESC;

-- Customers by Order Value

SELECT

order_value_band,

COUNT(DISTINCT customer_id) Customers

FROM order_history_clean

GROUP BY order_value_band;

-- Feedback Rate

SELECT

feedback_given,

COUNT(*) Orders

FROM order_history_clean

GROUP BY feedback_given;

-- SECTION 5 — Delivery Analytics

-- Peak Hour Performance

SELECT

peak_hour_flag,

COUNT(*) Orders,

ROUND(AVG(kpt_duration_clean),2) Avg_KPT,

ROUND(AVG(rider_wait_time_clean),2) Avg_Rider_Wait

FROM order_history_clean

GROUP BY peak_hour_flag;

-- Delivery Performance by Meal Period

SELECT

meal_period,

ROUND(AVG(kpt_duration_clean),2) Avg_KPT,

ROUND(AVG(rider_wait_time_clean),2) Avg_Rider_Wait

FROM order_history_clean

GROUP BY meal_period;

-- Distance Analysis

SELECT

ROUND(distance_km,0) Distance,

COUNT(*) Orders

FROM order_history_clean

GROUP BY ROUND(distance_km,0)

ORDER BY Distance;

-- SECTION 6 — Cancellation Analytics

-- Cancellation Reasons

SELECT

cancellation_reason,

COUNT(*) Total

FROM order_history_clean

WHERE cancellation_reason IS NOT NULL

GROUP BY cancellation_reason

ORDER BY Total DESC;

-- Order Status Distribution

SELECT

order_status,

COUNT(*) Orders

FROM order_history_clean

GROUP BY order_status;

