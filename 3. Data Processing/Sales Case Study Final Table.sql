-- Databricks notebook source
--CREATING THE FINAL TABLE
CREATE OR REPLACE TABLE workspace.sales_case_study.dataset_sales_case_study_cleaned_table AS
SELECT
    Date,
    Sales,
    `Cost Of Sales` AS Cost_Of_Sales,
    `Quantity Sold` AS Quantity_Sold,

    ROUND(Sales, 2) AS Sales_clean,

    ROUND(`Cost Of Sales`, 2) AS Cost_of_sales_clean,

    ROUND(Sales / `Quantity Sold`, 2) AS Daily_sales_price_per_unit,

    ROUND(AVG(Sales / `Quantity Sold`) OVER (), 2) AS Average_unit_sales_price,

    ROUND((Sales - `Cost Of Sales`) / Sales * 100, 2) AS Daily_pct_Gross_profit,

    ROUND((Sales - `Cost Of Sales`) / `Quantity Sold` / Sales * 100, 2) AS Daily_percentage_Gross_profit_per_unit,

     CAST(Date AS DATE) AS Date_clean,

    YEAR(Date) AS Year,

    DATE_FORMAT(Date, 'MMMM') AS Month,

    DATE_FORMAT(Date, 'EEEE') AS Day_name,

    CASE
        WHEN DATE_FORMAT(Date, 'EEEE') = 'Monday' THEN 'Weekday'
        WHEN DATE_FORMAT(Date, 'EEEE') = 'Tuesday' THEN 'Weekday'
        WHEN DATE_FORMAT(Date, 'EEEE') = 'Wednesday' THEN 'Weekday'
        WHEN DATE_FORMAT(Date, 'EEEE') = 'Thursday' THEN 'Weekday'
        WHEN DATE_FORMAT(Date, 'EEEE') = 'Friday' THEN 'Weekday'
        WHEN DATE_FORMAT(Date, 'EEEE') = 'Saturday' THEN 'Weekend'
        WHEN DATE_FORMAT(Date, 'EEEE') = 'Sunday' THEN 'Weekend'
    END AS Day_classification


FROM workspace.sales_case_study.dataset_sales_case_study;

SELECT*
FROM workspace.sales_case_study.dataset_sales_case_study_cleaned_table;