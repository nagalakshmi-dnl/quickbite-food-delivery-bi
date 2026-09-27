SELECT DISTINCT kpt_duration
FROM order_history_raw
WHERE kpt_duration IS NOT NULL
  AND kpt_duration <> ''
  AND kpt_duration NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';
  
  SELECT DISTINCT rider_wait_time
FROM order_history_raw
WHERE rider_wait_time IS NOT NULL
  AND rider_wait_time <> ''
  AND rider_wait_time NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';
  
  SELECT DISTINCT rating
FROM order_history_raw
WHERE rating IS NOT NULL
  AND rating <> ''
  AND rating NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';
  
  SELECT DISTINCT distance
FROM order_history_raw
WHERE distance NOT IN ('<1km')
  AND REPLACE(distance,'km','')
      NOT REGEXP '^[0-9]+(\\.[0-9]+)?$';
      
SHOW CREATE TABLE order_history_raw;

SELECT
    bill_subtotal,
    packaging_charges,
    restaurant_discount_promo,
    restaurant_discount_flatoffs,
    gold_discount,
    brand_pack_discount,
    total
FROM order_history_raw
LIMIT 10;

SELECT
    CAST(bill_subtotal AS DECIMAL(10,2)),
    CAST(packaging_charges AS DECIMAL(10,2)),
    CAST(restaurant_discount_promo AS DECIMAL(10,2)),
    CAST(restaurant_discount_flatoffs AS DECIMAL(10,2)),
    CAST(gold_discount AS DECIMAL(10,2)),
    CAST(brand_pack_discount AS DECIMAL(10,2)),
    CAST(total AS DECIMAL(10,2))
FROM order_history_raw
LIMIT 10;

SELECT
    restaurant_id,
    restaurant_name,
    subzone,
    city,
    order_id,

    STR_TO_DATE(REPLACE(order_placed_at, ',', ''), '%h:%i %p %M %d %Y') AS order_datetime,

    order_status,
    delivery,

    CASE
        WHEN distance = '<1km' THEN 0.5
        ELSE CAST(REPLACE(distance,'km','') AS DECIMAL(5,2))
    END AS distance_km,

    CASE
        WHEN rating = '' THEN NULL
        ELSE CAST(rating AS DECIMAL(2,1))
    END AS rating,

    CAST(kpt_duration AS DECIMAL(6,2)) AS kpt_duration,

    CAST(rider_wait_time AS DECIMAL(6,2)) AS rider_wait_time

FROM order_history_raw
LIMIT 100;

SELECT
    items_in_order,
    NULLIF(instructions, '') AS instructions,
    NULLIF(discount_construct, '') AS discount_construct,

    bill_subtotal,
    packaging_charges,
    restaurant_discount_promo,
    restaurant_discount_flatoffs,
    gold_discount,
    brand_pack_discount,
    total,

    NULLIF(review, '') AS review,
    NULLIF(cancellation_reason, '') AS cancellation_reason,
    NULLIF(restaurant_compensation, '') AS restaurant_compensation,
    NULLIF(restaurant_penalty, '') AS restaurant_penalty,
    order_ready_marked,
    NULLIF(customer_complaint_tag, '') AS customer_complaint_tag,
    customer_id

FROM order_history_raw
LIMIT 100;