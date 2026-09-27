-- Meal Period
UPDATE order_history_clean
SET meal_period =
CASE

WHEN order_hour BETWEEN 5 AND 10 THEN 'Breakfast'

WHEN order_hour BETWEEN 11 AND 15 THEN 'Lunch'

WHEN order_hour BETWEEN 16 AND 18 THEN 'Snacks'

WHEN order_hour BETWEEN 19 AND 23 THEN 'Dinner'

ELSE 'Late Night'

END;


-- Delivery Partner
UPDATE order_history_clean
SET delivery_partner = delivery;

-- Distance
UPDATE order_history_clean
SET distance_km =
CASE

WHEN distance = '<1km'
THEN 0.50

ELSE CAST(
REPLACE(distance,'km','')
AS DECIMAL(5,2)
)

END;


-- Rating
UPDATE order_history_clean
SET rating_clean =
CASE

WHEN rating = ''
THEN NULL

ELSE CAST(rating AS DECIMAL(2,1))

END;


-- KPT Duration

ALTER TABLE order_history_clean
ADD COLUMN kpt_duration_clean DECIMAL(6,2);

UPDATE order_history_clean
SET kpt_duration_clean =
CASE
    WHEN kpt_duration IS NULL OR kpt_duration = '' THEN NULL
    ELSE CAST(kpt_duration AS DECIMAL(6,2))
END;


-- Rider Wait Time
ALTER TABLE order_history_clean
ADD COLUMN rider_wait_time_clean DECIMAL(6,2);

UPDATE order_history_clean
SET rider_wait_time_clean =
CASE
    WHEN rider_wait_time IS NULL OR rider_wait_time = '' THEN NULL
    ELSE CAST(rider_wait_time AS DECIMAL(6,2))
END;

-- Total Discount

ALTER TABLE order_history_clean
ADD COLUMN total_discount DECIMAL(10,2);

UPDATE order_history_clean
SET total_discount =
COALESCE(restaurant_discount_promo,0)
+ COALESCE(restaurant_discount_flatoffs,0)
+ COALESCE(gold_discount,0)
+ COALESCE(brand_pack_discount,0);

-- Net Revenue

ALTER TABLE order_history_clean
ADD COLUMN net_revenue DECIMAL(10,2);

UPDATE order_history_clean
SET net_revenue = total;

-- Order Value Category

ALTER TABLE order_history_clean
ADD COLUMN order_value_band VARCHAR(20);

UPDATE order_history_clean
SET order_value_band =
CASE

WHEN total < 300
THEN 'Low'

WHEN total BETWEEN 300 AND 700
THEN 'Medium'

ELSE 'High'

END;

-- Weekend Flag

ALTER TABLE order_history_clean
ADD COLUMN weekend_flag VARCHAR(10);

UPDATE order_history_clean
SET weekend_flag =
CASE
WHEN day_name IN ('Saturday','Sunday')
THEN 'Weekend'
ELSE 'Weekday'
END;

-- Peak Hour Flag

ALTER TABLE order_history_clean
ADD COLUMN peak_hour_flag VARCHAR(10);

UPDATE order_history_clean
SET peak_hour_flag =
CASE
WHEN order_hour BETWEEN 12 AND 14
OR order_hour BETWEEN 19 AND 21
THEN 'Peak'
ELSE 'Normal'
END;

-- Customer Feedback Flag
ALTER TABLE order_history_clean
ADD COLUMN feedback_given VARCHAR(5);

UPDATE order_history_clean
SET feedback_given =
CASE

WHEN rating_clean IS NULL
THEN 'No'

ELSE 'Yes'

END;

-- Complaint Flag
ALTER TABLE order_history_clean
ADD COLUMN complaint_flag VARCHAR(5);

UPDATE order_history_clean
SET complaint_flag =
CASE
    WHEN customer_complaint_tag IS NULL
         OR customer_complaint_tag = ''
    THEN 'No'
    ELSE 'Yes'
END;

-- Cancellation Flag
ALTER TABLE order_history_clean
ADD COLUMN cancellation_flag VARCHAR(5);

UPDATE order_history_clean
SET cancellation_flag =
CASE

WHEN order_status='Delivered'
THEN 'No'

ELSE 'Yes'

END;

-- Final Validation

SELECT COUNT(*)
FROM order_history_clean;

SELECT
COUNT(*) AS Delivered
FROM order_history_clean
WHERE order_status='Delivered';

SELECT
COUNT(*) AS Rated
FROM order_history_clean
WHERE rating_clean IS NOT NULL;

SELECT
complaint_flag,
COUNT(*) AS Total
FROM order_history_clean
GROUP BY complaint_flag;

-- Row Count
SELECT COUNT(*) AS Total_Rows
FROM order_history_clean;

-- Missing Ratings
SELECT COUNT(*) AS Missing_Ratings
FROM order_history_clean
WHERE rating_clean IS NULL;

-- Orders by Meal Period
SELECT
meal_period,
COUNT(*) AS Orders
FROM order_history_clean
GROUP BY meal_period;

-- Orders by Order Value Band
SELECT
order_value_band,
COUNT(*)
FROM order_history_clean
GROUP BY order_value_band;

-- Weekend vs Weekday
SELECT
weekend_flag,
COUNT(*)
FROM order_history_clean
GROUP BY weekend_flag;

-- Peak vs Normal
SELECT
peak_hour_flag,
COUNT(*)
FROM order_history_clean
GROUP BY peak_hour_flag;

SET SQL_SAFE_UPDATES = 1;

