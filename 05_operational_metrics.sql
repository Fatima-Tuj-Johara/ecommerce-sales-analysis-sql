-- ============================================
-- OPERATIONAL METRICS ANALYSIS
-- ============================================
-- Author: Fatima Tuj Johara
-- Date: January 2026
-- Description: Delivery performance, returns analysis and customer ratings

-- Return Analysis
-- Overall return rate 
SELECT 
    COUNT(CASE WHEN is_returned = TRUE THEN 1 END) * 100.0 / COUNT(*) AS return_rate_percent 
FROM synthetic_ecommerce_sales_2025;
-- Category wise returns 
SELECT 
    product_category,
    COUNT(*) AS total_returns
FROM synthetic_ecommerce_sales_2025
WHERE is_returned = TRUE 
GROUP BY product_category 
ORDER BY total_returns DESC;
-- Delivery Performance
-- Average Delivery Time 
SELECT 
    AVG(delivery_days) AS avg_delivery_days 
FROM synthetic_ecommerce_sales_2025; 
-- Late Deliveries (>7 days)
SELECT 
    COUNT(*) AS late_orders 
FROM synthetic_ecommerce_sales_2025
WHERE delivery_days > 7;
-- Delivery Performance by Region
SELECT 
    region, 
    AVG(delivery_days) AS avg_delivery,
    COUNT(CASE WHEN delivery_days > 7 THEN 1 END) AS late_deliveries,
    ROUND(COUNT(CASE WHEN delivery_days > 7 THEN 1 END) * 100.0 / COUNT(*), 2) AS late_deliveries_rate
FROM synthetic_ecommerce_sales_2025
GROUP BY region
ORDER BY avg_delivery;
-- Customer Rating Analysis 
-- Average Rating per Category 
SELECT
    product_category, 
    AVG(customer_rating) AS avg_rating 
FROM synthetic_ecommerce_sales_2025 
GROUP BY product_category; 
-- Delivery vs Rating Relationship 
SELECT 
    delivery_days, 
    AVG(customer_rating) AS avg_rating 
FROM synthetic_ecommerce_sales_2025 
GROUP BY delivery_days 
ORDER BY delivery_days;