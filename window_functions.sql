-- Window functions helps perform sum and count etc across all the rows unlike aggregate functions whihch collapse the rows.
-- Window functions help maintan the row data and also can perform agg functions.


-- OVER()   --> keyword

--1) using the over() to do operations on each row

SELECT BusinessEntityID
      ,TerritoryID
      ,SalesQuota
      ,Bonus
      ,CommissionPct
      ,SalesYTD
	  ,SalesLastYear
      ,[Total YTD Sales] = SUM(SalesYTD) OVER()
      ,[Max YTD Sales] = MAX(SalesYTD) OVER()
      ,[% of Best Performer] = SalesYTD/MAX(SalesYTD) OVER()

FROM AdventureWorks2019.Sales.SalesPerson

-- 2) A derived column called "AverageRate" that returns the average of all values in the "Rate" column, in each row
-- "MaximumRate" that returns the largest of all values in the "Rate" column, in each row
-- An employees's pay rate, MINUS the average of all values in the "Rate" column.
-- An employees's pay rate, DIVIDED BY the maximum of all values in the "Rate" column, times 100


SELECT 
 B.FirstName,
 B.LastName,
 C.JobTitle,
 A.Rate,
 AverageRate = AVG(A.Rate) OVER()
 MaximumRate = MAX(A.Rate) OVER(),
 DiffFromAvgRate = A.Rate - AVG(A.Rate) OVER(),
 PercentofMaxRate = (A.Rate / MAX(A.Rate) OVER()) * 100

FROM AdventureWorks2019.HumanResources.EmployeePayHistory A
	JOIN AdventureWorks2019.Person.Person B
		ON A.BusinessEntityID = B.BusinessEntityID
	JOIN AdventureWorks2019.HumanResources.Employee C
		ON A.BusinessEntityID = C.BusinessEntityID


