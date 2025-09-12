-- =========================================
-- 1) CREATE: schema with constraints
-- =========================================
CREATE DATABASE IF NOT EXISTS shop_db;
USE shop_db;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    full_name VARCHAR(200) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(200) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    CHECK (price >= 0),
    CHECK (stock >= 0)
);

-- Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING','SHIPPED','CANCELLED','COMPLETED') NOT NULL DEFAULT 'PENDING',
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Order items table
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CHECK (quantity > 0),
    CHECK (unit_price >= 0),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
);

-- =========================================
-- 2) INSERT sample data
-- =========================================
INSERT INTO customers (email, full_name) VALUES
('alice@example.com', 'Alice Anderson'),
('bob@example.com',   'Bob Brown'),
('eve@example.com',   'Eve Evans');

INSERT INTO products (sku, name, price, stock) VALUES
('SKU-1001', 'Coffee Mug', 7.99, 100),
('SKU-1002', 'T-Shirt', 14.99, 50),
('SKU-1003', 'Water Bottle', 12.50, 75),
('SKU-1004', 'Notebook', 3.45, 200);

INSERT INTO orders (customer_id, status) VALUES
(1, 'PENDING'),
(2, 'PENDING'),
(1, 'COMPLETED');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 7.99),
(1, 4, 1, 3.45),
(2, 2, 3, 14.99),
(3, 3, 1, 12.50);

-- =========================================
-- 3) READ: JOINS
-- =========================================
-- INNER JOIN
SELECT o.order_id, o.order_date, c.full_name,
       p.name AS product_name, oi.quantity, oi.unit_price,
       (oi.quantity * oi.unit_price) AS line_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
JOIN products p ON p.product_id = oi.product_id
ORDER BY o.order_id;

-- LEFT JOIN
SELECT c.customer_id, c.full_name, o.order_id, o.status, o.order_date
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
ORDER BY c.customer_id;

-- Aggregation
SELECT o.order_id, c.full_name,
       SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY o.order_id, c.full_name
ORDER BY order_total DESC;

-- =========================================
-- 4) UPDATE with transaction
-- =========================================
START TRANSACTION;

UPDATE products
SET price = 12.99
WHERE sku = 'SKU-1002';

SAVEPOINT after_price_update;

-- This will fail because ENUM doesn’t allow INVALID_STATUS
UPDATE orders
SET status = 'INVALID_STATUS'
WHERE order_id = 1;

ROLLBACK TO SAVEPOINT after_price_update;

COMMIT;

-- Check results
SELECT product_id, sku, name, price FROM products WHERE sku = 'SKU-1002';
SELECT order_id, status FROM orders WHERE order_id = 1;

-- =========================================
-- 5) DELETE
-- =========================================
DELETE FROM orders WHERE order_id = 2;
