# AdventureWorks-DataAnalytics
Customer and Order data analysis of the famous Microsoft dataset Adventure Works. I have used SQL for the data filtering and manipulation and Power BI for the visualization.

## Order Data Analysis
For the analysis of order data, these questions have been answered:
1. What is the number of orders by countries?
2. What is the number of orders by calender month?
3. What is the number of orders by calender year?
4. What is the average money spent per order?
5. What is the average order per day?

### SQL Codes
All the orders related data has been filtered using this code:
```
SELECT 
	*
FROM
	FactInternetSales f
JOIN DimGeography g ON f.SalesTerritoryKey = g.SalesTerritoryKey
JOIN DimProduct p ON f.ProductKey = p.ProductKey
```
Average order per day has been extracted using this:
```
SELECT 
    AVG(DailyOrderCount) AS AverageOrdersPerDay
FROM (
    SELECT 
        CONVERT(DATE, OrderDate) AS OrderDate,  
        COUNT(*) AS DailyOrderCount
    FROM 
        DimInternetSales  
    GROUP BY 
        CONVERT(DATE, OrderDate)
) AS DailyOrders;
```
Average spent on an order has been extracted using this:
```
SELECT 
	AVG(TotalProductCost) AS AvgMoneySpent 
FROM 
	[dbo].[FactInternetSales]
```
Rest of the data has been filtered using the Power BI interface.

### Snippet of the dashboard
![image](https://github.com/user-attachments/assets/0989ce90-c347-4a82-be52-abf61877d26f)

## Customer Data Analysis
For the analysis of customer data, these questions have been answered:
1. Which country has the majority of customers?
2. What is the age range of customers?
3. At which point of time has there been highest number of new customers?
4. What is the customer returning rate?

### SQL Codes
All the order related data has been filtered using this:
```
SELECT 
	*
FROM 
	[dbo].[FactInternetSales] as i
JOIN DimCustomer c ON i.CustomerKey = c.CustomerKey
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey
```
Calculating the customer return rate:
```
-- Step 1: Count total unique customers
WITH TotalCustomers AS (
    SELECT COUNT(DISTINCT fs.CustomerKey) AS TotalCustomerCount
    FROM FactInternetSales fs
)

-- Step 2: Identify returning customers (those with more than one order)
, ReturningCustomers AS (
    SELECT CustomerKey
    FROM FactInternetSales 
    GROUP BY CustomerKey
    HAVING COUNT(SalesOrderNumber) > 1
)

-- Step 3: Count total returning customers
, TotalReturningCustomers AS (
    SELECT COUNT(CustomerKey) AS ReturningCustomerCount
    FROM ReturningCustomers
)

-- Step 4: Calculate returning rate
SELECT 
    (CAST(ReturningCustomerCount AS DECIMAL) / TotalCustomerCount) * 100 AS ReturningRate
FROM TotalCustomers, TotalReturningCustomers;
```
### Snippet of the dashboard
![image](https://github.com/user-attachments/assets/53266aa7-a41d-4041-8167-61d2dab82f1f)

## Conclusion
From this project, I've learned the basics of Power BI and how SQL and Power BI can be integrated together. As of now I have done analysis on Order and Customer data, in the future I plan on analyzing sales data and whatever interests me. Thanks for going over my project and im always open for feedback. Cheers!!
