-- Window Functions:
-- Calculate the total sales amount for each order along with the individual product sales.
SELECT
	o.Order_ID,
	p.Product_ID,
	p.Price,
	o.Quantity,
	o.Total_Price,
	SUM(p.Price * o.Quantity) OVER (PARTITION BY o.Order_ID) AS total_sales_amount
FROM
	yanki.orders o
JOIN
	yanki.products p ON o.Product_ID = p.Product_ID;

-- Calculate the running total price for each order.
SELECT
	Order_ID,
	Product_ID,
	Quantity,
	Total_price,
	SUM(Total_price) OVER (ORDER BY Order_ID) AS running_total_price
FROM
	yanki.orders;

-- Rank products by their price within each category.
SELECT 	
	Product_ID,
	Product_Name,
	Brand,
	Category,
	Price,
	Rank() OVER (PARTITION BY Category ORDER BY Price DESC) AS price_rank_by_Category
FROM
	yanki.products

-- Ranking:
-- 1. Rank customers by the total amount they have spent.
SELECT
	c.Customer_ID,
	c.Customer_Name,
	SUM(Total_Price) as total_spent,
	RANK() OVER (ORDER BY SUM (Total_Price) DESC) as customer_rank
FROM
	yanki.customers c
JOIN
	yanki.orders o ON c.Customer_ID = o.Customer_ID
GROUP BY
	c.Customer_ID,
	c.Customer_Name;

GROUP BY
	p.Product_ID,
	p.Product_Name;

-- 2. Rank orders by their total price.
SELECT 	
	p.Product_ID,
	p.Product_ID,
	SUM(o.Quantity) As total_quantity_sold,
	SUM(o.Total_Price) AS Total_sales_amount,
	RANK() OVER (ORDER BY SUM(o.Total_Price) DESC) as product_rank
FROM
	yanki.products p
JOIN
	yanki.orders o ON p.Product_ID = o.Product_ID
GROUP BY
	p.Product_ID,
	p.Product_Name;
	

-- 3. Rank orders by their total price.
SELECT
	Order_ID,
	Total_Price,
	RANK() OVER (ORDER BY Total_Price DESC) as order_rank
FROM
	yanki.orders;
