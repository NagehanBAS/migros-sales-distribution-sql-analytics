
-- =========================================================
-- MIGROS SALES DISTRIBUTION | SQL ANALYTICS CASE STUDY
-- 05_CUSTOMER_BASKET_ANALYSIS.SQL
-- Author: Nagehan Bas
-- Database: SQLite 3
--
-- Purpose:
-- Analyze repeat customer purchasing behavior, calculate
-- total customer spending, order frequency, and average
-- basket value using order-level aggregation.
--
-- Prerequisite: Run 01_database_setup.sql first.
-- =========================================================

-- Aggregate sales lines into complete customer orders.
-- This prevents multiple items in a single order from
-- being incorrectly counted as separate orders.

WITH order_totals AS (
    SELECT
        customer_id,
        order_id,
        SUM(net_price) AS order_revenue
    FROM purchases
    GROUP BY
        customer_id,
        order_id
)

SELECT
    customer_id,
    ROUND(SUM(order_revenue), 2) AS total_spending,
    COUNT(*) AS total_orders,
    ROUND(AVG(order_revenue), 2) AS avg_basket_value
FROM order_totals
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_spending DESC;

-- =========================================================
-- ANALYSIS NOTES
-- =========================================================
-- Repeat customers identified: 11
--
-- Highest spending repeat customer:
-- Customer ID: 47166
-- Total spending: 296.49
-- Orders: 2
-- Average basket value: 148.25
--
-- Highest order frequency:
-- Customer ID: 115043
-- Total orders: 5
-- Total spending: 34.14
-- Average basket value: 6.83
--
-- Average basket value is calculated at the order level,
-- not directly from individual sales records.
--
-- This distinction is important because one order
-- can contain multiple product lines.
-- =========================================================
