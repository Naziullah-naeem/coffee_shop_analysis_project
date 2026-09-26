Select *
from dbo.Transaction_coffee_shop_sales

--sales count

SELECT COUNT(*) AS total_rows
FROM dbo.Transaction_coffee_shop_sales;

-- Data validation

SELECT COUNT(DISTINCT transaction_id) AS unique_ids
FROM dbo.Transaction_coffee_shop_sales;


-- Exploratory data analysis

SELECT TOP 20
    transaction_id,
    transaction_date,
    transaction_time
FROM dbo.Transaction_coffee_shop_sales
ORDER BY transaction_id ASC;

-- Data formatting

ALTER TABLE dbo.Transaction_coffee_shop_sales
ADD transaction_date_clean DATE;

--KPI


Select 
    sum (transaction_qty * unit_price) as Total_revenue,
    avg (transaction_qty * unit_price) as avg_transaction_value,
    sum (transaction_qty) as total_item_sold,
    sum (transaction_qty) / count (transaction_id) as average_item_per_transaction,
    count (transaction_qty) as Total_transaction
from dbo.Transaction_coffee_shop_sales



SELECT 
    SUM(transaction_qty * unit_price) AS Total_revenue,
    AVG(transaction_qty * unit_price) AS avg_transaction_value,
    SUM(transaction_qty) AS total_item_sold,
    CAST(SUM(transaction_qty) AS DECIMAL(10,2)) 
        / COUNT(transaction_id) AS average_item_per_transaction,
    COUNT(transaction_id) AS Total_transaction
FROM dbo.Transaction_coffee_shop_sales;

--EDA

SELECT top 10
    transaction_date_clean as Date_selected,   
    SUM(transaction_qty * unit_price) as daily_revenue

FROM dbo.Transaction_coffee_shop_sales
group by transaction_date_clean
Order by daily_revenue desc 

-- Monthly data extraction

SELECT 
    Month(transaction_date_clean) as 'Month' ,   
    SUM(transaction_qty * unit_price) as Monthly_revenue,
    Count (transaction_qty) as Total_transaction,
    avg (transaction_qty * unit_price) as Avg_transaction

FROM dbo.Transaction_coffee_shop_sales
group by Month(transaction_date_clean)
Order by monthly_revenue desc 

--Data trends

SELECT 
    MONTH(transaction_date_clean) AS Month,   
    SUM(transaction_qty * unit_price) AS Monthly_revenue,
    COUNT(transaction_id) AS Total_transaction,
    SUM(transaction_qty) AS Total_items_sold,
    AVG(transaction_qty * unit_price) AS Avg_transaction_value

FROM dbo.Transaction_coffee_shop_sales
GROUP BY MONTH(transaction_date_clean)
ORDER BY Monthly_revenue DESC;

--Store performance identification

Select 
    store_location,
    SUM(transaction_qty * unit_price) as Revenue,
    COUNT(transaction_id) as total_transaction,
    SUM(transaction_qty) as Total_item_sold,
    AVG(transaction_qty * unit_price) AS Avg_transaction_value

From Transaction_coffee_shop_sales
group by store_location
Order by Revenue desc

--Best performing product category

SELECT top 5
    product_category,
    SUM(transaction_qty * unit_price) AS Revenue,
    COUNT(transaction_id) AS Total_transactions,
    SUM(transaction_qty) AS Total_items_sold,
    AVG(transaction_qty * unit_price) AS Avg_transaction_value
FROM dbo.Transaction_coffee_shop_sales
GROUP BY product_category
ORDER BY Revenue DESC;

-- Best performance product type

SELECT TOP 10
    product_type,
    SUM(transaction_qty * unit_price) AS Revenue,
    COUNT(transaction_id) AS Total_transactions,
    SUM(transaction_qty) AS Total_items_sold,
    AVG(transaction_qty * unit_price) AS Avg_transaction_value
FROM dbo.Transaction_coffee_shop_sales
GROUP BY product_type
ORDER BY Revenue DESC;


--Daytime sales trends

SELECT
    DATEPART(HOUR, transaction_time) AS Sales_hour,
    SUM(transaction_qty * unit_price) AS Revenue,
    COUNT(transaction_id) AS Total_transactions,
    SUM(transaction_qty) AS Total_items_sold
FROM dbo.Transaction_coffee_shop_sales
GROUP BY DATEPART(HOUR, transaction_time)
ORDER BY Revenue desc;

-- Weekly sales trend

SELECT
    DATENAME(WEEKDAY, transaction_date_clean) AS Day_of_week,
    SUM(transaction_qty * unit_price) AS Revenue,
    COUNT(transaction_id) AS Total_transactions,
    SUM(transaction_qty) AS Total_items_sold,
    AVG(transaction_qty * unit_price) AS Avg_transaction_value
FROM dbo.Transaction_coffee_shop_sales
GROUP BY DATENAME(WEEKDAY, transaction_date_clean)
ORDER BY Revenue desc;


