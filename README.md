
# Migros Sales Distribution | SQL Analytics Case Study

**SQLite · Retail Analytics · Category Management · Customer Analytics · Executive Reporting**

An end-to-end retail analytics case study transforming 400 educational sales records into actionable commercial insights through SQL analysis and an executive sales dashboard.

> **Disclaimer:** This is an independent Workintech educational case study. It is not affiliated with Migros and does not represent the company's actual financial or operational performance.

## Live Executive Dashboard

### [View the Interactive-Style Executive Sales Dashboard](https://nagehanbas.github.io/migros-sales-distribution-sql-analytics/dashboard/)

The dashboard provides a visual, management-oriented summary of the project's SQL findings.

**Dashboard Highlights:**
- Executive KPI scorecard
- Revenue performance by product category
- Leading-category product revenue mix
- Repeat customer purchasing behavior
- Latest 60-day sales performance
- Commercial insights and management takeaways

**Dashboard technology:** HTML5 and CSS3

The dashboard is a responsive, static analytical snapshot based on the SQL query results. It does not use a live database connection or interactive filtering.

---

## Executive Summary

This project analyzes retail sales performance to identify revenue drivers, evaluate product category contributions, examine repeat customer behavior, and assess recent sales trends.

| KPI | Result |
|---|---:|
| Total Sales Records | 400 |
| Unique Orders | 397 |
| Total Net Revenue | 17,379.35 |
| Minimum Line Revenue | 1.30 |
| Maximum Line Revenue | 277.50 |
| Average Line Revenue | 43.45 |
| Highest-Revenue Category | Bebek ve Çocuk |
| Leading Category Revenue | 3,835.18 |
| Customers with Multiple Orders | 11 |

**Key Finding:** The Baby & Children category generated the highest net revenue, narrowly outperforming Home & Living. Within the leading category, two product types contributed approximately 96.70% of total category revenue.

All monetary figures are expressed in dataset units. No currency is assumed.

---

## Business Objectives

The analysis addresses six business questions:

1. What are the overall sales volume and revenue indicators?
2. Which product categories generate the highest net revenue?
3. How is revenue distributed across subcategories and product types?
4. Which customers make repeat purchases, and how do their average basket values differ?
5. How does the leading category perform during the latest 60-day period?
6. What commercial insights can support management decision-making?

The objective is to translate transaction-level retail data into structured performance indicators and business recommendations.

---

## Dataset Overview

The analysis uses a single source table: `purchases`.

**Dataset size:** 400 sales records.

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

### Data Granularity

Each row represents one recorded sales line.

A single order may contain multiple sales lines, meaning sales record counts and unique order counts are not interchangeable.

The dataset includes labels referencing multiple retailers, campaigns, and membership programs. These values are preserved as supplied.

---

## Analytical Methodology

### Task 1 — Database Setup and Validation

Create the `purchases` table, load the educational dataset, and verify successful data import.

```sql
SELECT COUNT(*) AS total_records
FROM purchases;
```

**Result:** 400 records.

### Task 2 — Overall Sales Metrics

Calculate total sales records, unique order counts, net revenue, and minimum, maximum, and average line-level revenue.

**SQL techniques:** `COUNT`, `DISTINCT`, `SUM`, `MIN`, `MAX`, `AVG`, `ROUND`

**Result:** 397 unique orders and 17,379.35 in recorded net revenue.

### Task 3 — Category Sales Performance

Aggregate records by category, calculate revenue and order counts, filter low-volume groups, and rank categories by revenue.

**SQL techniques:** `GROUP BY`, `HAVING`, `ORDER BY DESC`

A minimum threshold of 10 sales records per category was selected.

### Task 4 — Subcategory and Product Type Analysis

Analyze the highest-revenue category by combining `subcategory` and `product_type` dimensions.

Calculate revenue, order counts, and percentage contribution to category revenue.

**SQL techniques:** Multi-column `GROUP BY`, scalar subquery, `NULLIF`, percentage calculation.

### Task 5 — Customer Purchase and Basket Metrics

Calculate customer-level spending, order frequency, and average basket value.

Order-level revenue is calculated before customer-level aggregation to avoid treating individual transaction lines as complete baskets.

**SQL techniques:** Common table expressions, nested aggregation, `HAVING`.

### Task 6 — Last 60 Days Category Analysis

Analyze the leading category during the period anchored to the latest order date available in the dataset.

**SQL techniques:** `MAX`, SQLite `date()`, `GROUP BY`, `SUM`, `COUNT`.

The analysis uses a dynamic date reference instead of a hard-coded calendar date.

---

## Key Business Findings

### 1. Category Revenue Performance

Categories are ranked by recorded net revenue, including only those with at least 10 sales records.

| Category | Sales Records | Unique Orders | Net Revenue |
|---|---:|---:|---:|
| Bebek ve Çocuk | 57 | 57 | 3,835.18 |
| Ev ve Yaşam | 95 | 94 | 3,831.76 |
| İçecek | 97 | 97 | 3,349.35 |
| Sağlık ve Kişisel Bakım | 65 | 65 | 2,936.13 |
| Atıştırmalık ve Tatlı | 53 | 52 | 2,911.06 |
| Bahçe ve Evcil Hayvan | 10 | 10 | 185.92 |
| Güzellik ve Hijyen | 14 | 14 | 117.90 |

**Commercial Insight:** Baby & Children leads Home & Living by only 3.42 in net revenue, despite having substantially fewer sales records.

Transaction volume alone does not determine revenue leadership.

### 2. Leading Category Revenue Mix

**Leading category:** Bebek ve Çocuk

**Category net revenue:** 3,835.18

| Product Type | Net Revenue | Revenue Share |
|---|---:|---:|
| Yıkanabilir Bebek Bezi | 1,983.37 | 51.72% |
| Boya ve Boyama Seti | 1,725.07 | 44.98% |
| Üç Tekerlekli Bisiklet | 52.55 | 1.37% |
| Yıkanabilir Bebek Külotu | 29.06 | 0.76% |
| Yıkanabilir Havuz Bezi | 26.47 | 0.69% |
| Oyun Hamuru | 16.49 | 0.43% |
| Yıkanabilir Bez Bakımı | 2.17 | 0.06% |

**Commercial Insight:** The two highest-revenue product types account for approximately 96.70% of the category's revenue.

This revenue concentration highlights the importance of monitoring assortment performance and product availability.

Percentages may not sum to exactly 100% because of rounding.

### 3. Repeat Customer Analysis

The analysis identified 11 customers with more than one distinct order.

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

**Commercial Insight:** Customer 47166 generates the highest spending among repeat customers, while customer 115043 has the highest order frequency.

This demonstrates why customer spending and purchase frequency should be evaluated separately.

### 4. Latest 60-Day Category Performance

The analysis dynamically filters Bebek ve Çocuk transactions based on the latest order date in the dataset.

| Subcategory | Sales Records | Unique Orders | Net Revenue |
|---|---:|---:|---:|
| Bebek Bezi ve Bakım | 23 | 23 | 1,945.07 |
| Çocuk Hobi Ürünleri | 22 | 22 | 1,693.85 |
| **Total** | **45** | **45** | **3,638.92** |

**Commercial Insight:** Bebek Bezi ve Bakım accounts for approximately 53.45% of the leading category's revenue in the selected period.

The selected period accounts for approximately 94.88% of the leading category's total recorded revenue.

---

## Executive Dashboard

The project includes a responsive HTML/CSS dashboard published through GitHub Pages.

### Dashboard Components

| Component | Purpose |
|---|---|
| Executive KPI Scorecard | Summarize overall sales performance |
| Category Revenue Chart | Compare revenue contributions across product categories |
| Product Revenue Mix | Highlight revenue concentration within the leading category |
| Repeat Customer Table | Compare customer spending, purchase frequency, and basket value |
| Recent Sales Analysis | Summarize the latest 60-day leading-category performance |
| Management Takeaways | Translate analytical findings into commercial observations |

**[Open the Live Executive Sales Dashboard](https://nagehanbas.github.io/migros-sales-distribution-sql-analytics/dashboard/)**

### Management Takeaways

**Category Management**

Monitor Baby & Children and Home & Living closely because their revenue contributions are nearly identical despite different sales volumes.

**Assortment Analysis**

Investigate the strong concentration of revenue in washable baby diapers and coloring sets. Further margin and stock-availability data would support commercial decision-making.

**Customer Analytics**

Evaluate repeat customers by both frequency and total spending. A more extensive transaction history could support RFM segmentation.

These recommendations are exploratory and should not be treated as validated business interventions.

---

## SQL Techniques Demonstrated

- Database creation and data import
- Source record validation
- Revenue aggregation
- Distinct order counting
- Minimum, maximum, and average calculations
- Category performance ranking
- Aggregate filtering using `HAVING`
- Multi-dimensional grouping
- Percentage calculations using `NULLIF`
- Common table expressions
- Order-level and customer-level aggregation
- Dynamic date filtering
- Commercial KPI reporting

---

## Repository Structure

```text
migros-sales-distribution-sql-analytics/
├── README.md
├── dashboard/
│   └── index.html
└── sql/
    ├── 01_database_setup.sql
    ├── 02_overall_sales_metrics.sql
    ├── 03_category_performance.sql
    ├── 04_subcategory_product_analysis.sql
    ├── 05_customer_basket_analysis.sql
    └── 06_last_60_days_analysis.sql
```

### SQL Files

**01 — Database Setup**

Creates the `purchases` table, inserts the educational dataset, and validates the imported records.

**02 — Overall Sales Metrics**

Calculates sales volume, unique orders, and overall revenue statistics.

**03 — Category Performance**

Ranks category revenue and applies a minimum sales-volume threshold.

**04 — Subcategory and Product Analysis**

Evaluates product-type performance and revenue shares within the leading category.

**05 — Customer Basket Analysis**

Identifies repeat customers and calculates customer spending and average basket values.

**06 — Last 60 Days Analysis**

Examines recent subcategory performance using a dynamic date window.

### Dashboard

**dashboard/index.html**

A self-contained, responsive HTML/CSS executive dashboard presenting selected analytical findings.

---

## How to Reproduce the Analysis

**Requirements:** SQLite 3

Create a fresh SQLite database and execute the scripts in numeric order.

```bash
sqlite3 migros_sales.db < sql/01_database_setup.sql
sqlite3 -header -column migros_sales.db < sql/02_overall_sales_metrics.sql
sqlite3 -header -column migros_sales.db < sql/03_category_performance.sql
sqlite3 -header -column migros_sales.db < sql/04_subcategory_product_analysis.sql
sqlite3 -header -column migros_sales.db < sql/05_customer_basket_analysis.sql
sqlite3 -header -column migros_sales.db < sql/06_last_60_days_analysis.sql
```

Alternatively, run the scripts sequentially in [SQLite Online](https://sqliteonline.com/).

To view the dashboard locally, open `dashboard/index.html` in a web browser.

To view the published dashboard, use the GitHub Pages link above.

---

## Assumptions and Limitations

### Revenue Definition

The project uses `net_price` as recorded line-level net revenue according to the educational task specification.

Although the dataset includes `quantity`, the analysis does not multiply `net_price` by quantity.

Reported totals should therefore not be interpreted as independently verified unit-price-based revenue.

### Sales Records vs. Unique Orders

Sales records are individual rows in the dataset.

Unique orders are identified using `order_id`.

These metrics are reported separately to avoid double-counting orders.

### Basket Value Calculation

Average basket value is calculated after aggregating transaction lines into complete customer orders.

### Category Filtering

Category rankings exclude groups with fewer than 10 sales records.

This is an analyst-defined threshold rather than a company-defined business rule.

### Dynamic Date Window

The latest 60-day analysis is anchored to the maximum order date in the dataset.

It does not represent the latest 60 calendar days relative to the present.

### Dashboard Scope

The dashboard is based on validated SQL query outputs and uses fixed values.

It does not currently support live database queries, automated refreshes, or interactive filters.

### Educational Data

The dataset contains educational retail records referencing multiple companies, campaigns, and membership programs.

The project does not verify these as real commercial relationships.

### Analytical Limitations

The findings are descriptive and are based on a small educational dataset.

They should not be interpreted as statistically significant or causal conclusions about real-world retail operations.

---

## Future Improvements

Potential extensions include:

- Gross margin and profitability analysis
- Promotion effectiveness measurement
- Customer RFM segmentation
- Category contribution and Pareto analysis
- Interactive Power BI reporting
- Monthly revenue trend monitoring
- Automated data quality checks
- Database-connected dashboard refreshes

These are potential extensions and are not included in the current implementation.

---

## Project Information

| Field | Details |
|---|---|
| Project | Migros Sales Distribution — SQL Analytics |
| Program | Workintech — Data Science & AI |
| Database | SQLite 3 |
| Dashboard | HTML5, CSS3, GitHub Pages |
| Domain | Retail and Commercial Analytics |
| Focus Areas | Category Management, Customer Analytics, Sales KPIs, Executive Reporting |
| Project Type | Independent Educational Portfolio Project |

---

**Author:** Nagehan Baş
