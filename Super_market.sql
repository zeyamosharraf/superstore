---What is the top-selling products in each category?
WITH CategoryTotalSales AS (
    SELECT p.category, p.product_name, SUM(s.sales) AS total_sales
    FROM products AS p
    JOIN sales AS s ON s.row_id = p.row_id
    GROUP BY p.category, p.product_name
)
, MaxTotalSalesPerCategory AS (
    SELECT category, MAX(total_sales) AS max_total_sales
    FROM CategoryTotalSales
    GROUP BY category
)
SELECT c.category, c.product_name, Round(c.total_sales) as top_Sales
FROM CategoryTotalSales c
JOIN MaxTotalSalesPerCategory m ON c.category = m.category
WHERE c.total_sales = m.max_total_sales
ORDER BY c.category DESC;

---What are the most profitable products in each category?
WITH CategoryTotalProfit AS (
    SELECT p.category, p.product_name, SUM(s.profit) AS total_profit
    FROM products AS p
    JOIN sales AS s ON s.row_id = p.row_id
    GROUP BY p.category, p.product_name
)
, MaxTotalprofitPerCategory AS (
    SELECT category, MAX(total_profit) AS max_total_profit
    FROM CategoryTotalprofit
    GROUP BY category
)
SELECT c.category, c.product_name, c.total_profit
FROM CategoryTotalprofit c
JOIN MaxTotalprofitPerCategory m ON c.category = m.category
WHERE c.total_profit = m.max_total_profit
ORDER BY c.category DESC;

--Q-3 What is the average sale for each product category?

SELECT p.category, p.product_name, ROUND(AVG(s.sales)) AS avg_sales
    FROM products AS p
    JOIN sales AS s ON s.row_id = p.row_id
    GROUP BY p.category, p.product_name
	Order by avg_sales desc;

--Q_4 What are the total sales for each product category?
SELECT p.category, p.product_name, ROUND(SUM(s.sales)) AS total_sales
    FROM products AS p
    JOIN sales AS s ON s.row_id = p.row_id
    GROUP BY p.category, p.product_name
	Order by total_sales desc;
	
--Q_5 What is the relationship between sales and profit for each product category?
SELECT p.category, p.product_name, ROUND(SUM(s.sales)) AS total_sales, SUM(s.profit) AS total_profit
    FROM products AS p
    JOIN sales AS s ON s.row_id = p.row_id
    GROUP BY p.category, p.product_name
	Order by total_profit desc;
	
--Q_6 What is the relationship between sales and quantity for each product category?
SELECT p.category, p.product_name, ROUND(SUM(s.sales)) AS total_sales, SUM(s.quantity) AS total_quantity
    FROM products AS p
    JOIN sales AS s ON s.row_id = p.row_id
    GROUP BY p.category, p.product_name
	Order by total_quantity desc;
	
--Q_7 What is the relationship between sales and time for each product category?
SELECT p.category, p.product_name, Round(SUM(s.sales)) AS total_sales, (o.ship_date - o.order_date) AS avg_days_to_ship
From products as p
JOIN sales AS s ON s.row_id = p.row_id
Join orders as o ON o.row_id = s.row_id
GROUP BY p.category, p.product_name, avg_days_to_ship
order by total_sales desc;
