-- Create a New Database

CREATE DATABASE complex_queries;
USE complex_queries;

 -- Create a Sample Table
 CREATE TABLE sales (
  sale_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  category VARCHAR(50),
  sale_amount INT,
  sale_date DATE
);

-- Insert Sample Data
INSERT INTO sales VALUES
(1, 'Pen', 'Stationery', 100, '2025-07-01'),
(2, 'Pencil', 'Stationery', 80, '2025-07-02'),
(3, 'Notebook', 'Stationery', 120, '2025-07-03'),
(4, 'Phone', 'Electronics', 25000, '2025-07-02'),
(5, 'Charger', 'Electronics', 2000, '2025-07-04'),
(6, 'Laptop', 'Electronics', 60000, '2025-07-04');

-- Show products that have sale_amount more than average sale amount

SELECT * FROM sales
WHERE sale_amount > (SELECT AVG(sale_amount) FROM sales);

-- Create a temporary table with average sale amount per category
WITH category_avg AS (
  SELECT category, AVG(sale_amount) AS avg_amt
  FROM sales
  GROUP BY category
)

-- Join that temporary table with sales table
SELECT 
  s.product_name, 
  s.category, 
  s.sale_amount, 
  c.avg_amt
FROM sales s
JOIN category_avg c ON s.category = c.category;

-- Rank products within each category by sale_amount (high to low)
SELECT 
  product_name,
  category,
  sale_amount,
  RANK() OVER (PARTITION BY category ORDER BY sale_amount DESC) AS rank_in_category
FROM sales;

-- Step 7: Use LEAD() to see next product’s sale amount within the same category
SELECT 
  product_name,
  category,
  sale_amount,
  LEAD(sale_amount) OVER (PARTITION BY category ORDER BY sale_amount DESC) AS next_product_sale
FROM sales;



