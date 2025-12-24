CREATE DATABASE IF NOT EXISTS xyz_company;

USE xyz_company;

DROP TABLE IF EXISTS employee;

CREATE TABLE IF NOT EXISTS employee_info
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    salary INT NOT NULL
);

RENAME TABLE employee_info TO employee;

SELECT * FROM employee;

INSERT IGNORE INTO employee
(name, salary)
VALUES
("adam", 25000),
("bob", 30000),
("casey", 40000);

SELECT * FROM employee;