-- ============================================
-- PRODUCT PERFORMANCE ANALYSIS
-- ============================================
-- Author: Fatima Tuj Johara
-- Date: January 2026
-- Description: Product insights, discount effectiveness and pricing analysis

-- Products with Above-Average Ratings and Revenue
SELECT 
    product_category,
    COUNT(*) AS total_orders,
    AVG(customer_rating) AS avg_rating,
    SUM(revenue) AS total_revenue,
    AVG(revenue) AS avg_order_value
FROM synthetic_ecommerce_sales_2025
GROUP BY product_category
HAVING AVG(customer_rating) > (SELECT AVG(customer_rating) FROM synthetic_ecommerce_sales_2025)
ORDER BY total_revenue DESC;
-- Pricing & Discount Analysis
-- Average Discount
SELECT 
    AVG(discount_percent) AS avg_discount 
FROM synthetic_ecommerce_sales_2025;
-- Discount impact on revenue 
SELECT 
    discount_percent,
    SUM(revenue) AS revenue_generated 
FROM synthetic_ecommerce_sales_2025
GROUP BY discount_percent 
ORDER BY discount_percent DESC;
-- Discount effectiveness: Revenue per discount tier
SELECT
    CASE
        WHEN discount_percent = 0 THEN "No Discount"
        WHEN discount_percent = 10 THEN "1-10%"
        WHEN discount_percent = 20 THEN "11-20%"
        ELSE "20%+"
    END AS discount_tier,
    COUNT(*) AS order_count,
    SUM(revenue) AS total_revenue,
    AVG(revenue) AS avg_revenue_per_order,
    AVG(customer_rating) AS avg_rating
FROM synthetic_ecommerce_sales_2025
GROUP BY discount_tier
ORDER BY avg_revenue_per_order DESC;
-- Revenue rank by Category 
SELECT 
    product_category, 
    SUM(revenue) AS total_revenue,
    RANK() OVER(ORDER BY SUM(revenue) DESC) AS revenue_rank 
FROM synthetic_ecommerce_sales_2025 
GROUP BY product_category;