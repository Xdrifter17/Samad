
-- 1. Retrieve all the records from the car sales-data table. --

SELECT * FROM cars_dataset..car_sales;

-- 2. Retrieve the total number of car sales in the database. --

SELECT COUNT(*) AS Total_Sales FROM cars_dataset..car_sales;

-- 3. Retrieve the sales price of a specific car by providing its make, model, and year. --

SELECT Sale_Price FROM cars_dataset..car_sales WHERE Car_Make='Ford' AND Car_Model='Civic' AND Car_Year= 2016;

-- 4. Retrieve the total commission earned by a specific salesperson: --
-- I used CAST method because the column was created in varchar format and SUM Function was giving Operand error with the conversion -- 

SELECT SUM(CAST(Commission_Earned AS DECIMAL)) AS Total_Commission from cars_dataset..car_sales WHERE Salesperson = 'Ashley Ramos';
-----------------------------------------------------------------------------------------------------------------------------------
SELECT SUM(CAST(Commission_Earned AS DECIMAL)) AS Total_Commission from cars_dataset..car_sales WHERE Salesperson LIKE '%Ash%';

-- 5. Retrieve the customer’s name, car make, and sales price for all car sales made on a specific date. --

SELECT Customer_Name, Car_Make, Sale_Price, Date FROM cars_dataset..car_sales WHERE date= '2022-12-18';

-- 6. Retrieve the average commission earned per sale. --

SELECT AVG(CAST(Commission_Earned AS DECIMAL)) AS CommissonOverALL FROM cars_dataset..car_sales;

-- 7. Retrieve the top 5 salespersons based on the total commission earned. --
-- LIMIT Function dosen't work on SQL Server hence I used OFFSET FETCH NEXT Fuction. --

SELECT Salesperson, SUM(CAST(Commission_Earned AS DECIMAL)) AS Top_Performers FROM cars_dataset..car_sales
GROUP BY Salesperson 
ORDER BY Top_Performers DESC 
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;

-- 8. Retrieve the top 3 car models with the highest total sales price and the number of sales made for each model. --

SELECT Car_Model, Car_Make, SUM(CAST(Sale_Price AS DECIMAL)) AS Sales FROM cars_dataset..car_sales
GROUP BY Car_Model, Car_Make 
ORDER BY Sales DESC OFFSET 5 ROWS FETCH NEXT 3 ROWS ONLY;

-- 9. Retrieve the salesperson with the highest commission earned and the percentage of the total commission earned by all salespeople. --

SELECT Salesperson, SUM(CAST(Commission_Earned AS DECIMAL)) AS Top_Performers, 
SUM(CAST(Commission_Earned AS DECIMAL)) / (SELECT(CAST(Commission_Earned AS DECIMAL)) FROM cars_dataset..car_sales) * 100 AS Total_Percentage
FROM cars_dataset..car_sales
GROUP BY Salesperson
ORDER BY Top_Performers DESC ;

-- 10. Retrieve the average sales price of cars sold in each year and month. --

SELECT FORMAT(GETDATE(), 'yyyy-MM-dd') AS DateOfProduction, AVG(CAST(Sale_Price AS DECIMAL)) AS Pricing
FROM cars_dataset..car_sales;
----------------------------------------------------------------------------------------------------------
SELECT FORMAT(GETDATE(), '2022-06-12') AS DateOfProduction, AVG(CAST(Sale_Price AS DECIMAL)) AS Pricing
FROM cars_dataset..car_sales;

-- 11. Retrieve the total commission earned for each car make and model combination. --

SELECT Car_Make, Car_Model, SUM(CAST(Commission_Earned AS DECIMAL)) As Total_Capture FROM cars_dataset..car_sales
GROUP BY Car_Make, Car_Model
ORDER BY Total_Capture;

-- 12. Retrieve the top 5 customers with the highest total sales price and their respective salesperson --

SELECT Customer_Name, Salesperson, SUM(CAST(Sale_Price AS DECIMAL)) Total_Sales FROM cars_dataset..car_sales
GROUP BY Customer_Name, Salesperson
ORDER BY Total_Sales DESC
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;

-- 13. Retrieve the average sales price and commission earned per car model. --

SELECT Car_Model, AVG(CAST(Sale_Price AS DECIMAL)) AS Sales_Price, AVG(CAST(Commission_Earned AS DECIMAL)) AS Commison_Grasped
FROM cars_dataset..car_sales
GROUP BY Car_Model;

-- 14. Retrieve the monthly commission earned for a specific salesperson. --

SELECT Salesperson, YEAR(Date) AS year_day, MONTH(Date) AS month_day, SUM(CAST(Commission_Earned AS DECIMAL)) AS monthly_commission
FROM cars_dataset..car_sales
WHERE Salesperson = 'Eric Lopez'
GROUP BY Salesperson, YEAR, MONTH;


-- 15. Retrieve the top 5 car models with the highest average sales price. --

SELECT Car_Make, Car_Model, AVG(Cast(Sale_Price AS DECIMAL)) AS average_sales_price
FROM cars_dataset..car_sales
GROUP BY Car_Make, Car_Model
ORDER BY average_sales_price DESC
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;

-- 16. Retrieve the total sales count for each car make and model. --

SELECT Car_Make, Car_Model, COUNT(*) AS total_sales_count
FROM cars_dataset..car_sales
GROUP BY Car_Make, Car_Model;

-- 17. Retrieve the average sales price for each car make. --

SELECT Car_Make, AVG(CAST(Sale_Price AS DECIMAL)) AS average_sales_price
FROM cars_dataset..car_sales
GROUP BY car_make;

-- 18. Retrieve the number of sales retrive by each customer. --

SELECT DISTINCT Customer_Name, COUNT(*) AS sales_count
FROM cars_dataset..car_sales
GROUP BY Customer_Name;

-- 19. Retrieve the car make and model with the highest total sales price. --

SELECT Car_Make, Car_Model, SUM(CAST(Sale_Price AS DECIMAL)) AS total_sales_price
FROM cars_dataset..car_sales
GROUP BY Car_Make, Car_Model
ORDER BY total_sales_price DESC
OFFSET 5 ROWS FETCH NEXT 1 ROWS ONLY;


-- 20. Retrieve the salespersons with sales count higher than the average sales count. --

SELECT Salesperson, COUNT(*) AS Sales_count
FROM cars_dataset..car_sales
GROUP BY Salesperson
HAVING COUNT(*) > (SELECT AVG(CAST(sales_count AS DECIMAL)) FROM 
(SELECT COUNT(*) AS sales_count FROM cars_dataset..car_sales GROUP BY Salesperson) AS subquery);

-- 21. Retrieve the customers who have made purchases with sales price lower than a specific margin. --

SELECT Customer_Name, COUNT(*) AS total_purchases
FROM cars_dataset..car_sales
WHERE Sale_Price < 50000
GROUP BY Customer_Name
ORDER BY total_purchases DESC;

-- 22. Retrieve the car sales with a commission earned higher than the average commission earned by a specific salesperson. --

SELECT * FROM cars_dataset..car_sales
WHERE Commission_Earned > (SELECT AVG(CAST(Commission_Earned AS DECIMAL)) 
FROM cars_dataset..car_sales WHERE Salesperson = 'Scott Parker');


-- 23. Retrieve the car sales with a sales price higher than the sales price of a specific car model in a specific year. --

SELECT * FROM cars_dataset..car_sales
WHERE Sale_price > (SELECT Sale_Price FROM cars_dataset..car_sales WHERE Car_Model = 'Altima' AND YEAR(date) = 2023);

