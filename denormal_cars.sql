DROP USER IF EXISTS denormal_user;
DROP DATABASE IF EXISTS denormal_cars;

CREATE USER denormal_user;

CREATE DATABASE denormal_cars WITH OWNER denormal_user;

\c denormal_cars;

\i scripts/denormal_data.sql;

