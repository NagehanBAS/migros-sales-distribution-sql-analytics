
-- =========================================================
-- MIGROS SALES DISTRIBUTION | SQL ANALYTICS CASE STUDY
-- 02_OVERALL_SALES_METRICS.SQL
-- Author: Nagehan Bas
-- Database: SQLite 3
--
-- Purpose:
-- Calculate overall sales volume, unique order count,
-- total net revenue, and line-level revenue statistics.
--
-- Prerequisite: Run 01_database_setup.sql first.
-- =========================================================

SELECT
    COUNT(*) AS total_sales_records,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(SUM(net_price), 2) AS total_net_revenue,
    ROUND(MIN(net_price), 2) AS min_line_revenue,
    ROUND(MAX(net_price), 2) AS max_line_revenue,
    ROUND(AVG(net_price), 2) AS avg_line_revenue
FROM purchases;

-- =========================================================
-- EXPECTED RESULTS
-- =========================================================
-- Total sales records: 400
-- Unique orders:       397
-- Total net revenue:   17379.35
-- Minimum revenue:     1.30
-- Maximum revenue:     277.50
-- Average revenue:     43.45
--
-- Note:
-- Revenue metrics follow the provided educational
-- dataset's net_price field without quantity adjustment.
-- =========================================================
