# SQL Data Analysis Projects

This repository contains SQL scripts that demonstrate database creation, data insertion, and analytical queries on Oracle schemas. The focus is on performing joins, aggregations, filtering, and working with views to analyze structured datasets.

---

## Project 1: HR and Sales Data Analysis (example-queries.sql)

### Overview

- Analyze HR data from `HR.DEPARTMENTS`, `HR.LOCATIONS`, and `HR.EMPLOYEES`.
- Perform sales and order analysis using a demo orders table and SH schema.
- Demonstrates table creation, data insertion, and SQL queries with aggregations and filtering.

### Key Features

1. **Department Employee Counts**  
   - Retrieve departments in specific cities (`Seattle`, `Toronto`, `Oxford`) and count employees.  
   - Uses `JOIN`s, `LEFT JOIN`, `GROUP BY`, and `ORDER BY`.

2. **Orders Demo Table**  
   - Create a sample `orders_demo` table with multiple cities and order amounts.  
   - Aggregate total orders, orders within a specified range, and average order amounts per city.  

3. **Sales Analysis**  
   - Analyze sales by calendar quarter using `SH.SALES` and `SH.TIMES` tables.  
   - Calculate total sales per quarter and filter for quarters exceeding a threshold.

4. **Prospects and Touches**  
   - Create `prospects` and `touches` tables.  
   - Count contacts per prospect and filter based on name length and number of contacts.

---

## Project 2: Recent Hires, Audience, and Product Sales (primaryKey-queries.sql)

### Overview

- Demonstrates creating views, handling duplicate data, and analyzing product sales.
- Includes working with Oracle views, UNION queries, and conditional aggregations.

### Key Features

1. **Recent Hires View**  
   - Create a view `vw_recent_hires` for employees hired within a specific date range.  
   - Aggregate the number of hires per department and preview sample records.

2. **Audience Tables**  
   - Create `east_audience` and `west_audience` tables with overlapping email addresses.  
   - Produce de-duplicated and duplicate-preserving email lists.  
   - Count occurrences of each email and filter for specific ranges.

3. **Product and Sales Analysis**  
   - Create `products` and `sales` tables.  
   - Insert sample data across multiple sales channels (`web`, `store`, `partner`).  
   - Aggregate total orders and count orders with sold prices in a specific range per channel.

---

## Requirements

- **Oracle Database** (or compatible SQL environment)

---

