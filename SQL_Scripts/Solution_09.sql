-- Step 1: Retrieve the total sales for each customer  
SELECT  
    `Customer ID`,  -- Selecting the unique customer identifier  
    SUM(`Total`) AS TotalSales  -- Summing up the total sales for each customer  
FROM  
    walmartsales  -- Using the Walmart sales dataset  
GROUP BY  
    `Customer ID`  -- Grouping results by customer to calculate total sales per customer  
ORDER BY  
    TotalSales DESC  -- Sorting customers in descending order based on their total sales  
LIMIT 5;  -- Selecting only the top 5 customers with the highest total sales  
