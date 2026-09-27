/*QA Step 1 — Total Orders*/

SELECT COUNT(*) AS total_orders
FROM order_history_clean;

/*QA Step 2 — Total Revenue*/

SELECT 
    SUM(total) AS total_revenue
FROM order_history_clean;

/*QA Step 3 — Average Order Value*/

SELECT
    SUM(total) / COUNT(*) AS average_order_value
FROM order_history_clean;

/*QA Step 4 — Average Rating*/

SELECT
    AVG(rating_clean) AS average_rating
FROM order_history_clean
WHERE rating_clean IS NOT NULL;

/*QA Step 5 — Total Customers*/

SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM order_history_clean;

/*QA Step 6 — Total Restaurants*/

SELECT
    COUNT(DISTINCT restaurant_name) AS total_restaurants
FROM order_history_clean;
/*Step 6A — Identify the difference*/
SELECT DISTINCT restaurant_name
FROM order_history_clean
ORDER BY restaurant_name;

/*QA Step 7 — Total Discounts*/

SELECT
    SUM(total_discount) AS total_discounts
FROM order_history_clean;

/*QA Step 8 — Total Complaints*/

SELECT
    COUNT(*) AS total_complaints
FROM order_history_clean
WHERE complaint_flag = 'Yes';

/*QA Step 9 — Delivery Success Rate*/

SELECT
    COUNT(*) AS delivered_orders,
    (SELECT COUNT(*) FROM order_history_clean) AS total_orders,
    COUNT(*) / (SELECT COUNT(*) FROM order_history_clean) * 100 AS delivery_success_rate
FROM order_history_clean
WHERE order_status = 'Delivered';

/*QA Step 10 — Actual Cancellation Rate*/

SELECT
    COUNT(*) AS actual_cancellations,
    (SELECT COUNT(*) FROM order_history_clean) AS total_orders,
    COUNT(*) / (SELECT COUNT(*) FROM order_history_clean) * 100 AS cancellation_rate
FROM order_history_clean
WHERE cancellation_reason IN (
    'Cancelled by Customer',
    'Cancelled by Zomato',
    'Merchant device issue',
    'Kitchen is full',
    'Items out of stock'
);

/*QA Step 11 — Average KPT*/

SELECT
    AVG(kpt_duration_clean) AS average_kpt
FROM order_history_clean
WHERE kpt_duration_clean IS NOT NULL;

/*QA Step 12 — Average Rider Wait Time*/

SELECT
    AVG(rider_wait_time_clean) AS average_rider_wait
FROM order_history_clean
WHERE rider_wait_time_clean IS NOT NULL;

/*QA Step 13 — Average Delivery Distance*/

SELECT
    AVG(distance_km) AS average_delivery_distance
FROM order_history_clean
WHERE distance_km IS NOT NULL;

/*QA Step 14 — Revenue per Customer*/

SELECT
    SUM(net_revenue) / COUNT(DISTINCT customer_id) AS revenue_per_customer
FROM order_history_clean;

/*QA Step 15 — Total Revenue on the Revenue & Sales page*/

SELECT
    SUM(net_revenue) AS total_revenue
FROM order_history_clean;

/*QA Step 16 — Total Orders by Delivery Outcome*/

SELECT
    order_status,
    COUNT(*) AS order_count
FROM order_history_clean
GROUP BY order_status
ORDER BY order_count DESC;

/*QA Step 17 — Orders by Meal Period*/

SELECT
    meal_period,
    COUNT(*) AS order_count
FROM order_history_clean
GROUP BY meal_period
ORDER BY order_count DESC;

/*QA Step 18 — Order Value Band*/

SELECT
    order_value_band,
    COUNT(*) AS order_count
FROM order_history_clean
GROUP BY order_value_band
ORDER BY order_count DESC;

-- and -- for check of missing 17 values

SELECT
    order_value_band,
    COUNT(*) AS order_count
FROM order_history_clean
WHERE restaurant_name IN (
    'Aura Pizzas',
    'Dilli Burger Adda',
    'Masala Junction',
    'Swaad',
    'Tandoori Junction',
    'The Chicken Junction'
)
AND order_value_band IS NOT NULL
GROUP BY order_value_band
ORDER BY order_count DESC;

/*QA Step 19 — Weekend vs Weekday*/

SELECT
    weekend_flag,
    COUNT(*) AS order_count
FROM order_history_clean
GROUP BY weekend_flag
ORDER BY order_count DESC;

/*QA Step 20 — Peak Hour Flag*/

SELECT
    peak_hour_flag,
    COUNT(*) AS order_count
FROM order_history_clean
GROUP BY peak_hour_flag
ORDER BY order_count DESC;

-- for validating Average KPT by Peak Hour Flag --
SELECT
    peak_hour_flag,
    AVG(kpt_duration_clean) AS average_kpt
FROM order_history_clean
WHERE kpt_duration_clean IS NOT NULL
GROUP BY peak_hour_flag
ORDER BY peak_hour_flag;

/*QA Step 21 — Customer Complaints by Restaurant*/

SELECT
    restaurant_name,
    COUNT(*) AS total_complaints
FROM order_history_clean
WHERE complaint_flag = 'Yes'
GROUP BY restaurant_name
ORDER BY total_complaints DESC;

/*QA Step 22 — Restaurant Operational Performance*/

SELECT
    restaurant_name,
    AVG(kpt_duration_clean) AS average_kpt,
    AVG(rider_wait_time_clean) AS average_rider_wait
FROM order_history_clean
GROUP BY restaurant_name
ORDER BY average_kpt DESC;

/*QA Step 23 — Customer Rating by Restaurant*/

SELECT
    restaurant_name,
    AVG(rating_clean) AS average_rating
FROM order_history_clean
WHERE rating_clean IS NOT NULL
GROUP BY restaurant_name
ORDER BY average_rating DESC;

/*QA Step 24 — Customer Feedback Status*/ -- PASS with documented source-population difference. --

SELECT
    feedback_given,
    COUNT(*) AS total_orders
FROM order_history_clean
GROUP BY feedback_given
ORDER BY feedback_given;

/*QA Step 25 — Cancellation Reasons*/ -- PASS with documented source-population difference. --

SELECT
    cancellation_reason,
    COUNT(*) AS cancellation_count
FROM order_history_clean
WHERE cancellation_reason IS NOT NULL
  AND TRIM(cancellation_reason) <> ''
GROUP BY cancellation_reason
ORDER BY cancellation_count DESC;

/*QA Step 26 — Revenue vs Discount Impact*/

SELECT
    restaurant_name,
    SUM(total_discount) AS total_discounts,
    SUM(net_revenue) AS total_revenue,
    COUNT(*) AS total_orders
FROM order_history_clean
GROUP BY restaurant_name
ORDER BY total_revenue DESC;

/*QA Step 27 — Delivery Distance vs Kitchen Preparation Time*/

SELECT
    restaurant_name,
    AVG(distance_km) AS average_distance,
    AVG(kpt_duration_clean) AS average_kpt,
    COUNT(*) AS total_orders
FROM order_history_clean
GROUP BY restaurant_name
ORDER BY average_distance;

/*QA Step 28 — Top 5 Restaurants: Customer & Operational Performance*/

SELECT
    restaurant_name,
    AVG(rating_clean) AS average_rating,
    COUNT(*) AS total_orders,
    AVG(kpt_duration_clean) AS average_kpt,
    SUM(CASE WHEN complaint_flag = 'Yes' THEN 1 ELSE 0 END) AS total_complaints
FROM order_history_clean
GROUP BY restaurant_name
ORDER BY total_orders DESC
LIMIT 5;

/*QA Step 29 — Top 5 Restaurants by Customer Complaints*/

SELECT
    restaurant_name,
    SUM(CASE WHEN complaint_flag = 'Yes' THEN 1 ELSE 0 END) AS total_complaints
FROM order_history_clean
GROUP BY restaurant_name
ORDER BY total_complaints DESC
LIMIT 5;
/*QA Step 30 — Orders by Meal Period*/

/*QA Step 31 — Top 5 Restaurants by Revenue*/

/*QA Step 32 — Daily Revenue Trend*/

SELECT
    order_date,
    SUM(net_revenue) AS daily_revenue
FROM order_history_clean
GROUP BY order_date
ORDER BY order_date;

/*QA Step 33 — Top 5 Restaurants by Revenue*/

SELECT
    SUM(total) AS aura_pizzas_revenue
FROM order_history_clean
WHERE restaurant_name = 'Aura Pizzas';

/*QA Step 37*/

SELECT 
    meal_period,
    COUNT(*) AS total_orders
FROM order_history_clean
GROUP BY meal_period
ORDER BY meal_period;

/* QA 38 — Order Value Band */

SELECT
    order_value_band,
    COUNT(*) AS total_orders
FROM order_history_clean
GROUP BY order_value_band
ORDER BY total_orders DESC;

/*QA 39 — Revenue by Restaurant*/

SELECT
    restaurant_name,
    SUM(net_revenue) AS total_revenue
FROM order_history_clean
GROUP BY restaurant_name
ORDER BY total_revenue DESC;

/*QA 40 — Monthly Revenue*/

SELECT
    order_year,
    order_month,
    month_name,
    SUM(net_revenue) AS monthly_revenue
FROM order_history_clean
GROUP BY
    order_year,
    order_month,
    month_name
ORDER BY
    order_year,
    order_month;

/*QA 50 — Revenue by Meal Period*/

SELECT
    meal_period,
    SUM(net_revenue) AS total_revenue
FROM order_history_clean
GROUP BY meal_period
ORDER BY total_revenue DESC;

/* QA 51 — Revenue by Order Status*/

SELECT
    order_status,
    SUM(net_revenue) AS total_revenue
FROM order_history_clean
GROUP BY order_status
ORDER BY total_revenue DESC;

