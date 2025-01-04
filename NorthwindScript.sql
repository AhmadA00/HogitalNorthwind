----- 1: find all products and thier category name
SELECT p.product_id, p.product_name, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;

------ 2: Find the most popular ordered product
Select p.product_name, count(od.product_id) as total_quantity
From products p
Join order_details od On p.product_id = od.product_id
Group by p.product_name
Order by total_quantity Desc
Limit 1;

----- 3: Find the most popular ordered product category
Select ct.category_name, count(od.product_id) as count_of_order
From categories ct
Join products p On ct.category_id = p.category_id
Join order_details od On p.product_id = od.product_id
Group by ct.category_name
Order by count_of_order Desc
Limit 1;

-------  4: Calculate the total value of inventory
Select sum(p.units_in_stock * p.unit_price) as total_inventory_value
From products p

-------  5: Determine the top 5 products with higest stock value
Select p.product_name, sum(p.units_in_stock * p.unit_price) as stock_value
From products p
Group by p.product_name
Order by stock_value Desc
Limit 5;
------- 6: Determine the total sale on each product
Select p.product_name, sum((od.unit_price * od.quantity) *(1 - od.discount)) as total_sales
From products p
Join order_details od On p.product_id = od.product_id
Group by p.product_name
Order by total_sales Desc;

------- 7: Determine the sales by country
Select c.country, sum((od.unit_price * od.quantity) * (1 - od.discount)) as total_sales
From customers c
Join orders o On c.customer_id = o.customer_id
Join order_details od On o.order_id = od.order_id
Group by c.country
Order by total_sales Desc;

------ 8: Get products with price above average
Select product_name, unit_price
From products
Where unit_price > (Select avg(unit_price) From products)
Order by unit_price Desc;

------ 9: Find customers who have placed orders
Select c.customer_id, c.contact_name
From customers c
Where c.customer_id in (Select o.customer_id From orders o);

------ 10: Find monthly sales breakdown
Select Extract(Month from o.order_date) as order_month, sum(od.unit_price * od.quantity) as monthly_sales
From orders o
Join Order_details od On o.order_id = od.order_id
Group by order_month
Order by order_month;

------- 11: FInd all orders with discounts
Select o.order_id, c.company_name, od.quantity, od.discount
From customers c
Join orders o On c.customer_id = o.customer_id
Join order_details od On o.order_id = od.order_id
Where od.discount > 0
Order by od.discount Desc;
