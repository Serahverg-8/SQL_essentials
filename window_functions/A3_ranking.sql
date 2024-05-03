-- Ranking all recods within each group

-- ROW_NUMBER() -- function must have the over clause with ORDER BY
-- it ranks based on order by

-- only sequential rankings. 
-- 2 elements with same value has different ranks

-- 1)ROW_NUMBER()
-- "Price Rank " that ranks all records in the dataset by ListPrice, in descending order. 
-- Category Price Rank" that ranks all products by ListPrice – within each category 
--"Top 5 Price In Category" that returns the string “Yes” if a product has one of the top 5 list prices in its product category, and “No” if it does not.


SELECT 
  ProductName = A.Name,
  A.ListPrice,
  ProductSubcategory = B.Name,
  ProductCategory = C.Name,
  [Price Rank] = ROW_NUMBER() OVER(ORDER BY A.ListPrice DESC),
  [Category Price Rank] = ROW_NUMBER() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC),
  [Top 5 Price In Category] = 
	CASE 
		WHEN ROW_NUMBER() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC) <= 5 THEN 'Yes'
		ELSE 'No'
	END


FROM AdventureWorks2019.Production.Product A
  JOIN AdventureWorks2019.Production.ProductSubcategory B
    ON A.ProductSubcategoryID = B.ProductSubcategoryID
  JOIN AdventureWorks2019.Production.ProductCategory C
    ON B.ProductCategoryID = C.ProductCategoryID




-- 2) RANK function (handles ties)
-- RANK() OVER()
-- same value same rank and then skips the values
-- 1,2 ,3,3,3,3,8,9,10


--3) DENSE_RANK() same as rank but no skipping in values
--1,2 ,3,3,3,3,4,5,6



SELECT 
  ProductName = A.Name,
  A.ListPrice,
  ProductSubcategory = B.Name,
  ProductCategory = C.Name,
  [Price Rank] = ROW_NUMBER() OVER(ORDER BY A.ListPrice DESC),
  [Category Price Rank] = ROW_NUMBER() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC),
  [Category Price Rank With Rank] = RANK() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC),
  [Category Price Rank With Dense Rank] = DENSE_RANK() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC),
  [Top 5 Price In Category] = 
	CASE 
		WHEN DENSE_RANK() OVER(PARTITION BY C.Name ORDER BY A.ListPrice DESC) <= 5 THEN 'Yes'
		ELSE 'No'
	END


  FROM AdventureWorks2019.Production.Product A
  JOIN AdventureWorks2019.Production.ProductSubcategory B
  ON A.ProductSubcategoryID = B.ProductSubcategoryID
  JOIN AdventureWorks2019.Production.ProductCategory C
  ON B.ProductCategoryID = C.ProductCategoryID
