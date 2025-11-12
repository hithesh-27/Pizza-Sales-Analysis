
create database PizzaDB;
use PizzaDB;
select * from pizza_sales;

#1. Find Total Revenue
select sum(total_price) as Total_Revenue from pizza_sales;

#2 Calculate average Total Order Values
select sum(total_price)/count(Distinct order_id) as average_order_value from pizza_sales;

#3 Total Pizza Sold
select sum(quantity) as total_pizza_sold from pizza_sales;

#4 Total Orders placed
select count(distinct order_id) as total_orders from pizza_sales;

#5 Average Pizzas Per Order
Select cast(SUM(quantity) / count(Distinct order_id) as decimal(10,2)) as Average_Pizzas_Per_Order from pizza_sales;

#6. Daily trend of total orders
SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%y')) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%y'));

#7 Hourly Trend for Total Orders
SELECT 
    HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(STR_TO_DATE(order_time, '%H:%i:%s'))
ORDER BY order_hour;

#8. Percentage of Sales by Pizza Category
select pizza_category, sum(total_price)*100/(select sum(total_price) from pizza_sales) as Total_sales
from pizza_sales 
group by pizza_category;

#9.  Percentage of Sales by Pizza Size
select pizza_size,sum(total_price) as Total_Sales, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales) as decimal(10,2)) as PST
from pizza_sales 
where quarter(STR_TO_DATE(order_date, '%d-%m-%y'))
group by pizza_size
order by PST desc;

#10. Total Pizzas Sold by Pizza Category
select pizza_category,sum(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_category;

#11. Total 5 Best Sellers by Total Pizzas Sold

select pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc
limit 5;

#12 Bottom 5 Sales
select pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
group by pizza_name
order by sum(quantity) 
limit 5;
