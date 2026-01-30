-- ============================================
-- TEMPORAL ANALYSIS
-- ============================================
-- Author: Fatima Tuj Johara
-- Date: January 2026
-- Description: Time-based trends, seasonality and growth analysis

-- Month-over-Month Growth Rate
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(order_date, "%Y-%m") AS month,
        SUM(revenue) AS revenue
    FROM synthetic_ecommerce_sales_2025
    GROUP BY month 
)
SELECT 
    month, 
    revenue, 
    LAG(revenue) OVER(ORDER BY month) AS previous_month_revenue,
    ROUND(((revenue - LAG(revenue) OVER(ORDER BY month)) / 
           LAG(revenue) OVER(ORDER BY month) * 100), 2) AS growth_rate_percent
FROM monthly_revenue;
-- Day of week performance
SELECT 
    DAYNAME(order_date) AS day_of_week,
    COUNT(*) AS orders,
    SUM(revenue) AS total_revenue,
    AVG(customer_rating) AS avg_rating
FROM synthetic_ecommerce_sales_2025
GROUP BY day_of_week, DAYOFWEEK(order_date)
ORDER BY DAYOFWEEK(order_date);
-- Running Total revenue
SELECT 
    order_date,
    SUM(revenue) OVER(ORDER BY order_date) AS cumulative_revenue 
FROM synthetic_ecommerce_sales_2025;