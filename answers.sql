
SELECT checkNumber, paymentDate, amount
FROM payments;

SELECT orderDate, requiredDate, status
FROM orders
WHERE status = 'In Process'
ORDER BY orderDate DESC;

SELECT firstName, lastName, email
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY employeeNumber DESC;

SELECT *
FROM offices;

SELECT productName, quantityInStock
FROM products
ORDER BY buyPrice ASC;

-- Week 3 queries
CREATE TABLE student (
    id INT PRIMARY KEY,
    fullName VARCHAR(100),
    age INT
);

INSERT INTO student (id, fullName, age) VALUES
(1, 'Alice Kimani', 18),
(2, 'Brian Otieno', 19),
(3, 'Cynthia Njeri', 21);

UPDATE student
SET age = 20
WHERE id = 2;

-- Week 4 questions
SELECT paymentDate, SUM(amount) AS totalAmount
FROM payments
GROUP BY paymentDate
ORDER BY paymentDate DESC
LIMIT 5;

SELECT customerName, country, AVG(creditLimit) AS averageCreditLimit
FROM customers
GROUP BY customerName, country;

SELECT productCode, quantityOrdered, (quantityOrdered * priceEach) AS totalPrice
FROM orderdetails;

SELECT checkNumber, MAX(amount) AS highestAmount
FROM payments
GROUP BY checkNumber;

-- Week 5 questions
DROP INDEX IdxPhone ON customers;
DROP INDEX IdxPhone ON customers;
-- ALTER TABLE customers DROP INDEX IdxPhone;
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'S$cu3r3!';
GRANT INSERT ON salesDB.* TO 'bob'@'localhost';
ALTER USER 'bob'@'localhost' IDENTIFIED BY 'P$55!23';

-- Week 6 questions
SELECT e.firstName, e.lastName, e.email, e.officeCode
FROM employees e
INNER JOIN offices o ON e.officeCode = o.officeCode;

SELECT p.productName, p.productVendor, p.productLine
FROM products p
LEFT JOIN productlines pl ON p.productLine = pl.productLine;

SELECT o.orderDate, o.shippedDate, o.status, o.customerNumber
FROM customers c
RIGHT JOIN orders o ON c.customerNumber = o.customerNumber
LIMIT 10;

-- Week 7 questions
WITH ProductDetail AS (
    SELECT 101 AS OrderID, 'John Doe' AS CustomerName, 'Laptop, Mouse' AS Products
    UNION ALL
    SELECT 102, 'Jane Smith', 'Tablet, Keyboard, Mouse'
    UNION ALL
    SELECT 103, 'Emily Clark', 'Phone'
),
SplitProducts AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
    FROM 
        ProductDetail,
        (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3) n
    WHERE 
        n.n <= 1 + LENGTH(Products) - LENGTH(REPLACE(Products, ',', ''))
)
SELECT * FROM SplitProducts;

-- Orders table (eliminating partial dependency)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- OrderItems table (fully dependent on composite key)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

