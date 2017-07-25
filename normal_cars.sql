-- DROP USER IF EXISTS normal_user;
-- DROP DATABASE IF EXISTS normal_cars;

-- CREATE USER normal_user;
-- CREATE DATABASE normal_cars WITH OWNER normal_user;

-- \c normal_cars;

-- DROP TABLE IF EXISTS car_makes CASCADE;
-- CREATE TABLE car_makes (
--   make_id SERIAL NOT NULL PRIMARY KEY,
--   make_code VARCHAR(50) NOT NULL,
--   make_title VARCHAR(100) NOT NULL
-- );

-- DROP TABLE IF EXISTS car_models CASCADE;
-- CREATE TABLE car_models (
--   model_id SERIAL NOT NULL PRIMARY KEY,
--   model_code VARCHAR(50) NOT NULL,
--   model_title VARCHAR(100) NOT NULL,
--   car_make_code INT REFERENCES car_make(make_id) NOT NULL
-- );

-- DROP TABLE IF EXISTS car_year CASCADE;
-- CREATE TABLE car_year (
--   year_id INT NOT NULL PRIMARY KEY,
--   year INT NOT NULL
-- );

-- DROP TABLE IF EXISTS model_years CASCADE;
-- CREATE TABLE model_years (
--   car_id SERIAL NOT NULL PRIMARY KEY,
--   car_model_key INT REFERENCES car_model(model_id) NOT NULL,
--   car_year_key INT REFERENCES car_year(year_id) NOT NULL
-- );

-- \i scripts/denormal_data.sql;

INSERT INTO car_makes (make_code, make_title)
SELECT DISTINCT make_code, make_title
FROM denormal_data;

