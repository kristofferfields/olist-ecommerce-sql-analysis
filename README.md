# olist-ecommerce-sql-a# Olist E-Commerce SQL Analysis

## Overview

This project analyzes the Olist Brazilian E-Commerce dataset using PostgreSQL.

The goal was to answer practical business questions related to revenue, customer behavior, product performance, seller activity, delivery performance, and payment behavior using SQL.

The dataset contains roughly 100,000 historical marketplace orders from 2016 to 2018.

## Tools Used

- PostgreSQL
- pgAdmin
- SQL
- Olist Brazilian E-Commerce Dataset

## Business Questions

This project explores questions such as:

- How much product revenue did the marketplace generate?
- How did revenue and order volume change over time?
- What was the average order value?
- Which product categories generated the most revenue?
- Which states generated the most revenue?
- How many customers made repeat purchases?
- Which sellers generated the most revenue?
- How concentrated was seller revenue?
- How long did deliveries take?
- How often were orders delivered late?
- Did late deliveries receive lower review scores?
- Which payment methods were most common?
- How frequently were installment payments used?

## Key Findings

- Total product revenue was approximately $13.59 million.
- November 2017 generated the highest monthly product revenue at approximately $1.01 million.
- November 2017 also had the highest monthly order volume with 7,451 orders.
- Average order value was approximately $137.75.
- São Paulo generated approximately $5.20 million in product revenue, representing about 38% of total product revenue.
- Health & Beauty was the highest-revenue product category at approximately $1.26 million.
- The marketplace had 96,096 unique customers.
- Only 3.12% of customers made more than one purchase.
- The highest-revenue seller generated approximately $229,473 in product revenue.
- The top 10 sellers generated 13.15% of total product revenue.
- The top 25 sellers generated 23.57% of total product revenue.
- Average delivery time was 12.56 days.
- Approximately 8.11% of delivered orders arrived after the estimated delivery date.
- On-time deliveries received an average review score of 4.29 compared with 2.57 for late deliveries.
- Credit cards accounted for 73.92% of payment records.
- Nearly half of payment records, 49.42%, used more than one installment.

## SQL Skills Demonstrated

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- COUNT
- SUM
- AVG
- DISTINCT
- JOIN
- CASE WHEN
- Common Table Expressions (CTEs)
- Subqueries
- Date functions
- Window functions
- LAG()
- ROW_NUMBER()
- Ranking
- Business KPI development

## Project Files

- `olist_ecommerce_analysis.sql` — SQL used for the analysis
- `Olist_SQL_Portfolio_Project_Kristoffer_Fields_FINAL.pdf` — full portfolio report

## Dataset

Brazilian E-Commerce Public Dataset by Olist.

The dataset contains anonymized marketplace data including customers, orders, products, sellers, payments, reviews, and order items.

## Author

Kristoffer Fieldsnalysis
SQL business analysis of the Olist Brazilian E-Commerce dataset using PostgreSQL.
