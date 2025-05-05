-- Step 1: Calculate Average Sales per Product Line  
-- This query calculates the average total sales for each product line  
SELECT  
    `Product line`,  
    AVG(`Total`) AS avg_sales  
FROM  
    walmartsales  
GROUP BY  
    `Product line`;  

-- Step 2: Identify Anomalies  
-- Using a Common Table Expression (CTE) to first calculate the average sales per product line  
WITH AvgSales AS (  
    SELECT  
        `Product line`,  
        AVG(`Total`) AS avg_sales  
    FROM  
        walmartsales  
    GROUP BY  
        `Product line`  
)  
-- This query joins the walmartsales table with the AvgSales CTE to compare each transaction's total sales  
-- against the average sales for its respective product line. It categorizes transactions as:  
--   - 'High Anomaly' if sales exceed 1.5 times the average  
--   - 'Low Anomaly' if sales are below 0.5 times the average  
--   - 'Normal' otherwise  
SELECT  
    w.*,  
    a.avg_sales,  
    CASE  
        WHEN w.`Total` > a.avg_sales * 1.5 THEN 'High Anomaly'  
        WHEN w.`Total` < a.avg_sales * 0.5 THEN 'Low Anomaly'  
        ELSE 'Normal'  
    END AS anomaly_status  
FROM  
    walmartsales w  
JOIN  
    AvgSales a ON w.`Product line` = a.`Product line`;  

-- Step 3: Filter and Display Anomalies  
-- This query builds on the previous step to filter and display only the anomaly transactions  
WITH AvgSales AS (  
    SELECT  
        `Product line`,  
        AVG(`Total`) AS avg_sales  
    FROM  
        walmartsales  
    GROUP BY  
        `Product line`  
),  
Anomalies AS (  
    -- Identify anomalies using the same logic as in Step 2  
    SELECT  
        w.*,  
        a.avg_sales,  
        CASE  
            WHEN w.`Total` > a.avg_sales * 1.5 THEN 'High Anomaly'  
            WHEN w.`Total` < a.avg_sales * 0.5 THEN 'Low Anomaly'  
            ELSE 'Normal'  
        END AS anomaly_status  
    FROM  
        walmartsales w  
    JOIN  
        AvgSales a ON w.`Product line` = a.`Product line`  
)  
-- Filter out only the 'High Anomaly' and 'Low Anomaly' transactions  
SELECT  
    *  
FROM  
    Anomalies  
WHERE  
    anomaly_status IN ('High Anomaly', 'Low Anomaly');  
