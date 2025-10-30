-- Create a view of recent hires between 2006 and 2007
-- The view will store employee details for hires in the specified date range
CREATE OR REPLACE VIEW vw_recent_hires AS
SELECT employee_id, first_name, last_name, department_id, hire_date
FROM HR.EMPLOYEES
WHERE hire_date BETWEEN DATE '2006-01-01' AND DATE '2007-12-31';

-- Count the number of hires per department from the recent hires view
SELECT department_id, COUNT(*) AS hire_count
FROM vw_recent_hires
GROUP BY department_id
ORDER BY hire_count DESC;

-- Preview the first 10 rows of the recent hires view
SELECT *
FROM vw_recent_hires
FETCH FIRST 10 ROWS ONLY;

-- Create east_audience and west_audience tables
-- Insert sample emails, including duplicates and overlaps
CREATE TABLE east_audience (
    email VARCHAR2(100)
);

CREATE TABLE west_audience (
    email VARCHAR2(100)
);

-- Insert sample emails into east_audience
INSERT INTO east_audience VALUES ('a@gmail.com');
INSERT INTO east_audience VALUES ('b@gmail.com');
INSERT INTO east_audience VALUES ('c@gmail.com');
INSERT INTO east_audience VALUES ('a@gmail.com'); -- duplicate

-- Insert sample emails into west_audience
INSERT INTO west_audience VALUES ('x@gmail.com');
INSERT INTO west_audience VALUES ('y@gmail.com');
INSERT INTO west_audience VALUES ('z@gmail.com');
INSERT INTO west_audience VALUES ('x@gmail.com'); -- duplicate

-- a) Produce a de-duplicated list of all emails from both audiences
SELECT DISTINCT email
FROM (
    SELECT email FROM east_audience
    UNION ALL
    SELECT email FROM west_audience
);

-- b) Produce a list preserving duplicates
SELECT email
FROM (
    SELECT email FROM east_audience
    UNION ALL
    SELECT email FROM west_audience
);

-- c) Count occurrences of each email and show only emails appearing 2 or 3 times
SELECT email, COUNT(*) AS occurrences
FROM (
    SELECT email FROM east_audience
    UNION ALL
    SELECT email FROM west_audience
)
GROUP BY email
HAVING COUNT(*) IN (2, 3);

-- Create products and sales tables to track sales across channels
CREATE TABLE products (
    pid INT PRIMARY KEY,
    pname VARCHAR2(100),
    base_price NUMBER
);

CREATE TABLE sales (
    sid INT PRIMARY KEY,
    pid INT,
    channel VARCHAR2(20),
    sold_price NUMBER,
    FOREIGN KEY (pid) REFERENCES products(pid)
);

-- Insert sample products
INSERT INTO products VALUES (1, 'Laptop', 800);
INSERT INTO products VALUES (2, 'Phone', 500);
INSERT INTO products VALUES (3, 'Tablet', 300);

-- Insert sample sales across channels {web, store, partner}
INSERT INTO sales VALUES (101, 1, 'web', 750);
INSERT INTO sales VALUES (102, 2, 'store', 450);
INSERT INTO sales VALUES (103, 3, 'partner', 250);
INSERT INTO sales VALUES (104, 2, 'web', 600);
INSERT INTO sales VALUES (105, 3, 'store', 320);
INSERT INTO sales VALUES (106, 1, 'partner', 400);

-- Query per channel:
-- 1. Total orders
-- 2. Number of orders with sold_price between 200 and 500
-- Sorted by orders_in_range descending
SELECT channel,
       COUNT(*) AS total_orders,
       SUM(CASE WHEN sold_price BETWEEN 200 AND 500 THEN 1 ELSE 0 END) AS orders_in_range
FROM sales
GROUP BY channel
ORDER BY orders_in_range DESC;
