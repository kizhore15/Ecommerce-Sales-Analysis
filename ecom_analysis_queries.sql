/*
====================================================================
 PROJECT: E-Commerce Sales Analysis
 AUTHOR:  Kishore Kumar K
 TABLE:   orders  (1,500 cleaned rows, e-commerce order data)
 GOAL:    Analyse sales performance, profitability, regional trends,
          and customer behaviour for an Indian e-commerce store
====================================================================
*/

-- Q1: Overall business summary — total orders, sales, profit
SELECT
    COUNT(*)                          AS Total_Orders,
    ROUND(SUM(Sales), 2)              AS Total_Sales,
    ROUND(SUM(Profit), 2)             AS Total_Profit,
    ROUND(AVG(Profit_Margin_Pct), 1)  AS Avg_Profit_Margin_Pct
FROM orders;


-- Q2: Sales and profit by category (ranked best to worst)
SELECT
    Category,
    COUNT(*)                     AS Total_Orders,
    ROUND(SUM(Sales), 2)         AS Total_Sales,
    ROUND(SUM(Profit), 2)        AS Total_Profit,
    ROUND(AVG(Profit_Margin_Pct), 1) AS Avg_Margin_Pct
FROM orders
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Q3: Monthly sales trend
SELECT
    Order_Month,
    COUNT(*)              AS Orders_Count,
    ROUND(SUM(Sales), 2)  AS Monthly_Sales,
    ROUND(SUM(Profit), 2) AS Monthly_Profit
FROM orders
GROUP BY Order_Month
ORDER BY Order_Month;


-- Q4: Regional performance comparison
SELECT
    Region,
    COUNT(*)                     AS Total_Orders,
    ROUND(SUM(Sales), 2)         AS Total_Sales,
    ROUND(SUM(Profit), 2)        AS Total_Profit,
    ROUND(AVG(Profit_Margin_Pct), 1) AS Avg_Margin_Pct
FROM orders
GROUP BY Region
ORDER BY Total_Sales DESC;


-- Q5: Top 10 customers by total sales
SELECT
    Customer_ID,
    Customer_Name,
    COUNT(*)             AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;


-- Q6: Sales by customer segment (Consumer / Corporate / Home Office)
SELECT
    Segment,
    COUNT(*)                     AS Total_Orders,
    ROUND(SUM(Sales), 2)         AS Total_Sales,
    ROUND(SUM(Profit), 2)        AS Total_Profit,
    ROUND(AVG(Discount_Pct), 1)  AS Avg_Discount_Pct
FROM orders
GROUP BY Segment
ORDER BY Total_Sales DESC;


-- Q7: Shipping mode analysis — average days and order count
SELECT
    Ship_Mode,
    COUNT(*)                      AS Order_Count,
    ROUND(AVG(Days_to_Ship), 1)   AS Avg_Days_to_Ship,
    ROUND(SUM(Sales), 2)          AS Total_Sales
FROM orders
GROUP BY Ship_Mode
ORDER BY Avg_Days_to_Ship ASC;


-- Q8: Impact of discount on profitability (using CASE to group discounts)
SELECT
    CASE
        WHEN Discount_Pct = 0  THEN 'No Discount'
        WHEN Discount_Pct <= 10 THEN 'Low (1-10%)'
        WHEN Discount_Pct <= 20 THEN 'Medium (11-20%)'
        ELSE 'High (21%+)'
    END AS Discount_Band,
    COUNT(*)                      AS Orders,
    ROUND(AVG(Profit_Margin_Pct), 1) AS Avg_Profit_Margin_Pct,
    ROUND(SUM(Sales), 2)          AS Total_Sales
FROM orders
GROUP BY Discount_Band
ORDER BY Avg_Profit_Margin_Pct DESC;


-- Q9: Top 5 cities by total sales (using subquery)
SELECT City, Total_Sales FROM (
    SELECT
        City,
        ROUND(SUM(Sales), 2) AS Total_Sales
    FROM orders
    GROUP BY City
) city_totals
ORDER BY Total_Sales DESC
LIMIT 5;


-- Q10: Quarterly sales comparison (Q1 vs Q2 vs Q3 vs Q4)
SELECT
    Order_Quarter,
    COUNT(*)              AS Orders,
    ROUND(SUM(Sales), 2)  AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM orders
GROUP BY Order_Quarter
ORDER BY Order_Quarter;
