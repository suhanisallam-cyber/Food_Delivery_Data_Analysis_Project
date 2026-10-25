CREATE TABLE food_delivery_1 (
    customer_id TEXT,
    gender TEXT,
    age INTEGER,
    city TEXT,
    signup_date DATE,
    order_id TEXT,
    order_date DATE,
    restaurant_name TEXT,
    dish_name TEXT,
    category TEXT,
    quantity INTEGER,
    price NUMERIC(10,2),
    payment_method TEXT,
    order_frequency INTEGER,
    last_order_date DATE,
    loyalty_points INTEGER,
    churned TEXT,
    rating NUMERIC(3,1),
    rating_date DATE,
    delivery_status TEXT
);  

SELECT*FROM food_delivery_1;

ALTER TABLE food_delivery_1
ALTER COLUMN  age TYPE TEXT;

ALTER TABLE food_delivery_1
ADD COLUMN time_taken_min time;

-- Change delivery duration column to integer
ALTER TABLE public.food_delivery_1
ALTER COLUMN time_taken_min TYPE INTEGER
USING NULLIF(
    TRIM(time_taken_min::text), ''
)::NUMERIC::INTEGER;


-- Count the total number of records in the dataset
SELECT COUNT(*) AS total_records
FROM food_delivery_1;

-- Display the first 10 records to understand the dataset
SELECT *
FROM food_delivery_1
LIMIT 10;

-- Count missing values in important columns
SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE city IS NULL) AS missing_city,
    COUNT(*) FILTER (WHERE price IS NULL) AS missing_price,
    COUNT(*) FILTER (WHERE rating IS NULL) AS missing_rating
FROM food_delivery_1;

-- Identify order IDs that appear more than once
SELECT
    order_id,
    COUNT(*) AS order_count
FROM food_delivery_1
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY order_count DESC;

-- Calculate the number of unique customers in each city
SELECT
    city,
    COUNT(DISTINCT customer_id) AS total_customers
FROM food_delivery_1
GROUP BY city
ORDER BY total_customers DESC;

-- Calculate the total quantity ordered in each food category
SELECT
    category,
    SUM(quantity) AS total_quantity
FROM food_delivery_1
GROUP BY category
ORDER BY total_quantity DESC;

-- Calculate total revenue generated in each city
SELECT
    city,
    ROUND(SUM(price * quantity), 2) AS total_revenue
FROM food_delivery_1
GROUP BY city
ORDER BY total_revenue DESC;

-- Rank restaurants based on the number of distinct orders
SELECT
    restaurant_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM food_delivery_1
GROUP BY restaurant_name
ORDER BY total_orders DESC
LIMIT 10;

-- Calculate the average customer rating for each restaurant
SELECT
    restaurant_name,
    ROUND(AVG(rating), 2) AS average_rating,
    COUNT(rating) AS total_ratings
FROM food_delivery_1
GROUP BY restaurant_name
ORDER BY average_rating DESC NULLS LAST
LIMIT 10;

-- Count customers according to their churn status
SELECT
    churned,
    COUNT(DISTINCT customer_id) AS total_customers
FROM food_delivery_1
GROUP BY churned
ORDER BY total_customers DESC;

-- Calculate the number of distinct orders placed each month
SELECT
    DATE_TRUNC('month', order_date)::DATE AS order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM food_delivery_1
WHERE order_date IS NOT NULL
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY order_month;

-- Count distinct orders for each payment method
SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders
FROM food_delivery_1
GROUP BY payment_method
ORDER BY total_orders DESC;


