									/*Exercise 6 of SQL assignment of Nagarro Freshers Training */

--Loading AdventureWorks Database
USE AdventureWorks2008R2 
GO				--For beginning new batch
---------------------------------------------------------------------------------------------------------------
/* Ques) Write a trigger for the Product table to ensure the list price can never be raised more than 15 Percent in a single change. Modify the 
		 above trigger to execute its check code only if the ListPrice column is updated (Use AdventureWorks Database)*/

CREATE TRIGGER checkPrice
ON Production.Product
FOR UPDATE
AS
IF  EXISTS(SELECT 1 FROM Product p JOIN deleted d ON p.ProductID=d.ProductID AND p.ListPrice-d.ListPrice>0.15*d.ListPrice)
BEGIN
RAISERROR('You can not update list price by more than 15percent', 16, 1)
ROLLBACK TRAN
RETURN
END
GO
/*
	Modified trigger uncomment and execute to see the changes
ALTER TRIGGER [Production].[checkPrice]
ON [Production].[Product]
FOR UPDATE
AS
SET NOCOUNT ON
IF UPDATE(ListPrice)
BEGIN
IF  EXISTS(SELECT 1 FROM Product p JOIN deleted d ON p.ProductID=d.ProductID AND p.ListPrice-d.ListPrice>0.15*d.ListPrice)
BEGIN
RAISERROR('You can not update list price by more than 15percent', 16, 1)
ROLLBACK TRAN
RETURN
END
END
SET NOCOUNT OFF
*/
Update Production.Product
Set ListPrice=20
Where ProductID=1
