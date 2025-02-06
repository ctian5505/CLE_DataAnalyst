/*
AdventureWorks sample databases Query Samples
Files : AdventureWorksDW2022.bak (https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms
)
*/

-- Find the top 10 customers together with their customer key, first name, last name, and email address.
SELECT 
	TOP 10
	CustomerKey,
	FirstName,
	LastName,
	EmailAddress	
FROM 
	DimCustomer

 -- Query to display the list of tables inside the database
SELECT
	*
FROM
	sys.tables


-- Retrieve the first 5 products from the product table.
SELECT  
	TOP 5 * 
FROM 
DimProduct


-- Get the top 10 employees from the employee along with their job titles
SELECT 
	TOP 10
	EmployeeKey,
	CONCAT(FirstName,' ',MiddleName,' ',LastName) AS Fullname,
	Title AS 'Job Title'
FROM 
	DimEmployee

-- Retrieve all orders placed by customer 'John Smith' (FirstName = 'John' and LastName = 'Smith') from the [dbo].[FactInternetSales] table.

	-- Using Left Join
SELECT 
	*
FROM 
	FactInternetSales AS FIS
LEFT JOIN 
	DimCustomer AS DC
ON 
	FIS.CustomerKey = DC.CustomerKey
WHERE 
	DC.FirstName = 'John' AND DC.LastName = 'Smith'

	-- Using Subquery
SELECT 
	*
FROM 
	FactInternetSales
WHERE CustomerKey = (
	SELECT CustomerKey FROM DimCustomer WHERE FirstName = 'John' AND LastName = 'Smith'
	)

-- Get all products with a weight greater than 10 pounds (Weight > 10) from the [dbo].[DimProduct] table.
SELECT *
FROM DimProduct
WHERE Weight > 10 AND WeightUnitMeasureCode = 'LB'

-- Get the top 5 products with the lowest list prices from the [dbo]. [DimProduct] table.
SELECT 
	TOP 10 *
FROM
	DimProduct
WHERE
	ListPrice IS NOT NULL
ORDER BY
	ListPrice


-- Retrieve the 10 oldest orders from the [dbo].[FactInternetSales] table, sorted by the order date in ascending order.
SELECT 
	TOP 10 *
FROM
	FactInternetSales
ORDER BY
	OrderDate

/*
Insert a new product with the following details into the [dbo].[DimProduct] table:
ProductKey: 9999
EnglishProduct Name : DSA Training
Color: Gold'
Size: 'XXL'
ListPrice: 49.99
*/

INSERT INTO DimProduct(ProductKey, EnglishProductName,Size, Color, ListPrice)
VALUES (9999, 'DSA Training','XXL','Gold', 49.99)


-- Update the job Title of the employee with EmployeelD 101 in the [dbo].[DimEmployee] table to 'Software Engineer.' [Production Technician - WC45 to Software Engineer ]
UPDATE DimEmployee
SET Title = 'Software Engineer'
WHERE EmployeeKey = 101

-- Retrieve all products that have been ordered by customer 'John Smith' (FirstName = John' and LastName = Smith').
SELECT 
	 ProductKey, EnglishProductName, color, Size
FROM 
	DimProduct 
WHERE 
	ProductKey IN ( 
		SELECT 
			ProductKey 
		FROM 
			FactInternetSales 
		WHERE CustomerKey IN ( 
			SELECT 
				CustomerKey 
			FROM 
				DimCustomer 
			WHERE 
				FirstName = 'John' AND LastName = 'Smith'))

-- Retrieve all orders along with customer details for orders placed on or after January 1, 2014, from the dbo.FactinternetSales and dimCustomer tables.
SELECT 
	ProductKey, 
	OrderDateKey,
	OrderQuantity,
	UnitPrice,
	OrderDate
FROM 
	FactInternetSales AS FIS
LEFT JOIN
	DimCustomer AS DC
ON
	FIS.CustomerKey = DC.CustomerKey
WHERE
	OrderDate >= '2014-01-01'

/*Calculate the total sales amount for each product
category from the dbo.DimProduct and
dbo.FactInternetSales tables. Display the results
with the category name, subcategory name and
the total sales amount order by category name. */
SELECT
	DP.EnglishProductName,
	DPS.EnglishProductSubcategoryName AS 'Subcategory',
	DPC.EnglishProductCategoryName AS 'Category',
	SUM(FIS.UnitPrice * FIS.OrderQuantity) AS Total
FROM 
	FactInternetSales AS FIS
LEFT JOIN 
	DimProduct AS DP
ON 
	FIS.ProductKey = DP.ProductKey
LEFT JOIN
	DimProductSubcategory AS DPS
ON
	DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
LEFT JOIN
	DimProductCategory AS DPC
ON
	DPS.ProductCategoryKey = DPC.ProductCategoryKey
GROUP BY
	DP.EnglishProductName,
	DPS.EnglishProductSubcategoryName,
	DPC.EnglishProductCategoryName
ORDER BY
	Category DESC

/*Retrieve the top 5 customers with the highest total
purchases from the [dbo].[DimCustomer] and
[dbo].[FactInternetSales] tables. Display
customer details along with their total purchases.

TOP 5 Customer highest total pruchase and display customer details
Customer name and total purchase

*/

SELECT
	TOP 5
	CONCAT(DC.FirstName,' ',DC.LastName,' ',DC.MiddleName) AS 'Customer_Full_Name',
	SUM(FIS.UnitPrice*OrderQuantity) AS Total_Purchase
FROM FactInternetSales AS FIS
LEFT JOIN
DimCustomer AS DC
ON
	FIS.CustomerKey = DC.CustomerKey
GROUP BY
	CONCAT(DC.FirstName,' ',DC.LastName,' ',DC.MiddleName)
ORDER BY
	Total_Purchase DESC

/*Find the average quantity and total sales amount
of products sold in each month of the year 2011
from the [dbo].[DimProduct] and
[dbo].FactResellerSales tables. 
*/
SELECT
	MONTH(FRS.OrderDate) AS 'Month_no',
	AVG(OrderQuantity) AS 'Average Quantity',
	AVG(SalesAmount) AS 'Average Sales'
FROM	
	FactResellerSales AS FRS
LEFT JOIN
	DimProduct AS DP
ON
	FRS.ProductKey = DP.ProductKey
WHERE 
	YEAR(OrderDate) = '2011'
GROUP BY
	MONTH(FRS.OrderDate)
ORDER BY
	Month_no
