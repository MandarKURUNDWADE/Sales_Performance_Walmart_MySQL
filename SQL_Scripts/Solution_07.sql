-- Best Product Line by Customer Type  
-- This query identifies the most popular product lines based on the total quantity sold for each customer type.  
SELECT  
    `Customer type`,  -- The type of customer (e.g., Member, Normal)  
    `Product line`,  -- The product category  
    SUM(Quantity) AS Total_Quantity  -- Total quantity of products purchased per customer type and product line  
FROM  
    walmartsales  
GROUP BY  
    `Customer type`, `Product line`  -- Groups data by customer type and product line  
ORDER BY  
    `Customer type`,  -- Sorts the results by customer type  
    Total_Quantity DESC;  -- Orders product lines within each customer type in descending order of quantity sold  
