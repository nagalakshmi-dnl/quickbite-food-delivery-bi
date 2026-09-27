/*=========================================================
Project : Food Delivery Business Intelligence Platform
Layer   : Gold Layer
File    : 09_Data_Validation.sql
Purpose : Validate transformed data before reporting
Author  : Naga Lakshmi Devanaboina
=========================================================*/

-- Record Count Validation
-- Validate record count between Bronze and Silver tables

SELECT
    (SELECT COUNT(*) FROM order_history_raw) AS Raw_Records,
    (SELECT COUNT(*) FROM order_history_clean) AS Clean_Records;
    
-- Duplicate Order Validation
-- Check for duplicate order IDs

SELECT
    order_id,
    COUNT(*) AS Duplicate_Count
FROM order_history_clean
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Order Status Distribution
-- Validate order status distribution

SELECT
    order_status,
    COUNT(*) AS Total_Orders
FROM order_history_clean
GROUP BY order_status
ORDER BY Total_Orders DESC;

-- Meal Period Distribution
-- Validate meal period classification

SELECT
    meal_period,
    COUNT(*) AS Orders
FROM order_history_clean
GROUP BY meal_period
ORDER BY Orders DESC;

-- Order Value Band Distribution
-- Validate order value segmentation

SELECT
    order_value_band,
    COUNT(*) AS Orders
FROM order_history_clean
GROUP BY order_value_band;

-- Weekend vs Weekday Validation
-- Validate weekend flag

SELECT
    weekend_flag,
    COUNT(*) AS Orders
FROM order_history_clean
GROUP BY weekend_flag;

-- Peak Hour Validation
-- Validate peak hour classification

SELECT
    peak_hour_flag,
    COUNT(*) AS Orders
FROM order_history_clean
GROUP BY peak_hour_flag;

-- Rating Validation
-- Validate customer ratings

SELECT
    COUNT(rating_clean) AS Rated_Orders,
    COUNT(*) - COUNT(rating_clean) AS Missing_Ratings,
    ROUND(AVG(rating_clean),2) AS Average_Rating
FROM order_history_clean;

-- Complaint Validation
-- Validate complaint flag

SELECT
    complaint_flag,
    COUNT(*) AS Total
FROM order_history_clean
GROUP BY complaint_flag;

-- Feedback Validation
-- Validate customer feedback

SELECT
    feedback_given,
    COUNT(*) AS Orders
FROM order_history_clean
GROUP BY feedback_given;

-- Revenue Validation
-- Validate revenue calculations

SELECT
    ROUND(SUM(total),2) AS Gross_Revenue,
    ROUND(SUM(total_discount),2) AS Total_Discount,
    ROUND(SUM(net_revenue),2) AS Net_Revenue
FROM order_history_clean;

-- Distance Validation
-- Validate delivery distance

SELECT
    MIN(distance_km) AS Minimum_Distance,
    MAX(distance_km) AS Maximum_Distance,
    ROUND(AVG(distance_km),2) AS Average_Distance
FROM order_history_clean;

-- Delivery Time Validation
-- Validate delivery performance metrics

SELECT
    ROUND(AVG(kpt_duration_clean),2) AS Average_KPT,
    ROUND(AVG(rider_wait_time_clean),2) AS Average_Rider_Wait
FROM order_history_clean;

-- NULL Validation for Engineered Columns
-- Validate engineered columns for unexpected NULL values

SELECT
    SUM(CASE WHEN meal_period IS NULL THEN 1 ELSE 0 END) AS Missing_Meal_Period,
    SUM(CASE WHEN weekend_flag IS NULL THEN 1 ELSE 0 END) AS Missing_Weekend_Flag,
    SUM(CASE WHEN peak_hour_flag IS NULL THEN 1 ELSE 0 END) AS Missing_Peak_Hour_Flag,
    SUM(CASE WHEN order_value_band IS NULL THEN 1 ELSE 0 END) AS Missing_Order_Value_Band,
    SUM(CASE WHEN distance_km IS NULL THEN 1 ELSE 0 END) AS Missing_Distance,
    SUM(CASE WHEN total_discount IS NULL THEN 1 ELSE 0 END) AS Missing_Total_Discount,
    SUM(CASE WHEN net_revenue IS NULL THEN 1 ELSE 0 END) AS Missing_Net_Revenue
FROM order_history_clean;

-- Final QA Summary
-- Final QA Summary

SELECT
    COUNT(*) AS Total_Orders,
    COUNT(DISTINCT customer_id) AS Total_Customers,
    COUNT(DISTINCT restaurant_name) AS Total_Restaurants,
    ROUND(SUM(net_revenue),2) AS Total_Revenue,
    ROUND(AVG(net_revenue),2) AS Average_Order_Value,
    ROUND(AVG(rating_clean),2) AS Average_Rating
FROM order_history_clean;
