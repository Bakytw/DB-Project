-- DROP VIEW Forecast_Summary;
-- сводная информация о продажах продукции по дням
-- CREATE VIEW Forecast_Summary AS
-- SELECT
--   f.forecast_date AS forecast_date,
--   p.product_name AS product_name,
--   SUM(f.quantity) AS total_quantity,
--   SUM(f.quantity * p.price) AS total_sales
-- FROM
--   mp.Forecast f
--   JOIN mp.Product p ON f.prod_id = p.prod_id
-- GROUP BY
--   1, 2;
-- SELECT * FROM forecast_summary;
-- DROP VIEW warehouse_status;
-- информация о текущем статусе склада, включая количество товаров в наличии
-- и даты последнего и будущего заказов
-- CREATE VIEW Warehouse_Status AS
-- SELECT CONCAT(
--         'WH-',
--         SUBSTR(CAST(w.warehouse_id AS CHAR(16)), 1, 5)
--     ) AS warehouse_id_masked,
--     p.product_name AS product_name,
--     p.category,
--     w.commodity_balance,
--     w.date_of_last_order,
--     w.date_of_upcoming_order
-- FROM mp.Warehouse w
--     JOIN mp.Product p ON w.warehouse_id = p.warehouse_id;
-- SELECT *
-- FROM warehouse_status;
-- DROP VIEW Product_Marketplace_Sales;
-- -- информация о продажах продукции на разных маркетплейсах
-- CREATE VIEW Product_Marketplace_Sales AS
-- SELECT CONCAT(
--         'PM-',
--         SUBSTR(CAST(pm.product_marketplace_id AS CHAR(16)), 1, 5)
--     ) AS product_marketplace_id_masked,
--   m.marketplace_name AS marketplace_name,
--   p.product_name AS product_name,
--   SUM(f.quantity) AS total_quantity,
--   SUM(f.quantity * p.price) AS total_sales
-- FROM
--   mp.Product_Marketplace pm
--   JOIN mp.Marketplace m ON pm.marketplace_id = m.marketplace_id
--   JOIN mp.Product p ON pm.prod_id = p.prod_id
--   JOIN mp.Forecast f ON p.prod_id = f.prod_id
-- GROUP BY
--   1, 2, 3;
-- SELECT *
-- FROM Product_Marketplace_Sales;

-- DROP VIEW Marketplace_Employees;
-- -- информация о сотрудниках, работающих на каждом маркетплейсе
-- CREATE VIEW Marketplace_Employees AS
-- SELECT CONCAT(
--         'M-',
--         SUBSTR(CAST(m.marketplace_id AS CHAR(16)), 1, 5)
--     ) AS marketplace_id_masked,
--   m.marketplace_name AS marketplace_name,
--   e.employee_id,
--   e.employee_name AS employee_name,
--   e.employee_role,
--   e.employee_start_date
-- FROM
--   mp.Marketplace m
--   JOIN mp.Employee e ON m.employee_id = e.employee_id;
-- SELECT *
-- FROM Marketplace_Employees;
-- информация о количестве продуктов в каждой категории
-- CREATE VIEW Product_Category_Count AS
-- SELECT
--   p.category,
--   COUNT(*) AS product_count
-- FROM
--   mp.Product p
-- GROUP BY
--   1;
-- SELECT * FROM Product_Category_Count
-- CREATE VIEW product_details AS 
-- SELECT p.prod_id, p.name, p.category, p.description, p.price 
-- FROM Product p;

-- информация о продуктах
CREATE VIEW Product_Details AS
SELECT CONCAT(
        'P-',
        SUBSTR(CAST(p.prod_id AS CHAR(16)), 1, 5)
    ) AS prod_id_masked,
    p.product_name,
    p.category,
    p.product_description,
    p.price
FROM mp.Product p;
SELECT * FROM Product_Details