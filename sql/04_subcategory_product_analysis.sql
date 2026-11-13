
-- =========================================================
-- MIGROS SALES DISTRIBUTION | SQL ANALYTICS CASE STUDY
-- 04_SUBCATEGORY_PRODUCT_ANALYSIS.SQL
-- Author: Nagehan Bas
-- Database: SQLite 3
--
-- Purpose:
-- Analyze subcategory and product-type performance
-- within the highest-revenue qualifying category.
--
-- Prerequisite: Run 01_database_setup.sql first.
-- =========================================================

SELECT
    subcategory,
    product_type,
    COUNT(*) AS total_sales_records,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_price), 2) AS total_net_revenue,
    ROUND(
        100.0 * SUM(net_price) /
        NULLIF(
            (
                SELECT SUM(net_price)
                FROM purchases
                WHERE category = 'Bebek ve Çocuk'
            ),
            0
        ),
        2
    ) AS revenue_share_pct
FROM purchases
WHERE category = 'Bebek ve Çocuk'
GROUP BY
    subcategory,
    product_type
ORDER BY total_net_revenue DESC;

-- =========================================================
-- ANALYSIS NOTES
-- =========================================================
-- Leading category: Bebek ve Çocuk
-- Total category revenue: 3835.18
--
-- Highest-revenue product type:
-- Yıkanabilir Bebek Bezi
-- Revenue: 1983.37
-- Category revenue share: 51.72%
--
-- Second-highest product type:
-- Boya ve Boyama Seti
-- Revenue: 1725.07
-- Category revenue share: 44.98%
--
-- Combined revenue share of the top two product types:
-- Approximately 96.70%.
--
-- Revenue shares use the leading category's full
-- revenue as the denominator.
-- =========================================================
