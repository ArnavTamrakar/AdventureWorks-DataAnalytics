-- ALL DATA REQUIRED FOR CUSTOMER DASHBOARD
SELECT 
	*
FROM 
	[dbo].[FactInternetSales] as i
JOIN DimCustomer c ON i.CustomerKey = c.CustomerKey
JOIN DimGeography g ON c.GeographyKey = g.GeographyKey


-- CALCULATING CUSTOMER RETURN RATE

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



