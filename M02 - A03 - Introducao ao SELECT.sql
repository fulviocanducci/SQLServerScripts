/*************************************************
 Curso T-SQL
 Autor: Landry

 Demonstração:
 - Introdução ao comando SELECT
 - Filtro vertical
 - Filtro horizontal
 - LIKE
 - AND e BETWEEN
 - OR e IN
 - ORDER BY
*************************************************/
use AdventureWorksLT
go

SELECT * FROM SalesLT.Customer

/*****************************
 Filtro vertical
******************************/
SELECT CustomerID, LastName, FirstName, Title
FROM SalesLT.Customer
-- 847

/*****************************
 Filtro horizontal
******************************/
SELECT CustomerID, LastName, FirstName, Title
FROM SalesLT.Customer
WHERE CustomerID = 5

SELECT CustomerID, LastName, FirstName, Title
FROM SalesLT.Customer
WHERE Title = N'Ms.'

SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE ListPrice >= 100

/***********
 LIKE
************/
SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Name LIKE '%Road%'

SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Name LIKE 'Road%'

SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Name LIKE 'M_u_t%'

SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Name LIKE '[AC]%'

SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Name LIKE '[A-C]%'

SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Name LIKE '[^A-C]%'

SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Name LIKE '[^B]%'

SELECT ProductID, Name, Color, ListPrice
FROM SalesLT.Product
WHERE Name LIKE '[C][l]%'


/****************************
 AND e BETWEEN
*****************************/
-- AND
SELECT ProductID, Name, Color, ListPrice
FROM  SalesLT.Product
WHERE ListPrice >= 100 AND ListPrice <= 1000
-- 119 linhas

-- BETWEEN
SELECT ProductID, Name, Color, ListPrice
FROM  SalesLT.Product
WHERE ListPrice BETWEEN 100 AND 1000
-- 119 linhas

/****************************
 OR e IN
*****************************/
-- OR
SELECT ProductID, Name, Color, ListPrice
FROM  SalesLT.Product
WHERE Color = 'Blue' or Color = 'Black'
-- 115 linhas

-- IN
SELECT ProductID, Name, Color, ListPrice
FROM  SalesLT.Product
WHERE Color IN ('Blue', 'Black')
-- 115 linhas

-- IN dinâmico
SELECT ProductID, Name, Color, ListPrice
FROM  SalesLT.Product
WHERE ProductID IN (SELECT distinct ProductID FROM SalesLT.SalesOrderDetail)

-- Combinando AND e OR
SELECT ProductID, Name, Color, ListPrice
FROM  SalesLT.Product
WHERE (Name LIKE 'C%' OR Color = 'Blue') AND  (ListPrice > 100.00) 
-- 22 linhas


/*******************************
 ORDER BY
 - Ordenando o resultado
********************************/
-- ORDER BY
SELECT ProductcategoryID,ProductID, Name, Color, ListPrice
FROM  SalesLT.Product
ORDER BY ProductcategoryID, ListPrice DESC

SELECT ProductcategoryID,ProductID, Name, Color, ListPrice
FROM  SalesLT.Product
ORDER BY 1, 5 DESC

SELECT ProductcategoryID,ProductID, Name as Product, Color, ListPrice
FROM  SalesLT.Product
ORDER BY Product


SELECT Customer.*, CustomerAddress.CustomerID FROM SalesLT.Customer, SalesLT.CustomerAddress
WHERE Customer.CustomerID = CustomerAddress.CustomerID




