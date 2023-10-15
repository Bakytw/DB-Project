-- создание новой записи в таблице Product
INSERT INTO mp.Product (
        prod_id,
        warehouse_id,
        product_name,
        category,
        product_description,
        price
    )
VALUES (
        11,
        2,
        'Headphones',
        'Audio Equipment',
        'Wireless Headphones',
        99.99
    );

-- получение данных из таблицы mp.Product
SELECT *
FROM mp.Product;

-- изменение данных в таблице mp.Warehouse
UPDATE mp.Warehouse
SET commodity_balance = 150,
    date_of_last_order = '2023-03-31 08:00:00',
    date_of_upcoming_order = '2023-04-07 08:00:00'
WHERE warehouse_id = 1;

-- удаление записи из таблицы mp.Forecast
DELETE FROM mp.Forecast
WHERE forecast_id = 7;

-- получение информации о продукте, его маркетплейсе и сотруднике
SELECT mp.Product.product_name,
    mp.Marketplace.marketplace_name,
    mp.Employee.employee_name
FROM mp.Product
    JOIN mp.Product_Marketplace ON mp.Product.prod_id = mp.Product_Marketplace.prod_id
    JOIN mp.Marketplace ON mp.Product_Marketplace.marketplace_id = Marketplace.marketplace_id
    JOIN mp.Employee ON mp.Marketplace.employee_id = mp.Employee.employee_id;

-- получение информации о количестве проданных товаров
SELECT mp.Product.product_name,
    SUM(mp.Forecast.quantity) AS sold_quantity
FROM mp.Product
    JOIN mp.Forecast ON mp.Product.prod_id = mp.Forecast.prod_id
GROUP BY mp.Product.prod_id;

-- удаление продуктов, которые не находятся ни на одном маркетплейсе
DELETE FROM mp.Product
WHERE prod_id NOT IN (
        SELECT DISTINCT prod_id
        FROM mp.Product_Marketplace
    );
SELECT * FROM mp.product

-- поиск продуктов по категории
SELECT *
FROM mp.Product
WHERE category LIKE '%Бытовая техника%';

-- обновление записей в таблице
UPDATE mp.Product
SET price = 0
WHERE category LIKE '%Бытовая техника%';
SELECT * FROM mp.product

-- обновление записей в таблице на основе условий
UPDATE mp.employee
SET employee_role = CASE
        WHEN employee_start_date < '2022-01-01' THEN CONCAT('Junior ', employee_role)
        WHEN employee_start_date < '2023-01-01' THEN CONCAT('Middle ', employee_role)
        ELSE CONCAT('Senior ', employee_role)
    END;
SELECT * FROM mp.employee
