-- т.к. prod_id используется в качестве внешнего ключа при связи с таблицей Product
CREATE INDEX "forecast.prod_id"
    ON mp.Forecast
    USING btree
    (prod_id);

-- т.к. может использоваться для поиска товара по имени
CREATE INDEX "product.product_name"
    ON mp.Product
    USING btree
    (product_name);

-- т.к. prod_id и marketplace_id используются в качестве внешних ключей при связи с таблицами Product и Marketplace
CREATE INDEX "product_marketplace.prod_id_marketplace_id"
    ON mp.Product_Marketplace
    USING btree
    (prod_id, marketplace_id);

-- т.к. employee_id используется в качестве внешнего ключа при связи с таблицей Employee
CREATE INDEX "marketplace.employee_id"
    ON mp.Marketplace
    USING btree
    (employee_id);

-- т.к. может использоваться для поиска маркетплейса по имени
CREATE INDEX "marketplace.marketplace_name"
    ON mp.Marketplace
    USING btree
    (marketplace_name);

-- т.к. может использоваться для поиска складов по идентификатору
CREATE INDEX "warehouse.warehouse_id"
    ON mp.Warehouse
    USING btree
    (warehouse_id);

-- т.к. может использоваться для поиска сотрудников по имени
CREATE INDEX "employee.employee_name"
    ON mp.Employee
    USING btree
    (employee_name);

