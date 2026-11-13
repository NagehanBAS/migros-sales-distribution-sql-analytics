
# Migros Sales Distribution | SQL Analytics Case Study

**SQLite · Retail Analytics · Category Performance · Customer Segmentation · Sales KPIs**

An end-to-end SQL analytics case study exploring retail sales performance, category revenue distribution, customer purchasing behavior, and recent sales trends using a 400-record educational dataset.

> **Disclaimer:** This is an independent Workintech educational case study. It is not affiliated with Migros and does not represent the company's actual financial or operational performance.

---

## Executive Summary

This project analyzes retail transactions to identify revenue drivers, compare product categories, evaluate customer purchasing behavior, and examine recent sales performance.

| KPI | Result |
|---|---:|
| Total Sales Records | 400 |
| Unique Orders | 397 |
| Total Net Revenue | 17,379.35 |
| Minimum Line Revenue | 1.30 |
| Maximum Line Revenue | 277.50 |
| Average Line Revenue | 43.45 |
| Highest-Revenue Category | Bebek ve Çocuk |
| Highest Category Net Revenue | 3,835.18 |
| Customers with Multiple Orders | 11 |

**Key Finding:** The Baby & Children category generated the highest net revenue, narrowly outperforming Home & Living. Within the leading category, two product types contributed approximately 96.70% of revenue.

All monetary figures are expressed in dataset units. No currency is assumed.

---

## Business Objectives

The analysis addresses six business questions:

1. What are the overall sales volume and revenue indicators?
2. Which product categories generate the highest net revenue?
3. How is revenue distributed across subcategories and product types?
4. Which customers make repeat purchases, and how do their basket values differ?
5. How does the leading category perform during the latest 60-day period?
6. What insights can be communicated to retail management?

The objective is to convert transaction-level retail data into interpretable business metrics.

---

## Dataset Overview

The analysis uses a single relational table: `purchases`.

**Dataset size:** 400 sales records

### Data Dictionary

| Column | Description |
|---|---|
| `id` | Sales record identifier |
| `order_date` | Transaction date |
| `order_id` | Order identifier |
| `customer_id` | Customer identifier |
| `product_id` | Product identifier |
| `category` | Product category |
| `subcategory` | Product subcategory |
| `product_type` | Product type |
| `membership_type` | Customer membership label |
| `promotion` | Promotion or campaign label |
| `gross_price` | Recorded gross price |
| `net_price` | Recorded net price |
| `cost_price` | Recorded cost price |
| `quantity` | Recorded product quantity |

Some transactions contain missing product types, membership labels, or promotion labels.

### Data Granularity

Each row represents one recorded sales line.

A single order may contain multiple sales lines. Consequently, sales record counts and unique order counts are not interchangeable.

The dataset includes labels referencing multiple retail brands and membership programs. These values are preserved as supplied rather than treated as verified Migros customer classifications.

---

## Analytical Methodology

The project follows six sequential tasks.

### Task 1 — Database Setup and Validation

Create the `purchases` table, insert the supplied records, and verify the data import.

```sql
SELECT COUNT(*) AS total_records
FROM purchases;
```

**Result:** 400 records.

### Task 2 — Overall Sales Metrics

Calculate total sales records, unique orders, total net revenue, and minimum, maximum, and average line-level net revenue in one query.

**Key SQL functions:** `COUNT`, `DISTINCT`, `SUM`, `MIN`, `MAX`, `AVG`, `ROUND`

**Result:** 397 unique orders and 17,379.35 in total recorded net revenue.

### Task 3 — Category Sales Performance

Aggregate transaction records by category, calculate revenue and order counts, filter low-volume categories, and rank the remaining categories by revenue.

**Key SQL clauses:** `GROUP BY`, `HAVING`, `ORDER BY DESC`

A minimum threshold of 10 sales records per category was selected for the category-level summary.

### Task 4 — Subcategory and Product Type Analysis

Analyze the leading category by combining `subcategory` and `product_type` dimensions.

Calculate each combination's net revenue, order count, and percentage contribution to the leading category's total revenue.

**Key SQL techniques:** Multi-column `GROUP BY`, scalar subquery, `NULLIF`, percentage calculation.

### Task 5 — Customer Purchase and Basket Metrics

Calculate customer-level spending, unique order counts, and average basket values.

Order-level revenue is calculated before customer-level aggregation to avoid confusing transaction lines with complete shopping baskets.

**Key SQL techniques:** Common table expression (`WITH`), nested aggregation, `HAVING COUNT(*) > 1`.

### Task 6 — Last 60 Days Category Analysis

Analyze the highest-revenue category during the 60 days preceding the dataset's latest order date.

The analysis uses a dynamic date reference rather than a hard-coded calendar date.

**Key SQL functions:** `MAX`, SQLite `date()`, `GROUP BY`, `SUM`, `COUNT`.

---

## Key Business Findings

### 1. Category Revenue Performance

Categories are ranked by total recorded net revenue, with a minimum of 10 sales records.

| Category | Sales Records | Unique Orders | Net Revenue |
|---|---:|---:|---:|
| Bebek ve Çocuk | 57 | 57 | 3,835.18 |
| Ev ve Yaşam | 95 | 94 | 3,831.76 |
| İçecek | 97 | 97 | 3,349.35 |
| Sağlık ve Kişisel Bakım | 65 | 65 | 2,936.13 |
| Atıştırmalık ve Tatlı | 53 | 52 | 2,911.06 |
| Bahçe ve Evcil Hayvan | 10 | 10 | 185.92 |
| Güzellik ve Hijyen | 14 | 14 | 117.90 |

**Insight:** Bebek ve Çocuk leads Ev ve Yaşam by just 3.42 in net revenue, despite generating fewer sales records.

Revenue performance is therefore not determined by transaction volume alone.

### 2. Leading Category: Subcategory and Product Type Breakdown

The highest-revenue category is **Bebek ve Çocuk**, with total net revenue of 3,835.18.

| Subcategory | Product Type | Net Revenue | Revenue Share |
|---|---|---:|---:|
| Bebek Bezi ve Bakım | Yıkanabilir Bebek Bezi | 1,983.37 | 51.72% |
| Çocuk Hobi Ürünleri | Boya ve Boyama Seti | 1,725.07 | 44.98% |
| Çocuk Ulaşım Ürünleri | Üç Tekerlekli Bisiklet | 52.55 | 1.37% |
| Bebek Bezi ve Bakım | Yıkanabilir Bebek Külotu | 29.06 | 0.76% |
| Bebek Bezi ve Bakım | Yıkanabilir Havuz Bezi | 26.47 | 0.69% |
| Çocuk Hobi Ürünleri | Oyun Hamuru | 16.49 | 0.43% |
| Bebek Bezi ve Bakım | Yıkanabilir Bez Bakımı | 2.17 | 0.06% |

**Insight:** The top two product types contribute approximately 96.70% of the leading category's revenue.

This concentration suggests that monitoring a small number of product groups could be useful for category performance reviews.

Percentages may not sum to exactly 100% because of rounding.

### 3. Repeat Customer Analysis

The analysis identified **11 customers with more than one distinct order**.

| Customer ID | Total Spending | Orders | Average Basket Value |
|---|---:|---:|---:|
| 47166 | 296.49 | 2 | 148.25 |
| 115043 | 34.14 | 5 | 6.83 |
| 100671 | 29.87 | 2 | 14.94 |
| 91426 | 25.64 | 2 | 12.82 |
| 5742 | 21.44 | 2 | 10.72 |
| 47346 | 20.32 | 2 | 10.16 |
| 122753 | 12.82 | 2 | 6.41 |
| 108488 | 9.85 | 4 | 2.46 |
| 24824 | 8.56 | 2 | 4.28 |
| 105468 | 5.66 | 2 | 2.83 |
| 107565 | 4.11 | 2 | 2.05 |

**Insight:** Customer 47166 has the highest spending among repeat customers, while customer 115043 has the highest order frequency.

This illustrates the distinction between spending intensity and purchasing frequency.

Average basket value is calculated as total order revenue divided by the number of distinct customer orders.

### 4. Last 60 Days of Leading-Category Sales

The analysis dynamically filters Bebek ve Çocuk transactions based on the latest order date in the dataset.

| Subcategory | Sales Records | Unique Orders | Net Revenue |
|---|---:|---:|---:|
| Bebek Bezi ve Bakım | 23 | 23 | 1,945.07 |
| Çocuk Hobi Ürünleri | 22 | 22 | 1,693.85 |
| **Total** | **45** | **45** | **3,638.92** |

**Insight:** Bebek Bezi ve Bakım contributed approximately 53.45% of the revenue in the selected period.

The selected 60-day window accounts for approximately 94.88% of the leading category's total recorded revenue.

The time window is relative to the latest date in the dataset, not the date the query is executed.

---

## SQL Techniques Demonstrated

- Dataset creation and import validation
- Sales record and unique order counting
- Revenue aggregation with `SUM`
- Minimum, maximum, and average calculations
- Multi-dimensional category segmentation
- Aggregate filtering with `HAVING`
- Descending revenue rankings
- Numeric precision with `ROUND`
- Percentage calculations with `NULLIF`
- Scalar subqueries
- Common table expressions (CTEs)
- Order-level and customer-level aggregation
- Dynamic date filtering in SQLite
- Translating transaction data into business insights

---

## Repository Structure

```text
migros-sales-distribution-sql-analytics/
├── README.md
└── sql/
    ├── 01_database_setup.sql
    ├── 02_overall_sales_metrics.sql
    ├── 03_category_performance.sql
    ├── 04_subcategory_product_analysis.sql
    ├── 05_customer_basket_analysis.sql
    └── 06_last_60_days_analysis.sql
```

### SQL Scripts

**01 — Database Setup**

Creates the `purchases` table, inserts the educational dataset, and validates the record count.

**02 — Overall Sales Metrics**

Calculates overall transaction volume, unique order counts, and net revenue statistics.

**03 — Category Performance**

Ranks category revenue and applies a minimum sales-volume threshold.

**04 — Subcategory and Product Analysis**

Examines revenue distribution across subcategories and product types within the leading category.

**05 — Customer Basket Analysis**

Identifies repeat customers and calculates spending and average basket values.

**06 — Last 60 Days Analysis**

Analyzes recent subcategory performance using a dynamic date window.

---

## How to Reproduce the Analysis

**Requirements:** SQLite 3

Create a fresh SQLite database and run the scripts in numeric order.

```bash
sqlite3 migros_sales.db < sql/01_database_setup.sql
sqlite3 -header -column migros_sales.db < sql/02_overall_sales_metrics.sql
sqlite3 -header -column migros_sales.db < sql/03_category_performance.sql
sqlite3 -header -column migros_sales.db < sql/04_subcategory_product_analysis.sql
sqlite3 -header -column migros_sales.db < sql/05_customer_basket_analysis.sql
sqlite3 -header -column migros_sales.db < sql/06_last_60_days_analysis.sql
```

Alternatively, execute the SQL scripts in order using [SQLite Online](https://sqliteonline.com/).

The setup script is intended for a fresh database to avoid conflicts with existing tables.

---

## Assumptions and Limitations

### Revenue Definition

The project uses the provided `net_price` column as recorded line-level net revenue, following the educational task specification.

The dataset also includes `quantity`, but the analysis does not multiply `net_price` by quantity.

Therefore, reported totals should not be interpreted as independently verified unit-price-based sales revenue.

### Sales Records vs. Orders

A sales record represents a row in the source table, while a unique order is identified by `order_id`.

These measures are reported separately when appropriate.

### Average Basket Value

Customer basket values are computed using aggregated order totals, rather than averaging raw transaction lines.

### Low-Volume Category Filtering

The category ranking excludes categories with fewer than 10 sales records.

This threshold is an analytical choice, not a business-defined minimum.

### Historical Date Window

The last-60-days analysis is anchored to the latest order date available in the dataset.

The date range is not intended to represent the most recent 60 calendar days relative to today.

### Educational Data

The dataset contains synthetic-style retail examples and references multiple retailers, campaigns, and loyalty programs.

The project does not verify whether these labels represent real commercial relationships.

### Analytical Scope

Findings are descriptive and based on a limited educational dataset.

They are not intended as causal claims or statistically significant estimates of real-world retail performance.

---

## Future Improvements

Potential extensions include:

- Gross margin and profitability analysis
- Promotion effectiveness measurement
- Customer segmentation using RFM analysis
- Category contribution and Pareto analysis
- Interactive Power BI dashboards
- Monthly revenue and customer retention monitoring
- Automated data quality checks

These are possible future extensions and are not included in the current implementation.

---

## Project Information

| Field | Details |
|---|---|
| Project | Migros Sales Distribution — SQL Analytics |
| Program | Workintech — Data Science & AI |
| Technology | SQLite 3 |
| Domain | Retail and Commercial Analytics |
| Focus | Category Management, Customer Analytics, Sales KPIs |
| Type | Independent Educational Portfolio Project |

---

**Author:** Nagehan BAS
