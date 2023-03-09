/************ Expert Level ************/

/*1. Select the most expensive product*/
SELECT ProductID,ProductName,Price
FROM products
ORDER BY Price DESC
LIMIT 1;

/*2. Select the second most expensive product*/
/*version 1*/
SELECT ProductID,ProductName,Price
FROM products
ORDER BY Price DESC
LIMIT 1 OFFSET 1;


/*3. Select name and price of each product, sort the result by price in decreasing order*/
SELECT ProductID,ProductName,Price
FROM products
ORDER BY Price DESC;

/*4. Select 5 most expensive products*/
SELECT ProductID,ProductName,Price
FROM products
ORDER BY Price DESC
LIMIT 5;



/*5. Select 5 most expensive products without the most expensive (in final 4 products)*/
SELECT ProductID,ProductName,Price
FROM products
ORDER BY Price DESC
LIMIT 4 OFFSET 1;





/*7. Select name of the cheapest product (only name) using subquery*/
SELECT ProductName
FROM products
WHERE Price IN (
	SELECT MIN(Price) FROM products
);

/*8. Select number of employees with LastName that starts with 'D'*/
SELECT EmployeeID, LastName, FirstName
FROM employees
WHERE LastName LIKE 'D%';

/* BONUS : same question for Customer this time */
SELECT CustomerName, SUBSTRING_INDEX(CustomerName," ",1) AS firstName, SUBSTRING_INDEX(CustomerName," ",-1) AS lastName
FROM customers
WHERE  SUBSTRING_INDEX(CustomerName," ",-1) LIKE 'D%';

/*9. Select customer name together with the number of orders made by the corresponding customer 
sort the result by number of orders in decreasing order*/
SELECT c.CustomerID, c.CustomerName, COUNT(*) AS 'TotalOder'
FROM customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY 3 DESC, 1 ASC;

/*10. Add up the price of all products*/
SELECT SUM(Price)
FROM products;

/*11. Select orderID together with the total price of  that Order, order the result by total price of order in increasing order*/
SELECT od.OrderID, SUM((od.Quantity * p.Price)) AS TotalValueOfOrder
FROM order_details od
JOIN products p ON p.ProductID = od.ProductID
GROUP BY 1
ORDER BY 2 ASC;

/*12. Select customer who spend the most money*/
SELECT c.CustomerID, c.CustomerName, SUM(od.Quantity * p.Price) AS TotalSpending
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID
JOIN order_details od ON o.OrderID = od.OrderID
JOIN products p ON p.ProductID = od.ProductID
GROUP BY c.CustomerID
ORDER BY 3 DESC
LIMIT 1;

/*13. Select customer who spend the most money and lives in Canada*/
SELECT c.CustomerID, c.CustomerName, SUM(od.Quantity * p.Price) AS TotalSpending, c.Country
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID
JOIN order_details od ON o.OrderID = od.OrderID
JOIN products p ON p.ProductID = od.ProductID
WHERE c.Country LIKE 'Canada'
GROUP BY c.CustomerID
ORDER BY 3 DESC
LIMIT 1;

/*14. Select customer who spend the second most money*/
SELECT c.CustomerID, c.CustomerName, SUM(od.Quantity * p.Price) AS TotalSpending
FROM orders o
JOIN customers c ON o.CustomerID = c.CustomerID
JOIN order_details od ON o.OrderID = od.OrderID
JOIN products p ON p.ProductID = od.ProductID
GROUP BY c.CustomerID
ORDER BY 3 DESC
LIMIT 1 OFFSET 1;

/*15. Select shipper together with the total price of proceed orders*/
SELECT o.ShipperID, shp.ShipperName, SUM(od.Quantity * p.Price) AS TotalValueOfOrder
FROM orders o
JOIN order_details od ON o.OrderID = od.OrderID
JOIN products p ON p.ProductID = od.ProductID
JOIN shippers shp ON shp.ShipperID = o.ShipperID
GROUP BY 1
ORDER BY 2;