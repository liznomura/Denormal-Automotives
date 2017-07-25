DROP USER IF EXISTS normal_user;
DROP DATABASE IF EXISTS normal_cars;

CREATE USER normal_user;
CREATE DATABASE normal_cars WITH OWNER normal_user;

