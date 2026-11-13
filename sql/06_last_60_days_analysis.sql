
-- =========================================================
-- MIGROS SALES DISTRIBUTION | SQL ANALYTICS CASE STUDY
-- 06_LAST_60_DAYS_ANALYSIS.SQL
-- Author: Nagehan Bas
-- Database: SQLite 3
--
-- Purpose:
-- Analyze recent sales performance for the leading
-- revenue category using a dynamic 60-day date window.
--
-- Prerequisite: Run 01_database_setup.sql first.
-- =========================================================

SELECT
    subcategory,
    COUNT(*) AS total_sales_records,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_price), 2) AS total_net_revenue
FROM purchases
WHERE category = 'Bebek ve Çocuk'
  AND date(order_date) BETWEEN
      (
          SELECT date(MAX(order_date), '-60 days')
          FROM purchases
      )
      AND (
          SELECT date(MAX(order_date))
          FROM purchases
      )
GROUP BY subcategory
ORDER BY total_net_revenue DESC;

-- =========================================================
-- ANALYSIS NOTES
-- =========================================================
-- The date window is anchored to the latest order date
-- in the dataset rather than the current calendar date.
--
-- The date() function provides SQLite-compatible
-- date arithmetic instead of INTERVAL syntax.
--
-- Expected results:
--
-- Subcategory: Bebek Bezi ve Bakım
-- Sales records: 23
-- Unique orders: 23
-- Net revenue: 1945.07
--
-- Subcategory: Çocuk Hobi Ürünleri
-- Sales records: 22
-- Unique orders: 22
-- Net revenue: 1693.85
--
-- Combined revenue: 3638.92
-- Combined sales records: 45
--
-- BETWEEN includes both date boundaries.
-- =========================================================
