-- Create Database
CREATE DATABASE sales_analysis;
USE sales_analysis;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Amit', 'Delhi'),
(2, 'Riya', 'Mumbai'),
(3, 'Karan', 'Kanpur'),
(4, 'Neha', 'Lucknow');

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 55000),
(2, 'Headphones', 'Electronics', 1500),
(3, 'Shoes', 'Fashion', 2200),
(4, 'T-Shirt', 'Fashion', 700);

-- Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO sales VALUES
(1, 1, 1, 1, '2024-01-10'),
(2, 2, 2, 2, '2024-01-12'),
(3, 3, 3, 1, '2024-02-05'),
(4, 1, 4, 3, '2024-02-20'),
(5, 4, 1, 1, '2024-03-01');

-- Analysis Queries

-- 1. Monthly Revenue
SELECT 
    DATE_FORMAT(sale_date, '%Y/%m') AS Month,
    SUM(quantity * price) AS Total_Revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY Month
ORDER BY Month;

-- 2. Top Selling Products
SELECT 
    p.product_name,
    SUM(s.quantity) AS Units_Sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Units_Sold DESC;

-- 3. Customer Purchase Count
SELECT 
    c.name,
    COUNT(s.sale_id) AS Total_Purchases
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.name
ORDER BY Total_Purchases DESC;

-- 4. Revenue by Product Category
SELECT 
    category,
    SUM(quantity * price) AS Revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY category;
