-- Q1: HR Departments and Employees in Specific Cities
-- Using HR.DEPARTMENTS, HR.LOCATIONS, HR.EMPLOYEES
-- Return all departments from Seattle, Toronto, Oxford along with the number of employees
-- Show department_name, city, emp_count, sorted by emp_count descending
SELECT d.department_name,
       l.city,
       COUNT(e.employee_id) AS emp_count
FROM hr.departments d
JOIN hr.locations l
    ON d.location_id = l.location_id
LEFT JOIN hr.employees e
    ON d.department_id = e.department_id
WHERE l.city IN ('Seattle', 'Toronto', 'Oxford')
GROUP BY d.department_name, l.city
ORDER BY emp_count DESC;

-- Q2: Create orders_demo table
-- Columns: order_id, customer, amount, city, order_dt
-- Insert sample data for cities Charlotte, Raleigh, Durham, Asheville
CREATE TABLE orders_demo (
    order_id   NUMBER PRIMARY KEY,
    customer   VARCHAR2(50),
    amount     NUMBER,
    city       VARCHAR2(30),
    order_dt   DATE
);

-- Insert 10 sample orders
INSERT INTO orders_demo VALUES (1, 'Sree', 200, 'Charlotte', SYSDATE);
INSERT INTO orders_demo VALUES (2, 'Vishnu', 500, 'Durham', SYSDATE);
INSERT INTO orders_demo VALUES (3, 'Prakash', 300, 'Raleigh', SYSDATE);
INSERT INTO orders_demo VALUES (4, 'Uma', 100, 'Asheville', SYSDATE);
INSERT INTO orders_demo VALUES (5, 'Anay', 180, 'Charlotte', SYSDATE);
INSERT INTO orders_demo VALUES (6, 'Avyaan', 450, 'Durham', SYSDATE);
INSERT INTO orders_demo VALUES (7, 'Tommy', 250, 'Raleigh', SYSDATE);
INSERT INTO orders_demo VALUES (8, 'Sarah', 700, 'Charlotte', SYSDATE);
INSERT INTO orders_demo VALUES (9, 'Jack', 175, 'Raleigh', SYSDATE);
INSERT INTO orders_demo VALUES (10, 'Lottie', 350, 'Durham', SYSDATE);

-- Query: For Charlotte, Durham, Raleigh
-- Return total orders, orders with amount between 150-450, and average amount for those orders
-- Show only cities with at least 2 orders in that range
SELECT city,
       COUNT(*) AS total_orders,
       SUM(CASE WHEN amount BETWEEN 150 AND 450 THEN 1 ELSE 0 END) AS orders_in_range,
       ROUND(AVG(CASE WHEN amount BETWEEN 150 AND 450 THEN amount END),2) AS avg_amount
FROM orders_demo
WHERE city IN ('Charlotte','Durham','Raleigh')
GROUP BY city
HAVING SUM(CASE WHEN amount BETWEEN 150 AND 450 THEN 1 ELSE 0 END) >= 2;

-- Q3: Total Sales by Calendar Quarter
-- From SH.SALES and SH.TIMES tables, compute total amount_sold by quarter
-- Filter for years 1999-2000
-- Show only quarters with total_sales > 75,000
SELECT t.calendar_year,
       t.calendar_quarter_desc,
       SUM(s.amount_sold) AS total_sales
FROM sh.sales s
JOIN sh.times t
    ON s.time_id = t.time_id
WHERE t.calendar_year BETWEEN 1999 AND 2000
GROUP BY t.calendar_year, t.calendar_quarter_desc
HAVING SUM(s.amount_sold) > 75000
ORDER BY t.calendar_year, t.calendar_quarter_desc;

-- Q4: Prospects and Touches
-- Create prospects table with id, name
CREATE TABLE prospects (
    id   NUMBER PRIMARY KEY,
    name VARCHAR2(50)
);

-- Create touches table with pid (prospect id) and channel
CREATE TABLE touches (
    pid     NUMBER,
    channel VARCHAR2(30),
    FOREIGN KEY (pid) REFERENCES prospects(id)
);

-- Insert sample data into prospects
INSERT INTO prospects VALUES (1, 'Sree');
INSERT INTO prospects VALUES (2, 'Vishnu');
INSERT INTO prospects VALUES (3, 'Shashidhar');
INSERT INTO prospects VALUES (4, 'Prakash');

-- Insert sample data into touches
INSERT INTO touches VALUES (1, 'Email');
INSERT INTO touches VALUES (1, 'Phone');
INSERT INTO touches VALUES (2, 'Email');
INSERT INTO touches VALUES (3, 'In-person');

-- Query: Return each prospect's name, name length, and number of contacts
-- Filter for names with length 5-8 and at least 1 contact
SELECT p.name,
       LENGTH(p.name) AS name_length,
       COUNT(t.channel) AS num_contacts
FROM prospects p
LEFT JOIN touches t
    ON p.id = t.pid
GROUP BY p.name
HAVING LENGTH(p.name) BETWEEN 5 AND 8
   AND COUNT(t.channel) >= 1;
