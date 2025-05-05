-- Identifying Repeat Customers within 30 Days  
-- This query identifies customers who made repeat purchases within a 30-day window.  

SELECT  
    a.`Customer ID`,  -- Customer identifier  
    COUNT(DISTINCT b.`Invoice ID`) AS repeat_purchases  -- Count of distinct repeat purchases  
FROM  
    walmartsales a  
JOIN  
    walmartsales b  
ON  
    a.`Customer ID` = b.`Customer ID`  -- Match customers in the same table  
    AND a.`Invoice ID` <> b.`Invoice ID`  -- Exclude self-joins on the same invoice  
    AND DATEDIFF(a.Date, b.Date) BETWEEN 1 AND 30  -- Ensure purchases are within a 30-day window  
GROUP BY  
    a.`Customer ID`  -- Group by customer to aggregate repeat purchases  
HAVING  
    repeat_purchases > 1;  -- Filter only customers with more than one repeat purchase  
