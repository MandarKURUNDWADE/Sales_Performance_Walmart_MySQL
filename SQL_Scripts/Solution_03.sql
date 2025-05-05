-- Step 1: Calculate Total Spending for Each Customer
-- This query calculates the total spending for each customer and categorizes them into spending tiers.
WITH Customer_Spending AS (
    -- First, calculate the total spending for each customer
    SELECT
        `Customer ID`,  -- Select the customer ID
        SUM(Total) AS Total_Spending  -- Sum the total spending for each customer
    FROM
        walmartsales  -- From the walmartsales table
    GROUP BY
        `Customer ID`  -- Group the results by customer ID
),
Spending_Tiers AS (
    -- Next, divide customers into 5 tiers based on their total spending
    SELECT
        `Customer ID`,
        Total_Spending,
        -- Use NTILE to divide customers into 5 tiers (1 = lowest spenders, 5 = highest spenders)
        NTILE(5) OVER (ORDER BY Total_Spending) AS Tier
    FROM
        Customer_Spending
)
-- Finally, categorize customers into spending categories based on their tier
SELECT
    `Customer ID`,
    Total_Spending,
    CASE
        WHEN Tier = 5 THEN 'High Spender'  -- Tier 5 represents the top 20% of spenders
        WHEN Tier IN (3, 4) THEN 'Medium Spender'  -- Tiers 3 and 4 represent the middle 40% of spenders
        WHEN Tier IN (1, 2) THEN 'Low Spender'  -- Tiers 1 and 2 represent the bottom 40% of spenders
    END AS Spending_Category
FROM
    Spending_Tiers
ORDER BY
    Total_Spending DESC;  -- Order the results by total spending in descending order