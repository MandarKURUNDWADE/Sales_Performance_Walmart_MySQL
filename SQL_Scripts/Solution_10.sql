-- Step 1: Analyze Sales Trends by Day of the Week  
SELECT  
    DAYOFWEEK(`Date`) AS DayOfWeek,  -- Extracts the day of the week (1 = Sunday, 7 = Saturday)  
      
    -- Convert the numeric day of the week into a readable day name  
    MAX(CASE  
        WHEN DAYOFWEEK(`Date`) = 1 THEN 'Sunday'  
        WHEN DAYOFWEEK(`Date`) = 2 THEN 'Monday'  
        WHEN DAYOFWEEK(`Date`) = 3 THEN 'Tuesday'  
        WHEN DAYOFWEEK(`Date`) = 4 THEN 'Wednesday'  
        WHEN DAYOFWEEK(`Date`) = 5 THEN 'Thursday'  
        WHEN DAYOFWEEK(`Date`) = 6 THEN 'Friday'  
        WHEN DAYOFWEEK(`Date`) = 7 THEN 'Saturday'  
    END) AS DayName,  

    SUM(`Total`) AS TotalSales  -- Calculate total sales for each day of the week  
FROM  
    walmartsales  
GROUP BY  
    DayOfWeek  -- Grouping by the numeric day of the week to aggregate sales  
ORDER BY  
    TotalSales DESC;  -- Sorting by total sales in descending order  
