										/*Exercise 5 of SQL assignment of Nagarro Freshers Training */

--Loading AdventureWorks Database
USE AdventureWorks2008R2 
GO				--For beginning new batch
-----------------------------------------------------------------------------------------------------------
/* Ques) Write a Procedure supplying name information from the Person.Person table and accepting a filter for the first name. Alter the above 
		Store Procedure to supply Default Values if user does not enter any value.( Use AdventureWorks)*/

CREATE PROCEDURE dbo.uspGetFirstName(@ID int)
AS
BEGIN
	Select FirstName 
	From Person.Person
	WHERE BusinessEntityID=@ID
END

GO
--Modified procedure uncomment and execute to see the changes
/*
ALTER PROCEDURE [dbo].[uspGetFirstName](@ID int=1)
AS
BEGIN
	IF((Select COUNT(FirstName) From Person.Person WHERE BusinessEntityID=@ID)>0)
	Select FirstName 
	From Person.Person
	WHERE BusinessEntityID=@ID
	ELSE
	Select 'This ID does not exist'
END
*/
--Using default parameter
EXEC dbo.uspGetFirstName 

--Passing Parameter
EXEC dbo.uspGetFirstName 900

EXEC dbo.uspGetFirstName 1103