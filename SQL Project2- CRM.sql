CREATE DATABASE sqlproject2;
USE sqlproject2;
-- Task 1-- 

CREATE TABLE customer(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(50),
address VARCHAR(100),
PRIMARY KEY(id)
);

DESCRIBE customer;

INSERT INTO customer (name) VALUES ("Tom"), 
("Ricky"),
( "Jane"),
( "Tina"),
( "Richie"),
( "Tanya"),
( "Jim");
INSERT INTO customer (name, address) VALUES("Ben", "NY");

SELECT * FROM customer;
SELECT name FROM customer;

SELECT name FROM customer WHERE id = 4;
SELECT * FROM customer WHERE name LIKE "%an%";

-- Add new column-- 

ALTER TABLE customer ADD COLUMN (code_name VARCHAR(50) NOT NULL);

UPDATE customer SET code_name = "F4" WHERE id = 1;
UPDATE customer SET code_name = "QWE" WHERE id = 2;
UPDATE customer SET code_name = "ZXC" WHERE id = 3;
UPDATE customer SET code_name = "T1" WHERE id = 4;
UPDATE customer SET code_name = "T2" WHERE id = 5;
UPDATE customer SET code_name = "T3" WHERE id = 6;
UPDATE customer SET code_name = "T4" WHERE id = 7;
UPDATE customer SET code_name = "KHB" WHERE id = 8;

SELECT * FROM customer WHERE name="Jane" AND code_name= "ZXC";
SELECT * FROM customer WHERE code_name LIKE "T%";

-- Removing a column-- 

ALTER TABLE customer DROP COLUMN code_name;
DESCRIBE customer;

-- Task 2-- 
-- Customer and Orders with Products (CRM Project)-- 

SHOW TABLES;

CREATE TABLE products(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) UNIQUE,
price DECIMAL(10,2) NOT NULL,
PRIMARY KEY(id)
);

SELECT * FROM products;

-- To make product name not null-- 
ALTER TABLE products MODIFY COLUMN name VARCHAR(255) NOT NULL UNIQUE;

#Rename a column
ALTER TABLE products RENAME column name to prod_name;

DESCRIBE products;

INSERT INTO products (prod_name, price) VALUES("ADB", "499");

-- Using decimal system-- 
INSERT INTO products (prod_name, price) VALUES("DTV", "129"),
("KJH", "399"), ("TCD", "299"),
("PLO", "849");

-- Count total number of products-- 

SELECT COUNT(*) FROM products;

-- Order by-- 
SELECT prod_name FROM products ORDER BY prod_name;     -- Ascending-- 
SELECT prod_name FROM products ORDER BY prod_name DESC;    -- Descending-- 
SELECT * FROM products ORDER BY price DESC; 				-- Descending by price-- 
SELECT * FROM products ORDER BY price; 						-- Ascending by price--

-- Limit-- 
SELECT * FROM products ORDER BY price DESC LIMIT 1;

-- Where, Order by and Limit-- 
SELECT * FROM products WHERE price LIKE "%9%" ORDER BY price LIMIT 2;

-- Product where price >200-- 
SELECT * FROM products WHERE price>200;

-- Create Orders table-- 
CREATE TABLE orders(
id INT(15) NOT NULL AUTO_INCREMENT,
customer_id INT(15) NOT NULL,
order_number VARCHAR(255) NOT NULL,
order_date datetime NOT NULL,
PRIMARY KEY(id)
);

SELECT * FROM orders;

INSERT INTO orders (customer_id,order_number,order_date) VALUES(1, "HGB415", current_timestamp);


-- To insert unique order_number-- 
ALTER TABLE orders MODIFY COLUMN order_number VARCHAR(255) NOT NULL UNIQUE;

DELETE FROM orders WHERE id=2;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE orders ADD CONSTRAINT fk_customerid FOREIGN KEY(customer_id) REFERENCES customer(id);

INSERT INTO orders (customer_id,order_number,order_date) VALUES(3, "XBF32", current_timestamp);
INSERT INTO orders (customer_id,order_number,order_date) VALUES(9, "ZJN314", current_timestamp);
INSERT INTO orders (customer_id,order_number,order_date) VALUES(10, "UFB324", current_timestamp);

SELECT * FROM orders;

CREATE TABLE order_items(
id INT NOT NULL AUTO_INCREMENT,
order_id INT NOT NULL,
product_id INT NOT NULL,
price NUMERIC(15,2) NOT NULL,
QUANTITY INT,
PRIMARY KEY(id)
);

ALTER TABLE order_items ADD CONSTRAINT fk_orderid FOREIGN KEY(order_id) REFERENCES orders(id);

SELECT * FROM order_items;

ALTER TABLE order_items ADD CONSTRAINT fk_productid FOREIGN KEY(product_id) REFERENCES products(id);

DESCRIBE order_items;

-- Show create command-- 
SHOW CREATE TABLE order_items;

INSERT INTO order_items (order_id, product_id, price, QUANTITY) VALUES (2,5,255,6),
(1,6,364,9), (5,1,999,2);

-- Unique index on multiple columns-- 

CREATE UNIQUE INDEX order_product_uidx ON order_items(order_id, product_id);

-- Joins-- 
SELECT * FROM customer JOIN orders ON customer.id = orders.customer_id;

SELECT * FROM customer JOIN orders ON customer.id = orders.customer_id JOIN order_items ON orders.id = order_items.order_id;

-- Number of customers with orders-- 
SELECT COUNT(*) FROM customer JOIN orders ON orders.customer_id = customer.id;
SELECT COUNT(DISTINCT customer.id) FROM customer JOIN orders ON orders.customer_id = customer.id;

-- Number of customers that placed no orders-- 

SELECT * FROM customer LEFT JOIN orders ON customer.id = orders.customer_id;
SELECT * FROM customer LEFT JOIN orders ON customer.id = orders.customer_id WHERE orders.id IS NULL;
-- To get their names-- 
SELECT customer.name FROM customer LEFT JOIN orders ON customer.id = orders.customer_id WHERE orders.id IS NULL;

-- Total price and quantity-- 
SELECT SUM(price), SUM(quantity) FROM order_items;

SELECT order_items.order_id, SUM(price), SUM(quantity) FROM order_items GROUP BY order_id;

-- Total amount per order-- 
SELECT order_items.order_id, SUM(price * quantity) AS amount_per_order FROM order_items GROUP BY order_id;

#Final Total
select customer.id as customer_id, customer.name, orders.order_number, orders.id as order_id, order_totals.amount_per_order from customer join orders on orders.customer_id = customer.id
    join (
         select order_items.order_id, sum(price * quantity) as amount_per_order from order_items group by order_id
       ) as order_totals on order_totals.order_id = orders.id;
       
SELECT * FROM customer RIGHT JOIN orders ON customer.id = orders.customer_id;

-- Union-- 

Select * FROM customer UNION ALL SELECT * FROM products;

-- View-- 

CREATE OR REPLACE VIEW view1 AS 
SELECT name FROM customer WHERE id < 6;

SELECT * FROM view1;



