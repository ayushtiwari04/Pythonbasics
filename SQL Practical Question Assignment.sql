# QUESTION 6 -:

#CREATE DATABASE
CREATE DATABASE ECommerceDB;

#USE DATABASE
USE ECommerceDB;

#CREATE CATEGORIES TABLE
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

#CREATE PRODUCT TABLE
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

#CREATE CUSTOMER TABLE
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);

#CREATE ORDER TABLE
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

#INSERTING VALUES IN TABLES

INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');

SELECT*FROM CATEGORIES;

INSERT INTO Products (ProductID, ProductName, CategoryID, Price, StockQuantity) VALUES
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel: The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);

SELECT*FROM PRODUCTS;

INSERT INTO Customers (CustomerID, CustomerName, Email, JoinDate) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');

SELECT*FROM CUSTOMERS;

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);

SELECT*FROM ORDERS;


#QUESTION 7-

select customername, email, count(orderid) as totalnumberoforders 
from customers c left join orders o
on c.customerid= o.customerid
group by c.customerid, c.customername, c.email
order by customername;

#QUESTION 8-

 SELECT PRODUCTNAME, PRICE, STOCKQUANTITY, CATEGORYNAME 
 FROM PRODUCTS P LEFT JOIN CATEGORIES C 
 ON P.CATEGORYID = C.CATEGORYID
 ORDER BY CATEGORYNAME ASC, PRODUCTNAME ASC;
 
 #QUESTION 9- 
 
 WITH RankedProducts AS (
    SELECT 
        CategoryName,
        ProductName,
        Price,
        row_number() OVER (
            PARTITION BY CategoryName 
            ORDER BY Price DESC
        ) AS rn
    FROM Products p
    INNER JOIN Categories c
        ON p.CategoryID = c.CategoryID
)

SELECT 
    CategoryName,
    ProductName,
    Price
FROM RankedProducts
WHERE rn <= 2
ORDER BY PRICE DESC;

#QUESTION 10-
#1

USE SAKILA;

SELECT CONCAT(first_name,' ',last_name) AS COUSTOMER_NAME, EMAIL, sum(amount) AS TOTAL_AMOUNT_SPENT
FROM CUSTOMER C JOIN PAYMENT P 
ON C.customer_id= P.customer_id
GROUP BY C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, C.EMAIL
ORDER BY TOTAL_AMOUNT_SPENT DESC
LIMIT 5;

#2

SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY total_rentals DESC
LIMIT 3;

#3

SELECT 
s.store_id,
COUNT(i.inventory_id) AS total_films,
SUM(CASE WHEN r.rental_id IS NULL THEN 1 ELSE 0 END) AS never_rented_films
FROM store s
JOIN inventory i ON s.store_id = i.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY s.store_id;

#4

SELECT 
    MONTH(payment_date) AS month,
    SUM(amount) AS total_revenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY MONTH(payment_date)
ORDER BY month;

#5

SELECT 
c.customer_id,
c.first_name,
c.last_name,
COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_date >= (
SELECT DATE_SUB(MAX(rental_date), INTERVAL 6 MONTH) 
FROM rental
)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) > 10
ORDER BY total_rentals DESC;











