-- Step 1: Calculate total sales for each gender on a monthly basis  
SELECT  
    DATE_FORMAT(Date, '%M') AS Month,  -- Extracts and formats the month name from the Date column  
    Gender,  -- Gender of the customer  
    SUM(Total) AS Total_Sales  -- Calculates the total sales for each gender per month  
FROM  
    walmartsales  
GROUP BY  
    Month, Gender  -- Groups data by month and gender to aggregate sales  
ORDER BY  
    Month, Gender;  -- Orders the results by month and gender  
