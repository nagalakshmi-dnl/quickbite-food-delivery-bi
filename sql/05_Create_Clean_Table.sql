USE food_delivery_db;

DROP TABLE IF EXISTS order_history_clean;

CREATE TABLE order_history_clean (

restaurant_id INT,

restaurant_name VARCHAR(255),

subzone VARCHAR(150),

city VARCHAR(100),

order_id BIGINT PRIMARY KEY,

order_datetime DATETIME,

order_date DATE,

order_time TIME,

order_year INT,

order_month INT,

month_name VARCHAR(20),

day_name VARCHAR(20),

order_hour INT,

meal_period VARCHAR(30),

order_status VARCHAR(50),

delivery_partner VARCHAR(100),

distance_km DECIMAL(5,2),

items_in_order TEXT,

instructions TEXT,

discount_construct TEXT,

bill_subtotal DECIMAL(10,2),

packaging_charges DECIMAL(10,2),

restaurant_discount_promo DECIMAL(10,2),

restaurant_discount_flatoffs DECIMAL(10,2),

gold_discount DECIMAL(10,2),

brand_pack_discount DECIMAL(10,2),

total DECIMAL(10,2),

rating DECIMAL(2,1),

review TEXT,

cancellation_reason TEXT,

restaurant_compensation VARCHAR(100),

restaurant_penalty VARCHAR(100),

kpt_duration DECIMAL(6,2),

rider_wait_time DECIMAL(6,2),

order_ready_marked VARCHAR(50),

customer_complaint_tag TEXT,

customer_id VARCHAR(100)

);

