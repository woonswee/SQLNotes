SELECT TOP (1000) [EmployeeID]
      ,[FirstName]
      ,[LastName]
      ,[Age]
      ,[Gender]

--#Selecting Commands -> COUNT, COUNT XX AS, MAX, MIN, AVG
  FROM [SQL Tutorial].[dbo].[EmployeeDemographics]
  SELECT *
  FROM EmployeeDemographics
  SELECT COUNT(LastName)
  FROM EmployeeDemographics

  SELECT MAX(Salary)
  FROM EmployeeSalary

  SELECT MIN(Salary)
  FROM EmployeeSalary
  
  SELECT AVG(Age)
  FROM EmployeeDemographics

--#Where Statements Commands -> =, <>, >, >=, <, <=, AND, OR, LIKE, %, NULL, NOT NULL
  SELECT *
  FROM [SQL Tutorial].[dbo].[EmployeeDemographics]
  WHERE FirstName = 'Jim'
  
  SELECT*
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE FirstName <> 'Jim'

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE Age > 30

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE Age >= 30

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE Age < 30

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE Age <= 30

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE Age <= 30 AND Gender = 'Male'

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE Age >= 30 OR Gender = 'Female'

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE LastName LIKE 'S%'

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE LastName LIKE '%S%'

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE LastName LIKE 'B%S%'

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE FirstName is NULL

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE FirstName is NOT NULL

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE FirstName IN ('Jim', 'Michael')

--# GROUP BY, ORDER BY, Asc, Desc, Column name as Column number
  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  ORDER BY Age, Gender 

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  ORDER BY Age DESC

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  ORDER BY 4 Desc, 5 Desc

  SELECT *
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  ORDER BY Age, Gender DESC

  SELECT Gender, Age, COUNT(Gender) AS GenderFreq
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  GROUP BY Gender, Age

  SELECT Gender, COUNT(Gender) AS GenderFreq
  FROM [SQL Tutorial].[dbo].EmployeeDemographics
  WHERE Age > 31
  GROUP BY Gender
  ORDER BY GenderFreq DESC

  --#Inner Joins, Full/Left/Right Outer Joins
SELECT * 
FROM [SQL Tutorial].dbo.EmployeeDemographics
Inner Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT * 
FROM [SQL Tutorial].dbo.EmployeeDemographics
Full Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT * 
FROM [SQL Tutorial].dbo.EmployeeDemographics
Left Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT * 
FROM [SQL Tutorial].dbo.EmployeeDemographics
Right Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM [SQL Tutorial].dbo.EmployeeDemographics
Right Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT * 
FROM [SQL Tutorial].dbo.EmployeeDemographics
Inner Join [SQL Tutorial].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

SELECT JobTitle, AVG(Salary)
FROM [SQL Tutorial].dbo.EmployeeDemographics
Inner Join [SQL Tutorial].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle 

--# Union, Union All

SELECT *
FROM [SQL Tutorial].dbo.EmployeeDemographics
UNION 
SELECT *
FROM WareHouseEmployeeDemographics

SELECT *
FROM [SQL Tutorial].dbo.EmployeeDemographics
UNION ALL
SELECT *
FROM WareHouseEmployeeDemographics
ORDER BY EmployeeID

SELECT EmployeeID, FirstName, Age              
FROM [SQL Tutorial].dbo.EmployeeDemographics
UNION
SELECT EmployeeID, JobTitle, Salary
FROM [SQL Tutorial].dbo.EmployeeSalary
ORDER BY EmployeeID
--^^^^ THIS IS A WRONG EXAMPLE. The columns are not the same, different type of data, thus when you run it, it gives weird values misaligning with the columns

--# Case Statement

SELECT FirstName, LastName, Age,
CASE 
	WHEN Age > 30 THEN 'Old'
	ELSE 'Young'
END AS 'Status'
FROM [SQL Tutorial].dbo.EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

SELECT FirstName, LastName, Age,
CASE 
	WHEN Age = 38 THEN 'Stanley'
	WHEN Age > 30 THEN 'Old'
	ELSE 'Young'
END AS 'Status'
FROM [SQL Tutorial].dbo.EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

--# Combining Join and Case Statement to calculate salary increment for employees 

SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * 0.000001)
	ELSE Salary + (Salary * .03)
END AS 'SalaryIncrement'
FROM [SQL Tutorial].dbo.EmployeeDemographics
Join [SQL Tutorial].dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

--Having (Similar to WHERE, used for group data instead of individual rows)

SELECT JobTitle, AVG(Salary) AS 'AverageSalary'
FROM [SQL Tutorial].dbo.EmployeeDemographics
JOIN [SQL Tutorial].dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING Avg(Salary) > 45000
ORDER BY Avg(Salary)

-- Updating/Deleting Data

SELECT *
FROM [SQL Tutorial].dbo.EmployeeDemographics
ORDER BY EmployeeID

UPDATE [SQL Tutorial].dbo.EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'

DELETE FROM [SQL Tutorial].dbo.EmployeeDemographics
WHERE EmployeeID = 1005

-- ^^ Beware of Delete function as it is irreversible. ]

--Aliasing Column Names (AS) -> To make your script neat for others to read

SELECT FirstName + ' ' + LastName AS FullName  
FROM [SQL Tutorial].dbo.EmployeeDemographics

SELECT Avg(Age) AS AvgAge
FROM [SQL Tutorial].dbo.EmployeeDemographics

-- Alising Table Names (AS)

SELECT Demo.EmployeeID, Sal.Salary 
FROM [SQL Tutorial].dbo.EmployeeDemographics AS Demo 
JOIN [SQL Tutorial].dbo.EmployeeSalary AS Sal 
	ON Demo.EmployeeID = Sal.EmployeeID

-- Partition By (This is similar to Group By)

SELECT FirstName, LastName, Gender, Salary 
, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender 
FROM [SQL Tutorial].dbo.EmployeeDemographics as dem
JOIN [SQL Tutorial].dbo.EmployeeSalary as sal
	ON dem.EmployeeID = sal.EmployeeID

	-- ^^ How many male and female employees there are

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender)
FROM [SQL Tutorial].dbo.EmployeeDemographics as dem
JOIN [SQL Tutorial].dbo.EmployeeSalary as sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary 

SELECT Gender, COUNT(Gender)
FROM [SQL Tutorial].dbo.EmployeeDemographics
JOIN [SQL Tutorial].dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY Gender

--CTEs -> a temporary set of data/table produced, not stored anywhere

WITH CTE_Employee AS 
(SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary 
FROM [SQL Tutorial].dbo.EmployeeDemographics as dem
JOIN [SQL Tutorial].dbo.EmployeeSalary as sal
	ON dem.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary
FROM CTE_Employee

-- Temp Tables -> 

CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

SELECT *
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES
('1001', 'HR', '45000')

INSERT INTO #temp_Employee
SELECT *
FROM [SQL Tutorial].dbo.EmployeeSalary
-- ^^ This is how usually people create table NOT the manual key in way.

DROP TABLE IF EXISTS #Temp_Employee2 -> To allow you to create the table over and over again 
CREATE TABLE #Temp_Employee2 
(JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

SELECT *
FROM #Temp_Employee2

INSERT INTO #Temp_Employee2 
SELECT JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
FROM [SQL Tutorial].dbo.EmployeeDemographics as Dem
JOIN [SQL Tutorial].dbo.EmployeeSalary as Sal
	ON Dem.EmployeeID = Sal.EmployeeID
GROUP BY JobTitle

--String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

CREATE TABLE EmployeeErrors
(EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50))

INSERT INTO EmployeeErrors VALUES
('1001  ', 'Jimbo', 'Halbert'),
('  1002', 'Pamela', 'Beasley'),
('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors

--Using TRIM -> to remove both left and right side spaces. TRIM(Column that you want to trim)

Select EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

-- Using LTRIM -> to remove ONLY left side spaces. TRIM(Column you want to trim)

Select EmployeeID, LTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

-- Using RTRIM -> to remove ONLY right side spaces. TRIM(Column you want to trim)

Select EmployeeID, RTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

-- Using Replace. REPLACE(Column, 'value', 'whatyouwanttoreplacewith')

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors

-- Using Substring. SUBSTRING(Column, start, length)

SELECT SUBSTRING(FirstName, 3,3)
FROM EmployeeErrors

SELECT err.FirstName, dem.FirstName
FROM EmployeeErrors as err
JOIN [SQL Tutorial].dbo.EmployeeDemographics as dem
	ON err.FirstName = dem.FirstName

-- ^^ This only returns Toby because it is the only similar data between EmployeeErrors and EmployeeDemographics table

SELECT SUBSTRING(err.FirstName,1,3), SUBSTRING(dem.FirstName,1,3)
FROM EmployeeErrors as err
JOIN [SQL Tutorial].dbo.EmployeeDemographics as dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)

-- ^^ To return all 3 data from EmployeeErrors, use SUBSTRING to get the first 3 letters of the LastNames which are identical in both tables

-- Using LOWER -> makes the characters lowercase

Select FirstName, LOWER(FirstName)
FROM EmployeeErrors

-- Using UPPER -> makes the characters uppercase

Select FirstName, UPPER(FirstName)
FROM EmployeeErrors

-- Stored Procedures -> group of statements created and stored in database

CREATE PROCEDURE TEST
AS
SELECT *
FROM [SQL Tutorial].dbo.EmployeeDemographics

EXEC TEST

-- More complicated query with temp tables

--CREATE PROCEDURE Temp_Employee
--AS
--CREATE TABLE #temp_employee
--(JobTitle varchar(100),
--EmployeesPerJob int,
--AvgAge int,
--AvgSalary int)

--INSERT INTO #temp_employee
--SELECT JobTitle, Count(JobTitle), Avg(Age), Avg(salary)
--FROM [SQL Tutorial].dbo.EmployeeDemographics as emp
--JOIN [SQL Tutorial].dbo.EmployeeSalary as sal
--	ON emp.EmployeeID = sal.EmployeeID
--GROUP BY JobTitle 

--SELECT *
--FROM #temp_employee

--EXEC Temp_Employee @JobTitle = 'Salesman'

HELP^^^^

-- Subqueries -> query in a query 

SELECT *
FROM EmployeeSalary

-- Subquery in SELECT

SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary

-- How to do it with Partition By (^^ Same result as above, just different way)

SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary 
FROM EmployeeSalary

-- GROUP BY does not work as shown below

SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary 
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY 1,2

-- Subquery in FROM (Not recommended although it works, temp tables or CTEs recommended instead)

SELECT a.EmployeeID, AllAvgSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () as AllAvgSalary
	FROM EmployeeSalary) as a 

-- SUBQUERY in WHERE 
--Only want employees over the age of 30. Instead of joining with another table to show the age, you can use this subquery instead.
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
	SELECT EmployeeID
	FROM EmployeeDemographics
	WHERE Age > 30)