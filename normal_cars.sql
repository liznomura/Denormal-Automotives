DROP USER IF EXISTS normal_user;
DROP DATABASE IF EXISTS normal_cars;

CREATE USER normal_user;
CREATE DATABASE normal_cars WITH OWNER normal_user;

\c normal_cars;

DROP TABLE IF EXISTS car_makes CASCADE;
CREATE TABLE car_makes (
  make_id SERIAL NOT NULL PRIMARY KEY,
  make_code VARCHAR(50) NOT NULL,
  make_title VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS car_models CASCADE;
CREATE TABLE car_models (
  model_id SERIAL NOT NULL PRIMARY KEY,
  model_code VARCHAR(50) NOT NULL,
  model_title VARCHAR(100) NOT NULL,
  car_make_code INT REFERENCES car_makes(make_id) NOT NULL
);

DROP TABLE IF EXISTS car_year CASCADE;
CREATE TABLE car_year (
  year_id INT NOT NULL PRIMARY KEY,
  year INT NOT NULL
);

DROP TABLE IF EXISTS model_years CASCADE;
CREATE TABLE model_years (
  car_id SERIAL NOT NULL PRIMARY KEY,
  car_model_key INT REFERENCES car_models(model_id) NOT NULL,
  car_year_key INT REFERENCES car_year(year_id) NOT NULL
);

\i scripts/denormal_data.sql;

INSERT INTO car_makes (make_code, make_title)
SELECT DISTINCT d.make_code, d.make_title
FROM denormal_data d
ORDER BY make_code;

INSERT INTO car_models (model_code, model_title, car_make_code)
SELECT DISTINCT d.model_code, d.model_title, (SELECT m.make_id FROM car_makes m WHERE m.make_code = d.make_code)
FROM denormal_data d
ORDER BY model_code;

INSERT INTO car_year (year_id, year)
SELECT DISTINCT (year % 100), d.year
FROM denormal_data d
ORDER BY year;

INSERT INTO model_years (car_model_key, car_year_key)
SELECT DISTINCT m.model_id, y.year_id
FROM car_models m INNER JOIN denormal_data d ON m.model_title = d.model_title INNER JOIN car_year y ON y.year = d.year
ORDER BY m.model_id;

SELECT DISTINCT make_title
FROM car_makes;
-- 71

SELECT mo.model_title
FROM car_models mo INNER JOIN car_makes ma ON ma.make_id = mo.car_make_code
WHERE make_code = 'VOLKS';
-- 27

SELECT DISTINCT ma.make_code, ma.make_title, mo.model_code, mo.model_title, y.year
FROM car_year y
INNER JOIN model_years my ON y.year_id = my.car_year_key
INNER JOIN car_models mo ON mo.model_id = my.car_model_key
INNER JOIN car_makes ma ON ma.make_id = mo.car_make_code
WHERE ma.make_code = 'LAM';
-- 136

SELECT DISTINCT ma.make_code, ma.make_title, mo.model_code, mo.model_title, y.year
FROM car_year y
INNER JOIN model_years my ON y.year_id = my.car_year_key
INNER JOIN car_models mo ON mo.model_id = my.car_model_key
INNER JOIN car_makes ma ON ma.make_id = mo.car_make_code
WHERE y.year BETWEEN 2010 AND 2015;
-- 7884