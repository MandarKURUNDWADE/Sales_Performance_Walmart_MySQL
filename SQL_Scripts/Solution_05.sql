-- Step 1: Most Popular Payment Method by City  
-- Using a Common Table Expression (CTE) to calculate the count of each payment method per city  
WITH PaymentCounts AS (  
    SELECT  
        City,  -- The city where the transaction occurred  
        Payment,  -- The payment method used  
        COUNT(*) AS PaymentCount,  -- Count of transactions for each payment method in a city  
        
        -- Assign a rank to each payment method per city, ordering by the highest count  
        ROW_NUMBER() OVER (PARTITION BY City ORDER BY COUNT(*) DESC) AS PaymentRank  
    FROM  
        walmartsales  
    GROUP BY  
        City, Payment  
)  
-- Retrieve the most frequently used payment method in each city  
SELECT  
    City,  
    Payment,  
    PaymentCount  
FROM  
    PaymentCounts  
WHERE  
    PaymentRank = 1;  -- Select only the top-ranked payment method for each city  
