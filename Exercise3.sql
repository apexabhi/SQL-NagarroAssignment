										/*Exercise 3 of SQL assignment of Nagarro Freshers Training */

--Loading AdventureWorks Database
USE AdventureWorks2008R2 
Go              --For beginning new batch
--------------------------------------------------------------------------------------------------------
/* Ques) Show the most recent five orders that were purchased from account numbers that have spent more than $70,000 with AdventureWorks*/

SELECT temp.sno,temp.SalesOrderID, temp.AccountNumber, temp.OrderDate
FROM (
    SELECT so.*,
        Total=SUM(sd.LineTotal) OVER (PARTITION BY so.AccountNumber),
        sno= ROW_NUMBER() OVER (PARTITION BY so.AccountNumber ORDER BY so.OrderDate DESC)
    FROM Sales.SalesOrderHeader so
    JOIN Sales.SalesOrderDetail sd ON so.SalesOrderID = sd.SalesOrderID
)temp
WHERE temp.Total>70000 AND sno<=5
