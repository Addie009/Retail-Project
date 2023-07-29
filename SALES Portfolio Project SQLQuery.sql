--Lets have an overview of our data
SELECT*
FROM sales

--Cleaning the data using queries

--Standardize Date format(convert to date)
SELECT CONVERT( DATE, ORDERDATE) AS DATECONVERTED
FROM Sales

UPDATE sales
SET ORDERDATE = CONVERT( DATE, ORDERDATE)

--Merger the contactfirstname and contactlastname into a single column named as contactnames
SELECT CONCAT(CONTACTLASTNAME, ' ', CONTACTFIRSTNAME) AS CONTACTNAMES
FROM Sales

ALTER TABLE SALES
ADD CONTACTNAMES VARCHAR(255)

UPDATE sales
SET CONTACTNAMES = CONCAT(CONTACTLASTNAME, ' ', CONTACTFIRSTNAME)

ALTER TABLE SALES
DROP COLUMN CONTACTLASTNAME, CONTACTFIRSTNAME

--CHECKING FOR DISTINCT VALUES
SELECT DISTINCT STATUS FROM Sales
SELECT DISTINCT YEAR_ID FROM Sales
SELECT DISTINCT PRODUCTLINE FROM Sales
SELECT DISTINCT COUNTRY FROM Sales
SELECT DISTINCT TERRITORY FROM Sales

--ANALYSIS
--Let's start with by grouping sales by the productline
SELECT PRODUCTLINE, SUM(SALES) AS REVENUE
FROM Sales
GROUP BY PRODUCTLINE
ORDER BY 2 DESC

--Sales across the year and also segment it by month
SELECT YEAR_ID, month_id, SUM(SALES) AS REVENUE
FROM Sales
GROUP BY YEAR_ID, MONTH_ID
ORDER BY 2 DESC

--The dealsize with the highest sales
SELECT DEALSIZE, SUM(SALES) AS REVENUE
FROM Sales
GROUP BY DEALSIZE
ORDER BY 2 DESC

--What was the best month for sales in the year 2004 and how much was earned that month?
SELECT month_id, SUM(SALES) AS REVENUE, count(ordernumber) as Frequency
FROM Sales
where YEAR_ID = 2004
GROUP BY MONTH_ID
ORDER BY 2 DESC

--lets have an overview of our data 
SELECT*
FROM sales

--Standardize our Date format 
SELECT CONVERT(DATE, ORDERDATE) AS dateconverted
FROM sales

--Lets update our date format in the database
UPDATE sales
SET ORDERDATE =  CONVERT(DATE, ORDERDATE)

----CHECKING FOR DISTINCT VALUES
SELECT DISTINCT(STATUS) FROM sales
SELECT DISTINCT(PRODUCTLINE) FROM sales
SELECT DISTINCT(TERRITORY) FROM sales
SELECT DISTINCT(COUNTRY) FROM sales
SELECT DISTINCT(DEALSIZE) FROM sales
SELECT DISTINCT(YEAR_ID) FROM sales

--ANALYSIS
----Let's start with grouping sales by the productline
SELECT PRODUCTLINE, 
ROUND(SUM(SALES),2) AS REVENUE
FROM sales
GROUP BY PRODUCTLINE
ORDER BY 2 DESC

--Sales across the year and also segment it by month
SELECT YEAR_ID, MONTH_ID,
ROUND(SUM(SALES),2) AS REVENUE
FROM sales
GROUP BY  YEAR_ID, MONTH_ID
ORDER BY 2 DESC

--The dealsize with the highest sales
SELECT YEAR_ID, MONTH_ID,
ROUND(SUM(SALES),1) AS REVENUE
FROM sales
GROUP BY  YEAR_ID, MONTH_ID
ORDER BY 3 DESC

--what year had the highest revenue?
select YEAR_ID, round(sum(sales),2)
from sales
group by YEAR_ID
order by 2 desc

--since 2004 had the highest turnover. What was the best month for sales in that year and how much was earned that month?
SELECT YEAR_ID, MONTH_ID,
ROUND(SUM(SALES),2) AS REVENUE, COUNT(QUANTITYORDERED) AS TOTALORDERED
FROM sales
WHERE YEAR_ID = '2004'
GROUP BY  YEAR_ID, MONTH_ID
ORDER BY 3 DESC

--November seems to be the month with the highest sales, what product do they sell the most?
SELECT YEAR_ID, MONTH_ID, PRODUCTLINE, 
ROUND(SUM(SALES),1) AS REVENUE, COUNT(QUANTITYORDERED) AS TOTALORDERED
FROM sales
GROUP BY YEAR_ID, MONTH_ID, PRODUCTLINE
ORDER BY REVENUE DESC

--2005 seems to be the year with the lowest revenue, how many month did they operate in that year?
SELECT DISTINCT(MONTH_ID)
FROM sales
WHERE YEAR_ID = '2005'

----Using the RANK() function, find the first 5 countries with the highest revenue and the total orders made.
WITH CTE AS (
SELECT 
            COUNTRY, 
			ROUND(SUM(SALES),2) AS REVENUE, 
			SUM(QUANTITYORDERED) AS TOTALORDER
FROM sales
GROUP BY COUNTRY
), 
CTE2 AS (
SELECT    
        COUNTRY, 
		REVENUE,
		TOTALORDER,
RANK() OVER(ORDER BY REVENUE DESC) AS RANK
FROM CTE
)
SELECT*
FROM CTE2
WHERE RANK <= 5

--Lets connect to a visualization tool called tableau and visualize our data for more insights




       
    
