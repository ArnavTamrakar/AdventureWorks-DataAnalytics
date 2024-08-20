-- ALL DATA RELATED TO ORDERS
SELECT 
	*
FROM
	FactInternetSales f
JOIN DimGeography g ON f.SalesTerritoryKey = g.SalesTerritoryKey
JOIN DimProduct p ON f.ProductKey = p.ProductKey


-- HIGHEST NUMBER OF ORDERS BY COUNTRY
SELECT 
	COUNT(SalesOrderNumber) AS number_of_order,
	g.SalesTerritoryCountry
FROM 
	[dbo].[FactInternetSales] i
	JOIN DimSalesTerritory g
	ON G.SalesTerritoryKey = i.SalesTerritoryKey
GROUP BY g.SalesTerritoryCountry
ORDER BY COUNT(SalesOrderNumber) DESC

-- TOP 10 BEST SELLERS
SELECT 
	p.[EnglishProductName],
	COUNT(*) AS OrderCount
FROM 
	FactInternetSales i
	JOIN DimProduct p
	ON i.ProductKey = p.ProductKey
GROUP BY 
	p.[EnglishProductName]
ORDER BY 
	COUNT(*) DESC

-- NUMBER OF ORDER BY MONTH
SELECT 
    DATENAME(MONTH, OrderDate) AS MonthName,
    COUNT(*) AS OrderAmount,
	MONTH(OrderDate)
FROM 
    FactInternetSales
GROUP BY 
    DATENAME(MONTH, OrderDate), 
    MONTH(OrderDate)
ORDER BY 
    MONTH(OrderDate)

-- NUMBER OF ORDERS BY YEAR
SELECT 
	YEAR(d.FullDateAlternateKey) AS 'Year',
	COUNT(*) AS OrderAmount
FROM 
	FactInternetSales i
	JOIN DimDate d
	ON d.DateKey = i.OrderDateKey
GROUP BY 
	YEAR(d.FullDateAlternateKey)
ORDER BY
	YEAR(d.FullDateAlternateKey)

-- AVERAGE MOENY SPENT ON AN ORDER
SELECT 
	AVG(TotalProductCost) AS AvgMoneySpent 
FROM 
	[dbo].[FactInternetSales]

-- AVERAGE ORDER PER DAY
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