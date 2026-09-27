/*=========================================================
Create Bronze Layer (Raw Table)
=========================================================*/

CREATE TABLE order_history_raw (
    restaurant_id INT,
    restaurant_name VARCHAR(255),
    subzone VARCHAR(255),
    city VARCHAR(100),
    order_id BIGINT,
    order_placed_at VARCHAR(100),
    order_status VARCHAR(100),
    delivery VARCHAR(100),
    distance VARCHAR(100),
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
    rating VARCHAR(50),
    review TEXT,
    cancellation_reason TEXT,
    restaurant_compensation VARCHAR(100),
    restaurant_penalty VARCHAR(100),
    kpt_duration VARCHAR(50),
    rider_wait_time VARCHAR(50),
    order_ready_marked VARCHAR(100),
    customer_complaint_tag TEXT,
    customer_id VARCHAR(100)
);