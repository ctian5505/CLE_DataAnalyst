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

