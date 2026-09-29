-- Databricks notebook source
SELECT*
FROM workspace.sales_case_study.dataset_sales_case_study;

DESCRIBE workspace.sales_case_study.dataset_sales_case_study;
--------------------------------------------------------------------
--CLEANING DATE COLUMN

--Inspecting the date column
SELECT DISTINCT date
FROM workspace.sales_case_study.dataset_sales_case_study
ORDER BY Date
LIMIT 100;
-------------------------------------------------------------------
--checking duplicate sales 
SELECT
    Sales,
    COUNT(*) AS duplicate_count
FROM workspace.sales_case_study.dataset_sales_case_study
GROUP BY Sales
HAVING COUNT(*) > 1;

   SELECT*
FROM workspace.sales_case_study.dataset_sales_case_study
WHERE Sales IN (
    SELECT
        Sales
    FROM workspace.sales_case_study.dataset_sales_case_study
    GROUP BY Sales
    HAVING COUNT(*) > 1)
    ORDER BY Sales, Date;
----------------------------------------------------------
--checking duplicate cost of sales
SELECT*
FROM workspace.sales_case_study.dataset_sales_case_study
WHERE `Cost Of Sales` IN (
    SELECT
        `Cost Of Sales`
    FROM workspace.sales_case_study.dataset_sales_case_study
    GROUP BY `Cost Of Sales`
    HAVING COUNT(*) > 1)
    ORDER BY `Cost Of Sales`, Date;
---------------------------------------------------------------------------
--Checking and replacing missing values

--Sales
SELECT DISTINCT Sales,
    CASE
        WHEN CAST(Sales AS STRING) = ' ' THEN 'Unknown'
        WHEN CAST(Sales AS STRING) = 'None' THEN 'Unknown'
        WHEN Sales IS NULL THEN 'Unknown'
    ELSE CAST(Sales AS STRING)
END AS Sales_clean
FROM workspace.sales_case_study.dataset_sales_case_study;


--cost of sale
SELECT `Cost Of Sales`,
    CASE
        WHEN CAST(`Cost Of Sales` AS STRING) = ' ' THEN 'Unknown'
        WHEN CAST(`Cost Of Sales` AS STRING) = 'None' THEN 'Unknown'
        WHEN `Cost Of Sales` IS NULL THEN 'Unknown'
    ELSE CAST(Sales AS STRING)
END AS `Cost Of Sales Clean`
FROM workspace.sales_case_study.dataset_sales_case_study;
-----------------------------------------------------------------------------
-- Check for nulls dates
SELECT 
    MIN(Date) AS min_date,
    MAX(Date) AS max_date,
    COUNT(*) AS total_rows,
    COUNT(Date) AS non_null_dates
FROM workspace.sales_case_study.dataset_sales_case_study;
-------------------------------------------------------------------------------
--Deriving additional columns from date column
--date
SELECT date,
CAST(Date AS DATE) AS Date_clean
FROM workspace.sales_case_study.dataset_sales_case_study;

--year
SELECT Date,
YEAR(Date) AS Year
FROM workspace.sales_case_study.dataset_sales_case_study;

--month
SELECT date,
DATE_FORMAT(Date, 'MMMM') AS Month
FROM workspace.sales_case_study.dataset_sales_case_study;

--day name
SELECT date,
DATE_FORMAT (Date,'EEEE') AS Day_name
FROM workspace.sales_case_study.dataset_sales_case_study;

--day classification
SELECT Date,
CASE 
    WHEN DATE_FORMAT(Date,'EEEE') = 'Monday' THEN 'Weekday'
    WHEN DATE_FORMAT(Date,'EEEE') = 'Tuesday' THEN 'Weekday'
    WHEN DATE_FORMAT(Date,'EEEE') = 'Wednesday' THEN 'Weekday'
    WHEN DATE_FORMAT(Date,'EEEE') = 'Thursday' THEN 'Weekday'
    WHEN DATE_FORMAT(Date,'EEEE') = 'Friday' THEN 'Weekday'
    WHEN DATE_FORMAT(Date,'EEEE') = 'Saturday' THEN 'Weekend'
    WHEN DATE_FORMAT(Date,'EEEE') = 'Sunday' THEN 'Weekend'
END AS Day_classification
FROM workspace.sales_case_study.dataset_sales_case_study;

-----------------------------------------------------------------------
--Cleaning and deriving new column from Sales column
SELECT
ROUND(Sales, 2) AS Sales_clean
FROM workspace.sales_case_study.dataset_sales_case_study;

-----------------------------------------------------------------------
--Cleaning and deriving new column from Cost of sales column
SELECT
ROUND(`Cost Of Sales`, 2) AS `Cost of sales clean`
FROM workspace.sales_case_study.dataset_sales_case_study;

-----------------------------------------------------------------------
--Creating daily sales price per unit column
SELECT
Date,
ROUND(Sales / `Quantity Sold`, 2) AS `Daily sales price per unit`
FROM workspace.sales_case_study.dataset_sales_case_study;
-----------------------------------------------------------------------
--Average unit sales price column
SELECT
ROUND(AVG(Sales / `Quantity Sold`), 2) AS `Average unit sales price`
FROM workspace.sales_case_study.dataset_sales_case_study;

SELECT
ROUND(AVG(Sales / `Quantity Sold`) OVER (), 2) AS Average_unit_sales_price
FROM workspace.sales_case_study.dataset_sales_case_study;
-----------------------------------------------------------------------
--Daily % Gross profit
SELECT
Date,
ROUND((Sales - `Cost Of Sales`) / Sales * 100, 2) AS `Daily % Gross profit`
FROM workspace.sales_case_study.dataset_sales_case_study;
-----------------------------------------------------------------------
--Daily % Gross profit per unit
SELECT
Date,
ROUND((Sales - `Cost Of Sales`) / `Quantity Sold` / Sales * 100, 2) AS `Daily % Gross profit per unit`
FROM workspace.sales_case_study.dataset_sales_case_study;
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
