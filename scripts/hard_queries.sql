-- Получить суммарный баланс товаров (для которых общий баланс больше 100) на складе для каждой категории товаров
INSERT INTO mp.Product (prod_id, warehouse_id, product_name, category, product_description, price)
VALUES
(11, 6, 'Product K', 'Category K', 'Description K', 13.25),
(12, 6, 'Product L', 'Category L', 'Description L', 19.99),
(13, 7, 'Product M', 'Category M', 'Description M', 6.50),
(14, 7, 'Product N', 'Category N', 'Description N', 22.00),
(15, 8, 'Product O', 'Category O', 'Description O', 16.75),
(16, 8, 'Product P', 'Category P', 'Description P', 24.99),
(17, 9, 'Product Q', 'Category Q', 'Description Q', 9.50),
(18, 9, 'Product R', 'Category R', 'Description R', 15.00),
(19, 10, 'Product S', 'Category S', 'Description S', 11.75),
(20, 10, 'Product T', 'Category T', 'Description T', 17.99);

INSERT INTO mp.Warehouse (warehouse_id, commodity_balance, date_of_last_order, date_of_upcoming_order)
VALUES
(11, 190, '2023-03-28 10:00:00', '2023-04-05 10:00:00'),
(12, 130, '2023-03-30 12:00:00', '2023-04-06 12:00:00'),
(13, 280, '2023-03-31 15:00:00', '2023-04-07 15:00:00'),
(14, 150, '2023-03-26 09:00:00', '2023-04-02 09:00:00'),
(15, 210, '2023-03-27 11:00:00', '2023-04-03 11:00:00'),
(16, 240, '2023-03-29 14:00:00', '2023-04-04 14:00:00'),
(17, 260, '2023-03-25 08:00:00', '2023-04-01 08:00:00'),
(18, 200, '2023-03-28 10:00:00', '2023-04-05 10:00:00'),
(19, 170, '2023-03-30 12:00:00', '2023-04-06 12:00:00'),
(20, 320, '2023-03-31 15:00:00', '2023-04-07 15:00:00'),
(21, 190, '2023-03-26 09:00:00', '2023-04-02 09:00:00'),
(22, 250, '2023-03-27 11:00:00', '2023-04-03 11:00:00'),
(23, 180, '2023-03-29 14:00:00', '2023-04-04 14:00:00');

SELECT mp.Product.category,
    SUM(mp.Warehouse.commodity_balance) AS total_balance
FROM mp.Product
    INNER JOIN mp.Warehouse ON mp.Product.prod_id = mp.Warehouse.warehouse_id
GROUP BY mp.Product.category
HAVING SUM(mp.Warehouse.commodity_balance) > 100;

-- Получить список сотрудников отсортированный по возрастанию даты начала работы
INSERT INTO mp.Employee (employee_id, employee_name, employee_role, employee_start_date)
VALUES
(11, 'Daniel Park', 'Sales Associate', '2023-04-05 10:00:00'),
(12, 'Sophia Li', 'Warehouse Associate', '2023-04-06 12:00:00'),
(13, 'William Brown', 'Sales Associate', '2023-04-07 15:00:00'),
(14, 'Ava Davis', 'Warehouse Associate', '2023-04-02 09:00:00'),
(15, 'Mia Wilson', 'Sales Associate', '2021-01-01 00:00:00'),
(16, 'Ethan Johnson', 'Warehouse Associate', '2023-04-03 11:00:00'),
(17, 'Isabella Taylor', 'Sales Associate', '2023-04-05 16:00:00'),
(18, 'James Garcia', 'Warehouse Associate', '2023-04-01 08:00:00'),
(19, 'Sophie Rodriguez', 'Customer Service Representative', '2023-04-04 14:00:00'),
(20, 'Michael Hernandez', 'Sales Associate', '2023-04-03 11:00:00');
SELECT *
FROM mp.Employee
ORDER BY employee_start_date ASC;

-- Получить для каждого товара его категорию и цену, а также ранг товара внутри своей категории по цене
INSERT INTO mp.Product (prod_id, warehouse_id, product_name, category, product_description, price)
VALUES
(21, 6, 'Product K', 'Category K', 'Description K', 12.30),
(22, 6, 'Product L', 'Category L', 'Description L', 10.99),
(23, 7, 'Product M', 'Category M', 'Description M', 23.40),
(24, 7, 'Product N', 'Category N', 'Description N', 22.00),
(25, 8, 'Product O', 'Category O', 'Description O', 430.23),
(26, 8, 'Product P', 'Category P', 'Description P', 25.99),
(27, 9, 'Product Q', 'Category Q', 'Description Q', 23.00),
(28, 9, 'Product R', 'Category R', 'Description R', 15.00),
(29, 10, 'Product S', 'Category S', 'Description S', 23.00),
(30, 10, 'Product T', 'Category T', 'Description T', 17.00);

SELECT mp.Product.product_name, mp.Product.category,
    mp.Product.price,
    RANK() OVER (
        PARTITION BY mp.Product.category
        ORDER BY mp.Product.price DESC
    ) AS price_rank
FROM mp.Product;

-- Выбрать название продукта, категорию, количество товара на складе, а также количество заказов, ожидающих выполнения на складе
SELECT p.product_name,
    p.category,
    w.commodity_balance,
    COUNT(*) OVER (PARTITION BY w.warehouse_id) as orders_pending
FROM mp.Product p
    JOIN mp.Warehouse w ON p.warehouse_id = w.warehouse_id;

-- Выбрать первое и последнее значение цены товара для каждой категории, отсортированные по дате в порядке возрастания
SELECT DISTINCT p.product_name, p.category,
    first_value(p.price) OVER(
        PARTITION BY p.category
        ORDER BY w.date_of_last_order ASC
    ) AS first_price,
    last_value(p.price) OVER(
        PARTITION BY p.category
        ORDER BY w.date_of_last_order ASC
    ) AS last_price
FROM mp.Product p
    JOIN mp.Warehouse w ON p.warehouse_id = w.warehouse_id;

-- Выбрать продукты, которые были проданы на всех маркетплейсах
INSERT INTO mp.Product_Marketplace (product_marketplace_id, marketplace_id, prod_id)
VALUES (11, 1, 1),
    (12, 1, 1),
    (13, 2, 1),
    (14, 3, 1),
    (15, 3, 1),
    (16, 4, 1),
    (17, 4, 1),
    (18, 5, 1),
    (19, 6, 1),
    (20, 7, 1);

SELECT p.product_name
FROM mp.Product p
    JOIN mp.Product_Marketplace pm ON p.prod_id = pm.prod_id
GROUP BY p.product_name
HAVING COUNT(DISTINCT pm.marketplace_id) = (
        SELECT COUNT(DISTINCT pm2.marketplace_id)
        FROM mp.Product_Marketplace pm2
    );
