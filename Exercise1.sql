									/*Exercise 1 of SQL assignment of Nagarro Freshers Training */

--Loading AdventureWorks Database
USE AdventureWorks2008R2 
Go              --For beginning new batch
--------------------------------------------------------------------------------------------------------

/*Ques1) Display the number of records in the [SalesPerson] table*/

Select COUNT(*) AS NUMBER_OF_RECORDS
From Sales.SalesPerson

/*Ques2) Select both the FirstName and LastName of records from the Person table where the FirstName begins with the letter 'B'*/

Select FirstName, LastName
From Person.Person
WHERE FirstName LIKE 'B%'

/*Ques3) Select a list of FirstName and LastName for employees where Title is one of Design Engineer, Tool Designer or Marketing Assistant*/

Select FirstName, LastName
From Person.person, HumanResources.Employee
WHERE Employee.JobTitle IN('Design Engineer', 'Tool Designer', 'Marketing Assistant')

/*Ques4) Display the Name and Color of the Product with the maximum weight.*/

Select Name, Color
From Production.Product
WHERE Weight=(Select MAX(Weight) From Production.Product)

/*Ques5) Display Description and MaxQty fields from the SpecialOffer table. 
		 Some of the MaxQty values are NULL, in this case display the value 0.00 instead.*/

--Using CASE method
Select SpecialOffer.Description, 
	CASE 
		WHEN MaxQty IS NULL THEN 0.00 
		ELSE MaxQty 
	END
	AS MaxQty
From Sales.SpecialOffer
--Using ISNULL() method
Select SpecialOffer.Description, ISNULL(MaxQty,0.00) AS MaxQty
From Sales.SpecialOffer
--Using colaesce() method
Select SpecialOffer.Description, coalesce(MaxQty,0.00) AS MaxQty
From Sales.SpecialOffer

/*Ques6) Display the overall Average of the [CurrencyRate].[AverageRate] values 
		 for the exchange rate ‘USD’ to ‘GBP’ for the year 2005 
		i.e. FromCurrencyCode = ‘USD’ and ToCurrencyCode = ‘GBP’. 
		Note: The field [CurrencyRate].[AverageRate] is defined as 'Average exchange rate for the day.'*/

Select AVG(AverageRate) AS 'Average Exchange Rate for the Day'
From Sales.CurrencyRate
WHERE (FromCurrencyCode='USD' AND ToCurrencyCode='GBP' AND YEAR(ModifiedDate)=2005)

/*Ques7) Display the FirstName and LastName of records from the Person table where FirstName contains the letters ‘ss’. 
		 Display an additional column with sequential numbers for each row returned beginning at integer 1*/

Select ROW_NUMBER() OVER(ORDER BY FirstName, LastName) AS 'S.No', FirstName, LastName
From Person.Person
WHERE FirstName LIKE '%ss%'

/*Ques8) Display the [SalesPersonID] with an additional column entitled ‘Commission Band’ indicating the appropriate band*/

Select BusinessEntityID AS 'SalesPersonID',
	CASE
		WHEN CommissionPct=0.00 THEN 'Band 0'
		WHEN CommissionPct>0.00 AND CommissionPct <=0.01 THEN 'Band 1'
		WHEN CommissionPct>0.01 AND CommissionPct <=0.015 THEN 'Band 2'
		ELSE 'Band 3'
	END 
	AS 'Commission Band'
From Sales.SalesPerson

/*Ques9) Display the managerial hierarchy from Ruth Ellerbrock (person type – EM) up to CEO Ken Sanchez. Hint: use [uspGetEmployeeManagers]*/

--using stored procedure of the adventure works database
DECLARE @temp AS INT   --declaring local variable temp of int type
SET @temp=(Select BusinessEntityID
		  From Person.Person
		  WHERE FirstName='Ruth' AND LastName='Ellerbrock' AND PersonType='EM')

EXECUTE dbo.uspGetEmployeeManagers @temp		--executing the procedure

/*Ques10). Display the ProductId of the product with the largest stock level. Hint: Use the Scalar-valued function [dbo]. [UfnGetStock]*/

--Using scaler value function of adventure works database
DECLARE @var AS INT		--declaring local variable var of int type
SET @var=(Select MAX(dbo.ufnGetStock(ProductID))			--storing max stock level in var
			From Production.Product)
Select ProductID, @var AS 'Stock Level'
From Production.Product
Where dbo.ufnGetStock(ProductID)=@var
-------------------------------------------------------------------------------------------------------------------------------------------------------

