-- PHASE 2 - LESSON 1: SQL FOR DATA ANALYTICS
-- Topics: SELECT, DISTINCT, WHERE, AND, OR, IN, BETWEEN, LIKE
-- Recommended DBMS: MySQL 8+
USE analytics_practice;

-- 1. SELECT
SELECT * FROM customers;
SELECT customer_name, city FROM customers;
SELECT product_name, price FROM products;

-- 2. DISTINCT
SELECT DISTINCT city FROM customers;
SELECT DISTINCT segment FROM customers;
SELECT DISTINCT city, segment FROM customers;

-- 3. WHERE + comparison operators
SELECT * FROM customers WHERE city = 'Lahore';
SELECT * FROM products WHERE price > 100000;
SELECT * FROM products WHERE price < 10000;
SELECT * FROM products WHERE price >= 50000;
SELECT * FROM products WHERE price <= 12000;
SELECT * FROM products WHERE price <> 5000;

-- 4. AND
SELECT customer_name, city, segment
FROM customers
WHERE city = 'Lahore' AND segment = 'Premium';

SELECT *
FROM products
WHERE category = 'Electronics' AND price > 50000;

-- 5. OR
SELECT * FROM customers
WHERE city = 'Lahore' OR city = 'Karachi';

-- 6. IN
SELECT * FROM customers
WHERE city IN ('Lahore', 'Karachi');

SELECT * FROM products
WHERE category IN ('Electronics', 'Accessories');

-- 7. BETWEEN
SELECT * FROM products
WHERE price BETWEEN 5000 AND 50000;

SELECT * FROM orders
WHERE order_date BETWEEN '2025-06-01' AND '2025-06-30';

-- 8. LIKE
-- % = zero or more characters; _ = exactly one character
SELECT * FROM customers WHERE customer_name LIKE 'A%';
SELECT * FROM customers WHERE customer_name LIKE '%a';
SELECT * FROM customers WHERE customer_name LIKE '%ham%';
SELECT * FROM products WHERE product_name LIKE '%top%';

-- 9. BUSINESS EXAMPLES
SELECT DISTINCT city FROM customers;

SELECT customer_name, city, segment
FROM customers
WHERE city = 'Lahore' AND segment = 'Premium';

SELECT product_name, price
FROM products
WHERE price > 100000;

SELECT customer_name, city
FROM customers
WHERE city IN ('Lahore', 'Karachi');

-- 10. ANALYST THINKING EXAMPLE
-- Business question:
-- Find Lahore Premium customers who signed up after 2025-03-01.
SELECT customer_name, city, segment, signup_date
FROM customers
WHERE city = 'Lahore'
  AND segment = 'Premium'
  AND signup_date > '2025-03-01';

-- 11. PRACTICE QUESTIONS
-- Q1. Show all products.
-- Q2. Show only product_name and price.
-- Q3. Show unique customer cities.
-- Q4. Show only Karachi customers.
-- Q5. Show products with price greater than 50,000.
-- Q6. Show Lahore Premium customers' names.
-- Q7. Show customers from Lahore or Islamabad.
-- Q8. Show Electronics and Accessories products using IN.
-- Q9. Show products priced between 8,000 and 65,000.
-- Q10. Find customers whose names start with A.

-- 12. CHALLENGE
-- Write a query for:
-- "The company wants the names and signup dates of Lahore Premium
-- customers who signed up after 2025-03-01."
-- Try it yourself before checking the analyst example above.

-- LESSON 1 GOAL
-- Translate a business question into SELECT + FROM + WHERE
-- with appropriate filter conditions.
