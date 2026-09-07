-- PHASE 2: SQL FOR DATA ANALYTICS
-- Recommended DBMS: MySQL 8+
-- Database: analytics_practice

DROP DATABASE IF EXISTS analytics_practice;
CREATE DATABASE analytics_practice;
USE analytics_practice;

-- 1. TABLES
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    signup_date DATE,
    segment VARCHAR(30)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(12,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    unit_price DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    amount DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT,
    review_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. SAMPLE DATA
INSERT INTO customers VALUES
(1,'Ali','Lahore','2025-01-10','Regular'),
(2,'Sara','Karachi','2025-01-15','Premium'),
(3,'Ahmed','Lahore','2025-02-03','Premium'),
(4,'Ayesha','Islamabad','2025-02-20','Regular'),
(5,'Hamza','Lahore','2025-03-05','Regular'),
(6,'Zainab','Karachi','2025-03-18','Premium'),
(7,'Bilal','Islamabad','2025-04-02','Regular'),
(8,'Hina','Lahore','2025-04-15','Premium'),
(9,'Usman','Karachi','2025-05-01','Regular'),
(10,'Maham','Lahore','2025-05-12','Regular');

INSERT INTO products VALUES
(101,'Laptop','Electronics',120000),
(102,'Mouse','Accessories',5000),
(103,'Keyboard','Accessories',8000),
(104,'Monitor','Electronics',45000),
(105,'Headphones','Accessories',12000),
(106,'Tablet','Electronics',65000);

INSERT INTO orders VALUES
(1001,1,101,'2025-06-01',1,120000),
(1002,2,102,'2025-06-03',2,5000),
(1003,3,101,'2025-06-05',1,120000),
(1004,4,103,'2025-06-08',2,8000),
(1005,5,102,'2025-06-10',3,5000),
(1006,6,104,'2025-06-12',1,45000),
(1007,7,103,'2025-06-15',1,8000),
(1008,8,104,'2025-06-18',2,45000),
(1009,9,105,'2025-06-20',2,12000),
(1010,10,102,'2025-06-22',1,5000),
(1011,1,106,'2025-07-02',1,65000),
(1012,2,105,'2025-07-04',1,12000),
(1013,3,104,'2025-07-07',1,45000),
(1014,5,101,'2025-07-10',1,120000),
(1015,8,102,'2025-07-12',4,5000);

INSERT INTO payments VALUES
(1,1001,'2025-06-01','Card','Paid',120000),
(2,1002,'2025-06-03','Cash','Paid',10000),
(3,1003,'2025-06-05','Card','Paid',120000),
(4,1004,'2025-06-08','Card','Paid',16000),
(5,1005,'2025-06-10','Cash','Paid',15000),
(6,1006,'2025-06-12','Card','Paid',45000),
(7,1007,'2025-06-15','Cash','Paid',8000),
(8,1008,'2025-06-18','Card','Paid',90000),
(9,1009,'2025-06-20','Card','Paid',24000),
(10,1010,'2025-06-22','Cash','Pending',5000),
(11,1011,'2025-07-02','Card','Paid',65000),
(12,1012,'2025-07-04','Card','Paid',12000),
(13,1013,'2025-07-07','Cash','Paid',45000),
(14,1014,'2025-07-10','Card','Paid',120000),
(15,1015,'2025-07-12','Card','Paid',20000);

INSERT INTO reviews VALUES
(1,1,101,5,'2025-06-03'),
(2,2,102,4,'2025-06-05'),
(3,3,101,5,'2025-06-07'),
(4,4,103,3,'2025-06-10'),
(5,5,102,4,'2025-06-12'),
(6,6,104,5,'2025-06-14'),
(7,7,103,4,'2025-06-17'),
(8,8,104,5,'2025-06-20'),
(9,9,105,3,'2025-06-22'),
(10,10,102,4,'2025-06-24');

-- 3. BASIC SELECT
SELECT * FROM customers;
SELECT customer_name, city, segment FROM customers;
SELECT DISTINCT city FROM customers;
SELECT customer_name AS Customer, city AS City FROM customers;

-- 4. WHERE
SELECT * FROM customers WHERE city = 'Lahore';
SELECT * FROM products WHERE price > 100000;
SELECT * FROM products WHERE category = 'Electronics' AND price > 50000;
SELECT * FROM customers WHERE city IN ('Lahore','Karachi');
SELECT * FROM products WHERE price BETWEEN 5000 AND 50000;
SELECT * FROM customers WHERE customer_name LIKE 'A%';

-- 5. ORDER BY / LIMIT
SELECT * FROM products ORDER BY price DESC;
SELECT * FROM products ORDER BY price DESC LIMIT 3;

-- 6. AGGREGATES
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT SUM(quantity) AS total_units_sold FROM orders;
SELECT AVG(price) AS average_product_price FROM products;
SELECT MIN(price) AS cheapest_product, MAX(price) AS most_expensive_product FROM products;
SELECT SUM(quantity * unit_price) AS total_revenue FROM orders;

-- 7. GROUP BY
SELECT city, COUNT(*) AS customer_count FROM customers GROUP BY city;
SELECT product_id, SUM(quantity * unit_price) AS revenue
FROM orders GROUP BY product_id ORDER BY revenue DESC;
SELECT customer_id, SUM(quantity * unit_price) AS revenue
FROM orders GROUP BY customer_id ORDER BY revenue DESC;

-- 8. HAVING
SELECT customer_id, SUM(quantity * unit_price) AS total_spending
FROM orders
GROUP BY customer_id
HAVING SUM(quantity * unit_price) > 100000;

SELECT product_id, SUM(quantity) AS units_sold
FROM orders
GROUP BY product_id
HAVING SUM(quantity) > 2;

-- 9. CASE WHEN
SELECT product_name, price,
CASE
    WHEN price >= 100000 THEN 'Premium'
    WHEN price >= 50000 THEN 'Mid-Range'
    ELSE 'Budget'
END AS price_category
FROM products;

-- 10. JOINS
SELECT o.order_id, c.customer_name, o.order_date, o.quantity, o.unit_price
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

SELECT o.order_id, p.product_name, p.category, o.quantity,
       o.quantity * o.unit_price AS revenue
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id;

SELECT o.order_id, c.customer_name, p.product_name,
       o.quantity * o.unit_price AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

SELECT c.customer_id, c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 11. DATE ANALYSIS
SELECT * FROM orders
WHERE order_date >= '2025-06-01' AND order_date < '2025-07-01';

SELECT YEAR(order_date) AS year, MONTH(order_date) AS month,
       SUM(quantity * unit_price) AS revenue
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

SELECT order_date, COUNT(*) AS orders
FROM orders GROUP BY order_date ORDER BY order_date;

-- 12. STRING FUNCTIONS
SELECT customer_name, UPPER(customer_name) AS uppercase_name,
       LOWER(customer_name) AS lowercase_name,
       LENGTH(customer_name) AS name_length
FROM customers;

-- 13. NULL HANDLING
SELECT * FROM customers WHERE city IS NULL;
SELECT customer_name, COALESCE(city,'Unknown') AS city FROM customers;

-- 14. SUBQUERIES
SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products);

SELECT * FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

-- 15. CTE
WITH customer_sales AS (
    SELECT customer_id, SUM(quantity * unit_price) AS revenue
    FROM orders GROUP BY customer_id
)
SELECT c.customer_name, cs.revenue
FROM customer_sales cs
JOIN customers c ON cs.customer_id = c.customer_id
ORDER BY cs.revenue DESC;

-- 16. WINDOW FUNCTIONS
SELECT customer_id, order_id, order_date,
       ROW_NUMBER() OVER (
           PARTITION BY customer_id ORDER BY order_date
       ) AS order_number
FROM orders;

WITH customer_sales AS (
    SELECT customer_id, SUM(quantity * unit_price) AS revenue
    FROM orders GROUP BY customer_id
)
SELECT customer_id, revenue,
       RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM customer_sales;

SELECT order_date, order_id,
       quantity * unit_price AS revenue,
       SUM(quantity * unit_price) OVER (
           ORDER BY order_date, order_id
       ) AS running_revenue
FROM orders;

SELECT customer_id, order_id, order_date,
       LAG(order_date) OVER (
           PARTITION BY customer_id ORDER BY order_date
       ) AS previous_order_date
FROM orders;

SELECT customer_id, order_id, order_date,
       LEAD(order_date) OVER (
           PARTITION BY customer_id ORDER BY order_date
       ) AS next_order_date
FROM orders;

-- 17. BUSINESS ANALYTICS
SELECT SUM(quantity * unit_price) / COUNT(DISTINCT order_id) AS average_order_value
FROM orders;

SELECT c.customer_name, SUM(o.quantity * o.unit_price) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY revenue DESC LIMIT 5;

SELECT p.product_name, SUM(o.quantity) AS units_sold
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC;

SELECT p.category, SUM(o.quantity * o.unit_price) AS revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY revenue DESC;

SELECT c.city, SUM(o.quantity * o.unit_price) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY revenue DESC;

SELECT c.segment, SUM(o.quantity * o.unit_price) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.segment;

SELECT payment_status, COUNT(*) AS payment_count, SUM(amount) AS amount
FROM payments GROUP BY payment_status;

SELECT p.product_name, ROUND(AVG(r.rating),2) AS average_rating,
       COUNT(r.review_id) AS review_count
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_rating DESC;

-- 18. ACTIVE CUSTOMERS BY MONTH
SELECT YEAR(order_date) AS year, MONTH(order_date) AS month,
       COUNT(DISTINCT customer_id) AS active_customers
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;

-- 19. VIEW
CREATE OR REPLACE VIEW order_details AS
SELECT o.order_id, o.order_date,
       c.customer_id, c.customer_name, c.city, c.segment,
       p.product_id, p.product_name, p.category,
       o.quantity, o.unit_price,
       o.quantity * o.unit_price AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

SELECT * FROM order_details;

-- 20. INDEX + EXPLAIN
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_product ON orders(product_id);
CREATE INDEX idx_orders_date ON orders(order_date);

EXPLAIN SELECT * FROM orders WHERE customer_id = 1;

-- ============================================================
-- 21. PRACTICE QUESTIONS
-- ============================================================
-- Q1. Find all customers from Lahore.
-- Q2. Find the 3 most expensive products.
-- Q3. Calculate total revenue.
-- Q4. Calculate average product price.
-- Q5. Find total units sold per product.
-- Q6. Find customers spending more than 100,000.
-- Q7. Find revenue by city.
-- Q8. Find revenue by product category.
-- Q9. Find the top 5 customers by revenue.
-- Q10. Find the best-selling product by units.
-- Q11. Show every order with customer and product names.
-- Q12. Find customers who have never placed an order.
-- Q13. Calculate monthly revenue.
-- Q14. Rank customers by revenue using RANK().
-- Q15. Calculate running revenue using SUM() OVER().
-- Q16. Use LAG() for each customer's previous order date.
-- Q17. Calculate Average Order Value.
-- Q18. Compare Premium vs Regular revenue.
-- Q19. Find average rating for every product.
-- Q20. Label customers with revenue >= 100,000 as High Value.
-- Q21. Use a CTE to calculate and rank customer revenue.
-- Q22. Create a view containing order/customer/product details.
-- Q23. Use EXPLAIN on a filtered orders query.
-- Q24. Find customers with 2 or more orders.
-- Q25. Show each customer's first and latest order date.

-- GOAL:
-- Learn to convert a business question into a correct SQL query.
