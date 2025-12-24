CREATE DATABASE IF NOT EXISTS college;

USE college;

CREATE TABLE IF NOT EXISTS temp1 (
	id INT PRIMARY KEY
);

INSERT IGNORE INTO temp1 VALUES (101);
INSERT IGNORE INTO temp1 VALUES (101);

-- delete primary key constraint from the whole table
ALTER TABLE temp1 DROP PRIMARY KEY;

-- add new column and constraint to the column into temp1 table
ALTER TABLE temp1
ADD COLUMN name VARCHAR(50),
ADD COLUMN age INT,
ADD COLUMN cityid INT,
ADD COLUMN city VARCHAR(50),
ADD PRIMARY KEY (id,name),
ADD UNIQUE (cityid);

-- add unique constraint to id column of temp1 table
ALTER TABLE temp1 
ADD UNIQUE (id);

/*
  FOREIGN KEY
     Foreign keys do not auto-populate target columns.
     You can only insert values in temp2.id that exist in temp1.cityid
     It does not enforce uniqueness in the child table unless you explicitly add a UNIQUE or PRIMARY KEY constraint.
	 Here temp1 is parent table and temp2 is child table. temp2.id can have duplicate values.
*/
CREATE TABLE IF NOT EXISTS temp2 (
id INT,
FOREIGN KEY (id) REFERENCES temp1(cityid)
);

-- updates the existing row
UPDATE temp1
SET 
    name = 'Adam',
    age = 20,
    cityid = 100,
    city = 'Kathmandu'
WHERE id = 101;

INSERT IGNORE INTO temp1 
(id, name, age, cityid, city)
VALUES 
(102, 'Bob', 22, 101, 'Pokhara');

-- Populate temp2 from temp1 automatically
INSERT IGNORE INTO temp2 (id)
SELECT cityid from temp1;

SELECT * FROM temp1;
SELECT * FROM temp2;

-- creating emp table and puting salary value to be 25000 by default if not specified 
CREATE TABLE IF NOT EXISTS emp(
	id INT,
    salary INT DEFAULT 25000
);

-- insert value to id only without specifying salary value. Due not specifying salary value, salary value will be 25000 by default
INSERT IGNORE INTO emp (id) VALUES (100);

-- insert value to id and salary. we specify salary value to be inserted
INSERT IGNORE INTO emp
(id, salary)
VALUES
(101, 50000),
(102, 70000);

SELECT * FROM emp;

-- show all tables inside college database 
SHOW TABLES FROM college;

CREATE TABLE IF NOT EXISTS student (
	rollno INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT NOT NULL,
    grade VARCHAR(1),
    city VARCHAR(20)
);

INSERT IGNORE INTO student
(rollno, name, marks, grade, city)
VALUES
(101, "anil", 78, "C", "Pune"),
(102, "bhunika", 93, "A", "Mumbai"),
(103, "chetan", 85, "B", "Mumbai"),
(104, "dhruv", 96, "A", "Delhi"),
(105, "emanuel", 12, "F", "Delhi"),
(106, "farah", 82, "B", "Delhi");

-- select all columns and its data from table
SELECT * FROM student;

-- select specific columns and its data from table
SELECT name, marks FROM student;

-- DISTINCT ===> it selects unique data from the columns. Duplicate v (if any) would appear only once
SELECT DISTINCT city FROM student; -- gets unique values of city column showing duplicate value only one time
SELECT DISTINCT name, grade FROM student; -- gets unique combination pairs value of name and grade column combination
