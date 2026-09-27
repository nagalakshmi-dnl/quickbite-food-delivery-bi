DROP TABLE IF EXISTS order_history_clean;
/*Create a Base Clean Table*/ 

CREATE TABLE order_history_clean AS
SELECT *
FROM order_history_raw;

-- Add New Columns

ALTER TABLE order_history_clean
ADD COLUMN order_datetime DATETIME,
ADD COLUMN order_date DATE,
ADD COLUMN order_time TIME,
ADD COLUMN order_year INT,
ADD COLUMN order_month INT,
ADD COLUMN month_name VARCHAR(20),
ADD COLUMN day_name VARCHAR(20),
ADD COLUMN order_hour INT,
ADD COLUMN meal_period VARCHAR(20),
ADD COLUMN delivery_partner VARCHAR(100),
ADD COLUMN distance_km DECIMAL(5,2),
ADD COLUMN rating_clean DECIMAL(2,1);

SET SQL_SAFE_UPDATES = 0;

-- Update Date & Time
UPDATE order_history_clean
SET
order_datetime = STR_TO_DATE(
REPLACE(order_placed_at, ',', ''),
'%h:%i %p %M %d %Y'
);

UPDATE order_history_clean
SET

order_date = DATE(order_datetime),

order_time = TIME(order_datetime),

order_year = YEAR(order_datetime),

order_month = MONTH(order_datetime),

month_name = MONTHNAME(order_datetime),

day_name = DAYNAME(order_datetime),

order_hour = HOUR(order_datetime);
