/*Total Records*/

SELECT COUNT(*) AS Total_Records
FROM order_history_raw;

/*Duplicate Orders*/

SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT order_id) AS Unique_Orders
FROM order_history_raw;

/*Missing Values*/

SELECT COUNT(*) AS Missing_Restaurant
FROM order_history_raw
WHERE restaurant_name IS NULL
   OR restaurant_name = '';
   
   SELECT COUNT(*) AS Missing_City
FROM order_history_raw
WHERE city IS NULL
   OR city = '';
   
   SELECT COUNT(*) AS Missing_Total
FROM order_history_raw
WHERE total IS NULL;

SELECT COUNT(*) AS Missing_Customer
FROM order_history_raw
WHERE customer_id IS NULL
   OR customer_id = '';

/*Order Status Distribution*/

SELECT
    order_status,
    COUNT(*) AS Orders
FROM order_history_raw
GROUP BY order_status
ORDER BY Orders DESC;

/*City Distribution*/

SELECT
    city,
    COUNT(*) AS Orders
FROM order_history_raw
GROUP BY city
ORDER BY Orders DESC;

/*Restaurants Count*/

SELECT
COUNT(DISTINCT restaurant_name) Restaurants
FROM order_history_raw;

/*Customers Count*/

SELECT
COUNT(DISTINCT customer_id) Customers
FROM order_history_raw;

/*Revenue Statistics*/

SELECT
    MIN(total) AS Minimum_Order,
    MAX(total) AS Maximum_Order,
    ROUND(AVG(total),2) AS Average_Order
FROM order_history_raw;	

/*Delivery Distribution*/

SELECT DISTINCT distance
FROM order_history_raw
ORDER BY distance
LIMIT 30;

/*Rating Distribution*/

SELECT
    rating,
    COUNT(*) AS CountRating
FROM order_history_raw
GROUP BY rating
ORDER BY rating;
