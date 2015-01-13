-- 
-- DROP DB if exists
--
DROP DATABASE IF EXISTS doorman;

--
-- CREATE a DB with name "doorman"
--
CREATE DATABASE doorman;

--
-- USe the DB "doorman"
--
USE doorman;

--
-- DROP the table if it exists - to recreate
--
DROP TABLE IF EXISTS users;

--
-- (Re)CREATE the table
--
CREATE TABLE users (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
uname varchar(100) NOT NULL,
userKey varchar(100) NOT NULL,
type INT NOT NULL,
day INT NOT NULL,
month INT NOT NULL,
year INT NOT NULL
) CHARSET=utf8;
