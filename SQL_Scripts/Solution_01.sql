-- Step 1: Aggregate Monthly Sales by Branch
-- This query calculates the total sales for each branch on a monthly basis.
SELECT
    Branch,  -- Select the branch
    DATE_FORMAT(Date, '%Y-%m') AS Month_Year,  -- Format the date to show only the year and month
    SUM(Total) AS Monthly_Sales  -- Sum the total sales for each month
FROM
    walmartsales  -- From the walmartsales table
GROUP BY
    Branch, Month_Year  -- Group the results by branch and month
ORDER BY
    Branch, Month_Year;  -- Order the results by branch and month

-- Step 2: Calculate Monthly Sales Growth Rate
-- This query calculates the month-over-month growth rate for each branch.
WITH Monthly_Sales AS (
    -- First, calculate the monthly sales for each branch (same as Step 1)
    SELECT
        Branch,
        DATE_FORMAT(Date, '%Y-%m') AS Month_Year,
        SUM(Total) AS Monthly_Sales
    FROM
        walmartsales
    GROUP BY
        Branch, Month_Year
)
SELECT
    Branch,
    Month_Year,
    Monthly_Sales,
    -- Use the LAG function to get the sales from the previous month for each branch
    LAG(Monthly_Sales) OVER (PARTITION BY Branch ORDER BY Month_Year) AS Previous_Month_Sales,
    -- Calculate the growth rate as a percentage
    (Monthly_Sales - LAG(Monthly_Sales) OVER (PARTITION BY Branch ORDER BY Month_Year)) / LAG(Monthly_Sales) OVER (PARTITION BY Branch ORDER BY Month_Year) * 100 AS Growth_Rate
FROM
    Monthly_Sales;

-- Step 3: Identify the Top Branch by Growth Rate
-- This query identifies the branch with the highest average growth rate.
WITH Monthly_Sales AS (
    -- First, calculate the monthly sales for each branch (same as Step 1)
    SELECT 
        Branch, 
        DATE_FORMAT(Date, '%Y-%m') AS Month_Year, 
        SUM(Total) AS Monthly_Sales
    FROM 
        walmartsales
    GROUP BY 
        Branch, Month_Year
),

Growth_Rates AS (
    -- Calculate the growth rate for each month and branch
    SELECT 
        Branch, 
        Month_Year, 
        (Monthly_Sales - LAG(Monthly_Sales) OVER (PARTITION BY Branch ORDER BY Month_Year)) / LAG(Monthly_Sales) OVER (PARTITION BY Branch ORDER BY Month_Year) * 100 AS Growth_Rate
    FROM 
        Monthly_Sales
)
-- Finally, calculate the average growth rate for each branch and order by the highest growth rate
SELECT 
    Branch, 
    AVG(Growth_Rate) AS Avg_Growth_Rate
FROM 
    Growth_Rates
GROUP BY 
    Branch
ORDER BY 
    Avg_Growth_Rate DESC;