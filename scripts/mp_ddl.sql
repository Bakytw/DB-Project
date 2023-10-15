CREATE SCHEMA IF NOT EXISTS mp;

CREATE TABLE IF NOT EXISTS mp.Warehouse (
    warehouse_id SERIAL PRIMARY KEY,
    commodity_balance INTEGER NOT NULL,
    date_of_last_order TIMESTAMP NOT NULL,
    date_of_upcoming_order TIMESTAMP NOT NULL
);
CREATE TABLE IF NOT EXISTS mp.Product (
    prod_id SERIAL PRIMARY KEY,
    warehouse_id INTEGER REFERENCES mp.Warehouse (warehouse_id),
    product_name VARCHAR(200) NOT NULL,
    category VARCHAR(200) NOT NULL,
    product_description VARCHAR(200) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE IF NOT EXISTS mp.Employee (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(200) NOT NULL,
    employee_role VARCHAR(200) NOT NULL,
    employee_start_date TIMESTAMP NOT NULL
);
CREATE TABLE IF NOT EXISTS mp.Marketplace (
    marketplace_id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES mp.Employee (employee_id),
    marketplace_name VARCHAR(200) NOT NULL
);
CREATE TABLE IF NOT EXISTS mp.Forecast (
    forecast_id SERIAL PRIMARY KEY,
    prod_id INTEGER REFERENCES mp.Product (prod_id),
    forecast_date TIMESTAMP NOT NULL,
    quantity INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS mp.Product_Marketplace (
    product_marketplace_id SERIAL PRIMARY KEY,
    marketplace_id INTEGER REFERENCES mp.Marketplace (marketplace_id),
    prod_id INTEGER REFERENCES mp.Product (prod_id)
);
