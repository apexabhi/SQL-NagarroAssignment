										/*Exercise 2 of SQL assignment of Nagarro Freshers Training */

--Loading AdventureWorks Database
USE AdventureWorks2008R2 
Go              --For beginning new batch
--------------------------------------------------------------------------------------------------------
/* Ques) Write separate queries using a join, a subquery, a CTE, and then an EXISTS 
		 to list all AdventureWorks customers who have not placed an order.*/

--Using Join

--LEFT JOIN
Select c.CustomerID
From Sales.Customer c 
	 LEFT JOIN Sales.SalesOrderHeader s ON c.CustomerID=s.CustomerID
WHERE (s.SalesOrderID IS NULL) 

--RIGHT JOIN
Select c.CustomerID
From Sales.SalesOrderHeader s
	 RIGHT JOIN  Sales.Customer c ON s.CustomerID=c.CustomerID
WHERE s.SalesOrderID IS NULL

--INNER JOIN
Select CustomerID
From Sales.Customer
WHERE CustomerID NOT IN
(Select c.CustomerID
From sales.Customer c
	 INNER JOIN sales.SalesOrderHeader s ON c.CustomerID=s.CustomerID)

--using SUBQUERY
Select CustomerID
From sales.Customer
WHERE CustomerID NOT IN
(Select CustomerID 
From sales.SalesOrderHeader)

--using CTE
WITH ctecust(CustomerID) --creating common table expression
AS
(
	Select CustomerID
	From sales.Customer
	WHERE CustomerID NOT IN
	(Select CustomerID 
	  From sales.SalesOrderHeader)
)
Select * From ctecust

--Using Exists
Select CustomerID
From Sales.Customer
WHERE CustomerID NOT IN(Select c.CustomerID
From Sales.Customer c
WHERE EXISTS 
(Select s.CustomerID 
From Sales.SalesOrderHeader s
WHERE s.CustomerID=c.CustomerID))

--using NOT EXISTS
Select c.CustomerID
From Sales.Customer c
WHERE NOT EXISTS 
(Select s.CustomerID 
From Sales.SalesOrderHeader s
WHERE c.CustomerID=s.CustomerID)


