-- Day 2 SQL Practice Queries
-- Created by Siha | Microsoft TSE Bootcamp

-- Create table
CREATE TABLE customers (id INTEGER, name TEXT, email TEXT, city TEXT);

-- Insert rows
INSERT INTO customers VALUES (1,'Siha','siha@gmail.com','Bangalore');
INSERT INTO customers VALUES (2,'Priya','priya@gmail.com','Mumbai');
INSERT INTO customers VALUES (3,'Rahul','rahul@gmail.com','Delhi');
INSERT INTO customers VALUES (4,'Ananya','ananya@gmail.com','Chennai');
INSERT INTO customers VALUES (5,'Arjun','arjun@gmail.com','Bangalore');

-- Select all
SELECT * FROM customers;

-- Filter by city
SELECT name FROM customers WHERE city='Bangalore';

-- Sort by name
SELECT * FROM customers ORDER BY name;

-- Count by city
SELECT city, COUNT(*) FROM customers GROUP BY city;

-- Join with orders table
SELECT c.name, o.product FROM customers c JOIN orders o ON c.id=o.customer_id;
