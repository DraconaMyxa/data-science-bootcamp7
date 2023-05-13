--1. สร้าง database restaurant.db 
--2. สร้าง table อย่างน้อย 5 tables
--3. เขียน 3-5 queries มี 1 x WITH, 1 x Subqueries, 1 x Aggregate Functions + JOIN
.shell clear
.open restaurant.db

DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS menus;
DROP TABLE IF EXISTS ingredients;
DROP TABLE IF EXISTS sale_transaction_items;
DROP TABLE IF EXISTS sale_transactions;
DROP TABLE IF EXISTS purchase_transaction_items;
DROP TABLE IF EXISTS purchase_transactions;

  
CREATE TABLE IF NOT EXISTS menus (
	menu_id INT UNIQUE,
  menu_name TEXT,
  menu_price REAL
);

INSERT INTO menus VALUES
(1, 'Burger Pork M', 150),
(2, 'Burger Pork L', 200),
(3, 'Cheese Burger Pork M', 180),
(4, 'Cheese Burger Pork L', 239),
(5, 'Burger Beef M', 249),
(6, 'Burger Beef L', 419),
(7, 'Cheese Burger Beef M', 289),
(8, 'Cheese Burger Beef L', 459),
(9, 'French Fries M', 49),
(10, 'French Fries L', 69),
(11, 'Coke M', 59),
(12, 'Coke L', 99);
----------------------------------------
CREATE TABLE IF NOT EXISTS ingredients (
	ingredient_id INT UNIQUE,
  ingredient_name TEXT,
  ingredient_price REAL,
  ingredient_stock_amount REAL,
  ingredient_unit TEXT
);

INSERT INTO ingredients VALUES
  (1, 'Bread', 5.0, 100, 'ea'),
  (2, 'Onion', 5.0, 50, 'ea'),
  (3, 'Lettuce', 5.0, 50, 'ea'),
  (4, 'Tomato', 4.0, 30, 'ea'),
  (5, 'Potato', 3.0, 45, 'ea'),
  (6, 'Cheese', 9.0, 36, 'ea'),
  (7, 'Oil', 0.075, 1500, 'ml'),
  (8, 'Pork', 0.34, 10000, 'g'),
  (9, 'Beef', 0.89, 10000, 'g'),
  (10, 'Coke', 0.065, 2500, 'ml');
----------------------------------------
CREATE TABLE IF NOT EXISTS recipes (
	menu_id INT,
  ingredient_id INT,
  ingredient_used_amount REAL
);

INSERT INTO recipes VALUES 
  (1, 1, 2),
  (1, 2, 0.2),
  (1, 3, 0.2),
  (1, 4, 0.2),
  (1, 8, 200),
  
  (2, 1, 3),
  (2, 2, 0.2),
  (2, 3, 0.4),
  (2, 4, 0.4),
  (2, 8, 400),
  
  (3, 1, 2),
  (3, 2, 0.2),
  (3, 3, 0.2),
  (3, 4, 0.2),
  (3, 6, 1),
  (3, 8, 200),
  
  (4, 1, 3),
  (4, 2, 0.2),
  (4, 3, 0.4),
  (4, 4, 0.4),
  (4, 6, 2),
  (4, 8, 400),

  (5, 1, 2),
  (5, 2, 0.2),
  (5, 3, 0.2),
  (5, 4, 0.2),
  (5, 9, 200),

  (6, 1, 3),
  (6, 2, 0.2),
  (6, 3, 0.4),
  (6, 4, 0.4),
  (6, 9, 400),

  (7, 1, 2),
  (7, 2, 0.2),
  (7, 3, 0.2),
  (7, 4, 0.2),
  (7, 6, 1),
  (7, 9, 200),

  (8, 1, 3),
  (8, 2, 0.2),
  (8, 3, 0.4),
  (8, 4, 0.4),
  (8, 6, 2),
  (8, 9, 400),

  (9, 5, 1),
  (9, 7, 10),

  (10, 5, 3),
  (10, 7, 30),

  (11, 10, 200),
  (12, 10, 350);

------------------------------------------
CREATE TABLE IF NOT EXISTS purchase_transactions (
  purchase_trans_id INT UNIQUE,
  purchase_trans_date TEXT
);

CREATE TABLE IF NOT EXISTS purchase_transaction_items (
  purchase_trans_id INT,
  ingredient_id INT,
  amount INT,
  current_unit_price REAL
);

INSERT INTO purchase_transactions VALUES (1, '2022-12-28');
INSERT INTO purchase_transaction_items VALUES 
  (1, 1, 100, 5.0),
  (1, 2, 50, 4.5),
  (1, 3, 50, 4.5),
  (1, 4, 30, 4.0),
  (1, 5, 45, 2.5),
  (1, 6, 36, 10.0),
  (1, 7, 1500, 0.075),
  (1, 8, 10000, 0.30),
  (1, 9, 10000, 0.80),
  (1, 10, 2500, 0.065);

----------------------------------------
CREATE TABLE IF NOT EXISTS sale_transactions (
	sale_trans_id INT UNIQUE,
  sale_trans_date TEXT
);

CREATE TABLE IF NOT EXISTS sale_transaction_items (
	sale_trans_id INT,
  menu_id INT,
  amount INT,
  current_unit_price REAL
);

INSERT INTO sale_transactions VALUES
(1, '2022-12-29 12:15:00');
INSERT INTO sale_transaction_items VALUES
(1, 1, 1, 150),
(1, 9, 1, 99),
(1, 11, 2, 59);

INSERT INTO sale_transactions VALUES
(2, '2022-12-30 13:14:00');
INSERT INTO sale_transaction_items VALUES
(2, 6, 2, 300),
(2, 9, 2, 99),
(2, 11, 2, 59);

INSERT INTO sale_transactions VALUES
(3, '2023-01-01 19:15:00');
INSERT INTO sale_transaction_items VALUES
(3, 1, 1, 150),
(3, 9, 1, 99),
(3, 11, 2, 59);

INSERT INTO sale_transactions VALUES
(4, '2023-01-01 20:12:00');
insert INTO sale_transaction_items VALUES
(4, 2, 1, 200),
(4, 7, 1, 239),
(4, 12, 2, 99);

INSERT INTO sale_transactions VALUES
(5, '2023-01-02 12:12:00');
INSERT INTO sale_transaction_items VALUES
(5, 3, 2, 180),
(5, 10, 2, 129),
(5, 11, 2, 59);

INSERT INTO sale_transactions VALUES
(6, '2023-01-02 15:28:00');
INSERT INTO sale_transaction_items VALUES
(6, 6, 1, 300),
(6, 8, 2, 339),
(6, 9, 1, 99),
(6, 10, 2, 129),
(6, 12, 3, 99);

INSERT INTO sale_transactions VALUES
(7, '2023-01-03 13:14:00');
INSERT INTO sale_transaction_items VALUES
(7, 6, 2, 300),
(7, 9, 2, 99),
(7, 11, 2, 59);

INSERT INTO sale_transactions VALUES
(8, '2023-01-21 18:00:00');
INSERT INTO sale_transaction_items VALUES
(8, 7, 1, 239),
(8, 3, 1, 180),
(8, 11, 1, 59),
(8, 12, 1, 99);
-----------------------------------------

.mode column 
.header on

-- 1 --
SELECT 
	menu_name,
  menu_price
FROM menus;

-- 2 --
SELECT
	m.menu_name,
    ROW_NUMBER() OVER(PARTITION BY m.menu_id ORDER BY m.menu_id, i.ingredient_unit) no_of_ingredient ,
    i.ingredient_name,
    r.ingredient_used_amount,
    i.ingredient_unit
from recipes r
LEFT JOIN menus m on r.menu_id = m.menu_id
LEFT JOIN ingredients i ON r.ingredient_id = i.ingredient_id;

-- 3 --
WITH menu_cost AS
(SELECT 
 	m.menu_id,
    SUM(r.ingredient_used_amount * i.ingredient_price) as cost
FROM recipes r
LEFT join menus m on r.menu_id = m.menu_id
LEFT JOIN ingredients i on r.ingredient_id = i.ingredient_id
GROUP By m.menu_id)

SELECT
	m.menu_name,
    mc.cost,
    m.menu_price,
    ROUND(m.menu_price - mc.cost, 2) AS unit_profit
FROM menu_cost mc
JOIN menus m ON mc.menu_id = m.menu_id;

-- 4 --
WITH sale_all AS (
SELECT 
	si.sale_trans_id,
    STRFTIME('%Y-%m-%d',s.sale_trans_date) AS sale_date,
    m.menu_name,
    si.amount,
    si.current_unit_price
FROM sale_transaction_items si
LEFT join sale_transactions s on si.sale_trans_id = s.sale_trans_id
left join menus m on si.menu_id = m.menu_id)

SELECT 
	sale_date,
    SUM(amount * current_unit_price) daily_income
FROM sale_all
GROUP BY sale_date;

-- 5 --
WITH expend AS (
SELECT
	STRFTIME('%Y-%m', p.purchase_trans_date) AS month_id,
	SUM(pi.current_unit_price * pi.amount) AS purchase_total
FROM purchase_transaction_items pi
LEFT JOIN purchase_transactions p 
	ON pi.purchase_trans_id = p.purchase_trans_id
GROUP BY 1
), income AS (
SELECT 
	STRFTIME('%Y-%m', s.sale_trans_date) AS month_id,
    SUM(si.current_unit_price * si.amount) AS sale_total
FROM sale_transaction_items si
LEFT JOIN sale_transactions s
	ON si.sale_trans_id = s.sale_trans_id
GROUP BY 1
), cashflow AS (
SELECT 
	CASE WHEN e.month_id IS NOT NULL THEN e.month_id
  		WHEN i.month_id IS NOT NULL THEN i.month_id
  	ELSE 'no date'
  	END AS month_id,
  	CASE WHEN e.purchase_total IS NOT NULL THEN e.purchase_total
  	ELSE 0 END AS purchase_total,
  	CASE WHEN i.sale_total IS NOT NULL THEN i.sale_total
  	ELSE 0 END AS sale_total
FROM expend e
FULL JOIN income i ON e.month_id = i.month_id
)

SELECT 
	month_id,
    sale_total - purchase_total AS profit
FROM cashflow
