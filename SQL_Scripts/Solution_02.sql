-- Step 1: Calculate Profit for Each Product Line
-- This query calculates the total profit for each product line within each branch.
SELECT
    Branch,  -- Select the branch
    `Product line`,  -- Select the product line
    SUM(`gross income` - cogs) AS Total_Profit  -- Calculate profit as (Gross Income - COGS) and sum it up
FROM
    walmartsales  -- From the walmartsales table
GROUP BY
    Branch, `Product line`  -- Group the results by branch and product line
ORDER BY
    Branch, Total_Profit DESC;  -- Order the results by branch and total profit in descending order

-- Step 2: Identify the Most Profitable Product Line for Each Branch
-- This query identifies the most profitable product line for each branch using ranking.
WITH Profit_Calculation AS (
    -- First, calculate the total profit for each product line within each branch
    SELECT
        Branch,
        `Product line`,
        SUM(`gross income` - cogs) AS Total_Profit,  -- Calculate total profit
        -- Rank product lines within each branch based on total profit (highest profit gets rank 1)
        RANK() OVER (PARTITION BY Branch ORDER BY SUM(`gross income` - cogs) DESC) AS Profit_Rank
    FROM
        walmartsales
    GROUP BY
        Branch, `Product line`  -- Group by branch and product line
)
-- Select only the most profitable product line for each branch (where rank = 1)
SELECT
    Branch,
    `Product line`,
    Total_Profit
FROM
    Profit_Calculation
WHERE
    Profit_Rank = 1;  -- Filter to get only the top-ranked (most profitable) product line per branch