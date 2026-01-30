-- ============================================
-- CUSTOMER ANALYSIS
-- ============================================
-- Author: Fatima Tuj Johara
-- Date: January 2026
-- Description: Customer segmentation, RFM analysis, and cohort analysis

-- Top 10 Customers by Revenue 
SELECT 
    customer_id,
    SUM(revenue) AS total_spent 
FROM synthetic_ecommerce_sales_2025 
GROUP BY customer_id
ORDER BY total_spent DESC 
LIMIT 10; 
-- Repeat Customers
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders 
FROM synthetic_ecommerce_sales_2025 
GROUP BY customer_id 
HAVING COUNT(order_id) > 1; 
-- Customer Lifetime Value with RFM Analysis
SELECT 
    customer_id,
    COUNT(DISTINCT order_id) AS frequency,
    MAX(order_date) AS recency,
    SUM(revenue) AS monetary_value,
    CASE 
        WHEN SUM(revenue) > 1000 THEN 'High Value'
        WHEN SUM(revenue) > 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM synthetic_ecommerce_sales_2025
GROUP BY customer_id;
-- Cohort Analysis: First Purchase Month Retention
WITH first_purchase AS (
    SELECT 
        customer_id,
        MIN(DATE_FORMAT(order_date, '%Y-%m')) AS cohort_month
    FROM synthetic_ecommerce_sales_2025
    GROUP BY customer_id
)
SELECT 
    fp.cohort_month,
    DATE_FORMAT(s.order_date, '%Y-%m') AS purchase_month,
    COUNT(DISTINCT s.customer_id) AS customers
FROM synthetic_ecommerce_sales_2025 s
JOIN first_purchase fp ON s.customer_id = fp.customer_id
GROUP BY fp.cohort_month, DATE_FORMAT(s.order_date, '%Y-%m')
ORDER BY fp.cohort_month, purchase_month;