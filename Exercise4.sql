										/*Exercise 4 of SQL assignment of Nagarro Freshers Training */

--Loading AdventureWorks Database
USE AdventureWorks2008R2 
Go              --For beginning new batch
--------------------------------------------------------------------------------------------------------
/*Ques) Create a function that takes as inputs a SalesOrderID, a Currency Code, and a date, and returns a table of all the SalesOrderDetail rows 
for that Sales Order including Quantity, ProductID, UnitPrice, and the unit price converted to the target currency based on the end of 
day rate for the date provided. Exchange rates can be found in the Sales.CurrencyRate table. */

-- Using Inline Table Function
CREATE FUNCTION dbo.getDetailSalesOrder(@SalesOrderID int, @CurrencyCode nchar(3), @CurrencyDate datetime)
RETURNS TABLE
	AS
	RETURN
	(
		Select SalesOrderID, SalesOrderDetailID, ProductID,OrderQty, UnitPrice*EndOfDayRate AS 'UnitPrice'
		From Sales.SalesOrderDetail, Sales.CurrencyRate
		Where SalesOrderID=@SalesOrderID AND ToCurrencyCode=@CurrencyCode AND CurrencyRateDate=@CurrencyDate
	)
GO
--Using MultiStatement Table Valued Function
CREATE FUNCTION dbo.getMultiSalesOrderDetail(@SalesOrderID int, @CurrencyCode nchar(3), @CurrencyDate datetime)
RETURNS @detail TABLE(SalesOrderID int, SalesOrderDetailID int, ProductID int,OrderQty smallint, UnitPrice int)
	AS
	BEGIN
		INSERT INTO @detail
		Select SalesOrderID, SalesOrderDetailID, ProductID,OrderQty, UnitPrice*EndOfDayRate 
		From Sales.SalesOrderDetail, Sales.CurrencyRate
		Where SalesOrderID=@SalesOrderID AND ToCurrencyCode=@CurrencyCode AND CurrencyRateDate=@CurrencyDate
	RETURN
	END
GO
Select *
From dbo.getDetailSalesOrder(43659,'JPY','2005-08-24 00:00:00.000');

Select *
From dbo.getMultiSalesOrderDetail(43659,'JPY','2005-08-24 00:00:00.000');
