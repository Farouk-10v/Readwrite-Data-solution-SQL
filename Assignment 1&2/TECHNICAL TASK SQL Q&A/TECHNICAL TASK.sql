Question 1: 
Write a query that orders each type of fruit by the total sales value (£) they made in May 2022, from best-seller to worst. 


SELECT fruit_sales.fruit_id, fruits.fruit_name,
SUM(fruit_sales.total_sales_value)
FROM fruit_sales
JOIN fruits ON fruit_sales.fruit_id = fruits.fruit_id
WHERE MONTH(fruit_sales.order_date) = 05
AND YEAR(fruit_sales.order_date) = 2022
GROUP BY fruit_sales.fruit_id, fruits.fruit_name;
ORDER BY SUM(fruit_sales.total_sales_value) DESC;

Question 2:
Which fruits made less money in 2022 than in 2021?


SELECT FRUIT_NAME FROM fruits
JOIN (
SELECT FRUIT_ID,
	SUM(CASE WHEN YEAR(ORDER_DATE) = 2021 THEN TOTAL_SALES_VALUE ELSE 0 END) as sales_2021,
	SUM(CASE WHEN YEAR(ORDER_DATE) = 2022 THEN TOTAL_SALES_VALUE ELSE 0 END) as sales_2022
FROM fruit_sales
WHERE YEAR(ORDER_DATE) IN (2021, 2022)
GROUP BY FRUIT_ID
) aggregated_sales ON fruits.FRUIT_ID = aggregated_sales.FRUIT_ID
WHERE aggregated_sales.sales_2022 < aggregated_sales.sales_2021;



QUESTION 3
What is the average age of everyone that made a purchase in March 2020, to the nearest full year?

SELECT
AVG(customers.age)
FROM purchases JOIN customers ON purchases.customer_id = customers.customers_id
WHERE YEAR (purchases.PURCHASE_DATE) = 2020 
AND MONTH (purchases.PURCHASE_DATE) = 03
;

QUESTION 4
Write a query to show which channel was responsible for the 2nd largest amount of money made each year, and how much money this channel brought in that year. 


WITH PurchasesByYear AS (
    SELECT 
        YEAR(pu.PURCHASE_DATE) AS purchase_year,
        s.channel,
        pu.UNIT_VALUE_POUNDS * pu.UNITS AS TS,
        pu.UNIT_VALUE_POUNDS * pu.UNITS AS TOTAL_VALUE,
        ROW_NUMBER() OVER (PARTITION BY YEAR(pu.PURCHASE_DATE) ORDER BY pu.UNIT_VALUE_POUNDS * pu.UNITS DESC) AS running_count
    FROM 
        purchases pu
    JOIN 
        sessions_updated s ON pu.PURCHASE_ID = s.PURCHASE_ID
)
SELECT 
    purchase_year,
    channel, 
    TS, 
    TOTAL_VALUE, 
    running_count
FROM PurchasesByYear
WHERE running_count = 2;