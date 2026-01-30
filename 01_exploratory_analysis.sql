-- ============================================
-- EXPLORATORY DATA ANALYSIS
-- ============================================
-- Author: Fatima Tuj Johara
-- Date: January 2026
-- Description: Initial exploration and revenue analysis

-- Preview dataset
SELECT * FROM synthetic_ecommerce_sales_2025 LIMIT 10; 
-- Get total order count
SELECT COUNT(*) AS total_orders FROM synthetic_ecommerce_sales_2025;
-- Sales and Revenue Analysis
-- Total Revenue
SELECT SUM(revenue) AS total_revenue FROM synthetic_ecommerce_sales_2025; 
-- Revenue By Product Category 
SELECT
    product_category, 
    SUM(revenue) AS category_revenue 
FROM synthetic_ecommerce_sales_2025 
GROUP BY product_category 
ORDER BY category_revenue DESC;
-- Revenue by Region 
SELECT
    region, 
    SUM(revenue) AS total_revenue 
FROM synthetic_ecommerce_sales_2025
GROUP BY region 
ORDER BY total_revenue DESC;
-- Time based Analysis
SELECT 
    MONTH(order_date) AS month,
    SUM(revenue) AS monthly_revenue 
FROM synthetic_ecommerce_sales_2025 
GROUP BY month 
ORDER BY month;