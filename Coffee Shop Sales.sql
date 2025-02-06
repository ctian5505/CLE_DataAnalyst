I ask ChatGPT to generate task base on the data and here is the questions gpt genrate

/* 📌 Task 1: Daily Store Performance
We need to track our daily revenue for each store. Can you analyze and report the total daily sales revenue per store?*/
SELECT
	store_id AS 'Store ID',
	store_location AS 'Store Location',
	CAST(transaction_date AS DATE) AS 'Transaction Date',
	SUM(transaction_qty*unit_price) AS 'Revenue'
FROM 
	CoffeeShopTransactions
GROUP BY
	transaction_date, store_location, store_id
ORDER BY
	[Store ID], [Transaction Date]

/* 📌 Task 2: Best-Selling Product Category per Month
I want to know which product category sells the most each month. Can you determine the best-selling category per month based on total quantity sold? */
SELECT 
	product_category AS [Product Category],
	SUM(transaction_qty * unit_price) AS [Revenue],
	FORMAT(transaction_date, 'yyyy') AS [Year],
	FORMAT(transaction_date, 'MM') AS [Month],
	RANK() OVER(PARTITION BY FORMAT(transaction_date, 'MM'),FORMAT(transaction_date, 'yyyy') ORDER BY SUM(transaction_qty * unit_price) DESC) AS Rank
FROM 
	CoffeeShopTransactions
GROUP BY
	product_category,
	FORMAT(transaction_date, 'yyyy'),
	FORMAT(transaction_date, 'MM')
ORDER BY
	FORMAT(transaction_date, 'yyyy'), FORMAT(transaction_date, 'MM')

/* 📌 Task 3: Monthly Revenue Growth by Store
We need to identify which stores are growing and which are struggling. Can you calculate the month-over-month revenue growth for each store?*/


/* 📌 Task 4: High-Value Transactions
Some customers make large purchases, and I want to identify them. Can you find all transactions where the total value exceeds $50?*/


/* 📌 Task 5: Product Performance Ranking
I want to categorize our products into High, Medium, and Low performers based on total revenue. Can you rank all products and classify them accordingly?*/


/* 📌 Task 6: Slow-Moving Products
Which products are selling the least? I need a report on products that have the lowest total sales volume over the last 3 months.*/


/* 📌 Task 7: Store Location Profitability
Are some locations performing better than others? Can you analyze the top 3 highest and lowest earning store locations based on total revenue?*/


/* 📌 Task 8: Seasonal Sales Trends
I suspect that sales increase during certain months (e.g., holidays). Can you analyze our monthly sales trends to see if there are seasonal patterns?*/


/* 📌 Task 9: Customer Purchase Behavior
I want to know what types of products customers tend to buy together. Can you identify common product combinations in the same transaction?*/


/*  📌 Task 10: Price Impact on Sales
Does lowering or increasing the price of a product affect sales? Can you analyze how unit price variations impact sales volume for different products?*/

