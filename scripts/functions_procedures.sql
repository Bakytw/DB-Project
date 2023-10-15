-- -- получение количества товаров на складе по имени товара
-- CREATE FUNCTION get_commodity_balance(product_name VARCHAR(200)) RETURNS INT AS $$
-- DECLARE balance INT;
-- BEGIN
-- SELECT commodity_balance INTO balance
-- FROM mp.warehouse
-- WHERE warehouse_id = (
-- SELECT warehouse_id
-- FROM mp.product
-- WHERE mp.product.product_name = get_commodity_balance.product_name
-- );
-- RETURN balance;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- можем протестировать на выводе из пунта 9.1
-- SELECT * FROM get_commodity_balance('Ноутбук HP');
-- SELECT * FROM get_commodity_balance('Монитор Dell');
-- SELECT * FROM get_commodity_balance('Смартфон Samsung');
-- SELECT * FROM get_commodity_balance('Планшет Apple');
-- SELECT * FROM get_commodity_balance('Кроссовки Nike');
-- SELECT * FROM get_commodity_balance('Куртка The North Face');
-- SELECT * FROM get_commodity_balance('Гитара Yamaha');

call update_product_price(1, 599.99);
DROP PROCEDURE update_product_price;
-- изменение цены товара на заданное значение
CREATE PROCEDURE update_product_price(product_id INTEGER, new_price DECIMAL(10, 2)) LANGUAGE plpgsql AS $$ BEGIN
UPDATE mp.product
SET price = new_price
WHERE prod_id = product_id;
END;
$$;

-- протестируем просто изменя цену товара с идентификатором 1 на 600
SELECT * FROM mp.product;
call update_product_price(1, 600);
SELECT * FROM mp.product;
