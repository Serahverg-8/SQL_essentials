-- Like group by but partitons the dataset and performs the fucntions. 
-- Maintains the row level detail
-- OVER(PARTION BY id , orderqty)



-- 1)
-- "AvgPriceByCategory " that returns the average ListPrice for the product category in each given row.
-- "AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.
-- "ProductVsCategoryDelta" that returns the result of the following calculation:
--A product's list price, MINUS the average ListPrice for that product’s category.


SELECT 
  ProductName = A.Name,
  A.ListPrice,
  ProductSubcategory = B.Name,
  ProductCategory = C.Name,
  AvgPriceByCategory = AVG(A.ListPrice) OVER(PARTITION BY C.Name),
  AvgPriceByCategoryAndSubcategory = AVG(A.ListPrice) OVER(PARTITION BY C.Name, B.Name),
  ProductVsCategoryDelta = A.ListPrice - AVG(A.ListPrice) OVER(PARTITION BY C.Name)

FROM AdventureWorks2019.Production.Product A
  JOIN AdventureWorks2019.Production.ProductSubcategory B
    ON A.ProductSubcategoryID = B.ProductSubcategoryID
  JOIN AdventureWorks2019.Production.ProductCategory C
    ON B.ProductCategoryID = C.ProductCategoryID