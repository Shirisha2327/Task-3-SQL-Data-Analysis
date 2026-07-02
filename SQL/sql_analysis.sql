-- ==========================================
-- Task 3: SQL Data Analysis using MySQL
-- Dataset: Brazilian E-Commerce (Olist)
-- Author: Mamidi Shirisha
-- ==========================================

-- ==========================================
-- 1. Select Database
-- ==========================================

USE olist_ecommerce;

-- ==========================================
-- 2. Database Validation
-- ==========================================

SHOW TABLES;

SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(*) AS total_order_items FROM order_items;
SELECT COUNT(*) AS total_payments FROM payments;
SELECT COUNT(*) AS total_products FROM products;
SELECT COUNT(*) AS total_categories FROM category_translation;

-- ==========================================
-- 3. Data Exploration
-- ==========================================

SELECT * FROM customers LIMIT 10;

SELECT * FROM orders LIMIT 10;

SELECT * FROM products LIMIT 10;

SELECT * FROM payments LIMIT 10;

-- ==========================================
-- 4. Data Cleaning / Validation
-- ==========================================

-- Check NULL Values

SELECT *
FROM customers
WHERE customer_id IS NULL;

SELECT *
FROM orders
WHERE order_id IS NULL;

SELECT *
FROM payments
WHERE payment_value IS NULL;

-- Check Duplicate Customers

SELECT customer_id,
COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- ==========================================
-- 5. Customer Analysis
-- ==========================================

SELECT customer_state,
COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

SELECT customer_city,
COUNT(*) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;

-- ==========================================
-- 6. Order Analysis
-- ==========================================

SELECT order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT
YEAR(order_purchase_timestamp) AS year,
MONTH(order_purchase_timestamp) AS month,
COUNT(*) AS total_orders
FROM orders
GROUP BY year, month
ORDER BY year, month;

-- ==========================================
-- 7. Payment Analysis
-- ==========================================

SELECT payment_type,
COUNT(*) AS total_transactions
FROM payments
GROUP BY payment_type
ORDER BY total_transactions DESC;

SELECT
ROUND(SUM(payment_value),2) AS total_revenue
FROM payments;

-- ==========================================
-- 8. Product Analysis
-- ==========================================

SELECT
product_category_name,
COUNT(*) AS total_products
FROM products
GROUP BY product_category_name
ORDER BY total_products DESC
LIMIT 10;

-- ==========================================
-- 9. JOIN Analysis
-- ==========================================

SELECT
c.customer_state,
ROUND(SUM(p.payment_value),2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

-- ==========================================
-- 10. Views
-- ==========================================

CREATE VIEW customer_orders AS
SELECT
c.customer_id,
c.customer_state,
o.order_id,
o.order_status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

SELECT * FROM customer_orders LIMIT 10;
