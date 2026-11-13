
-- =========================================================
-- MIGROS SALES DISTRIBUTION | SQL ANALYTICS CASE STUDY
-- 03_CATEGORY_PERFORMANCE.SQL
-- Author: Nagehan Bas
-- Database: SQLite 3
--
-- Purpose:
-- Analyze category-level sales performance, filter
-- low-volume categories, and rank categories by revenue.
--
-- Prerequisite: Run 01_database_setup.sql first.
-- =========================================================

SELECT
    category,
    COUNT(*) AS total_sales_records,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_price), 2) AS total_net_revenue
FROM purchases
GROUP BY category
HAVING COUNT(*) >= 10
ORDER BY total_net_revenue DESC;

-- =========================================================
-- ANALYSIS NOTES
-- =========================================================
-- Minimum volume threshold: 10 sales records.
-- The threshold is applied after grouping via HAVING.
--
-- Highest-revenue qualifying category:
-- Bebek ve Çocuk
-- Total net revenue: 3835.18
-- Sales records: 57
-- Unique orders: 57
--
-- This category is used in the subsequent analyses.
-- =========================================================
