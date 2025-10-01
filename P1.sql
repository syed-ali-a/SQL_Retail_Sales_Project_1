-- SQL Retail Sales Analysis - P1

-- Create Table 
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales
(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR(15) ,
	quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales
LIMIT 10

SELECT 
COUNT(*)
FROM retail_sales



--Data Cleaning 

SELECT *
FROM retail_sales
WHERE transactions_id IS NULL 
OR
sale_date IS NULL 
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL OR cogs IS NULL OR TOTAL_sale IS NULL


DELETE FROM retail_sales
WHERE transactions_id IS NULL 
OR
sale_date IS NULL 
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
price_per_unit IS NULL OR cogs IS NULL OR TOTAL_sale IS NULL


SELECT * FROM  retail_sales


-- Data Exploration -- 

--How Many Sales We have? --- 

SELECT 
COUNT(transactions_id)
FROM retail_sales

-- How many unique customers we have? ---

SELECT 
COUNT(DISTINCT(customer_id))
FROM retail_sales

--List of distinct categories -- 

SELECT 
DISTINCT(category)
FROM retail_sales

--Data Analysis and Business Key Problems -- 

--1. Write a SQL query to retrieve all columns for sales made on '2022-11-05;

SELECT 
* 
FROM retail_sales
WHERE sale_date = '2022-11-05'

--2.Write a SQL query to retrieve all transactions where the category is 
'Clothing' and the quantity sold is more than 4 in the month of Nov-2022; --

SELECT 
*
FROM retail_sales
WHERE category = 'Clothing'
AND quantity >= 4 AND 
TO_CHAR(sale_date, 'yyyy-mm') = '2022-11'

--3.Write a SQL query to calculate the total sales (total_sale) for each category.;

SELECT 
category,
SUM(total_sale),
COUNT(*)
FROM retail_sales
GROUP BY category

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.;

SELECT 
ROUND(AVG(age),2) AS AVG_AGE
FROM 
retail_sales
WHERE category = 'Beauty'

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.;

SELECT 
*
FROM retail_sales
WHERE total_sale > 1000

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.;

SELECT 
gender,
category,
COUNT(transactions_id) AS Count_of_transaction
FROM retail_sales
GROUP BY gender,category
ORDER BY Count_of_transaction DESC

--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year;

SELECT 
YEAR,MONTH,
AVG_SALE
FROM 
(
	SELECT 
	EXTRACT(YEAR FROM sale_date) AS YEAR,
	EXTRACT(MONTH FROM sale_date) AS month,
	AVG(total_sale) AS AVG_SALE,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS RANK
	FROM retail_sales
	GROUP BY YEAR,MONTH
) AS SUB
WHERE RANK = 1


--8.Write a SQL query to find the top 5 customers based on the highest total sales;

SELECT 
customer_id,
SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5  

--9.Write a SQL query to find the number of unique customers who purchased items from each category.;

SELECT 
category,
COUNT(DISTINCT(customer_id)) AS cnt_unique_cs
FROM retail_sales
GROUP BY category
ORDER BY cnt_unique_cs DESC

--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

SELECT 
COUNT(*),
CASE 
   WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
   WHEN EXTRACT(HOUR FROM sale_time) > 17 THEN 'EVENING'
END AS  shift
FROM retail_sales
GROUP BY shift
ORDER BY COUNT(*) DESC

--END OF PROJECT


