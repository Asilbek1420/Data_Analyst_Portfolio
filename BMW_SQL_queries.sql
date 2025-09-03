DELETE FROM [BMW sales data (2010-2024)]
WHERE Model NOT IN (
    SELECT Model
    FROM [BMW sales data (2010-2024)]
    WHERE Year >= 2020
)


UPDATE [BMW sales data (2010-2024)]
SET Model = 'Unknown'
WHERE Model IS NULL


SELECT Model, 
SUM(CAST(Price_USD * Sales_Volume AS bigint)) AS "Revenue of the model"
FROM [BMW sales data (2010-2024)]
GROUP BY Model
ORDER BY "Revenue of the model" DESC


SELECT Model, Year, Region, Price_USD,
LAG(Price_USD) OVER (PARTITION BY Model ORDER BY Year) as "Previous price",
Price_USD - LAG(Price_USD) OVER (PARTITION BY Model ORDER BY Year) as "Difference"
FROM [BMW sales data (2010-2024)]
GROUP BY Model, Year, Region, Price_USD
ORDER BY Year


SELECT Year,
       SUM(Sales_Volume) AS TotalSales,
       LAG(SUM(Sales_Volume)) OVER (ORDER BY year) AS "Previous Year's Number of Sales",
       (SUM(Sales_Volume) - LAG(SUM(Sales_Volume)) OVER (ORDER BY year)) * 100.0 /
         LAG(SUM(Sales_Volume)) OVER (ORDER BY year) AS "Year to year growth"
FROM [BMW sales data (2010-2024)]
GROUP BY Year
ORDER BY Year

WITH YearlyRevenue AS (
    SELECT Model, Year
    FROM [BMW sales data (2010-2024)]
    GROUP BY Model, Year
)
SELECT Y.Model, 
Y.Year, 
SUM(CAST(BMW.Price_USD * BMW.Sales_Volume AS bigint)) AS "Revenue of the model", BMW.Region
FROM YearlyRevenue AS Y
JOIN [BMW sales data (2010-2024)] AS BMW ON BMW.Model = Y.Model
GROUP BY Y.Model, Y.Year, BMW.Region
ORDER BY Y.Year, "Revenue of the model" DESC


SELECT TOP 10
Model, 
Year, 
Sales_Volume AS "Number of Sales"
FROM [BMW sales data (2010-2024)]
GROUP BY Model, Year, Sales_Volume
ORDER BY Sales_Volume DESC


SELECT Model, 
Year, 
Region, 
Sales_Classification, 
Sales_Volume
FROM [BMW sales data (2010-2024)]
GROUP BY Model, Year, Region, Sales_Classification, Sales_Volume
Having Sales_Classification = 'High' 
AND Year > 2020 
AND Sales_Volume > 8800
ORDER BY Sales_Volume DESC


SELECT Region, 
SUM(Sales_Volume) AS "Number of sales in each region"
FROM [BMW sales data (2010-2024)]
GROUP BY Region 
ORDER BY "Number of sales in each region"