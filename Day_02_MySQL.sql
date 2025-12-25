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

/*
	SELECT col1, col2 FROM table_name
    WHERE our_conditions;
    
    ===> where clause is used to define some conditions
*/
-- select every datas where marks > 80 in student table
SELECT * FROM student WHERE marks > 80;

/*
	AND ===> both conditions should be true
    OR ===> any1 of the two condition should be true
    BETWEEN ===> selects for given range
    IN ===> matches any value in the list
    NOT ===> negate given conditions 
*/
-- select every datas where both marks > 80 and city is named mumbai statifies the consdition i.e both must be true 
SELECT * FROM student WHERE city = "mumbai" AND marks > 80;

SELECT * FROM student WHERE marks = 93;
SELECT * FROM student WHERE marks + 10 > 100;

-- select every datas where any1 of two,  marks > 90 or city is named mumbai statifies the condition i.e any1 of the two must be true 
SELECT * FROM student WHERE city = "mumbai" OR marks > 90;
-- select datats where marks are between 80 and 90
SELECT * FROM student WHERE marks BETWEEN 80 AND 90;
-- select datas where city contains any of the elements in the list ("mumbai", "delhi", "gurgaon")
SELECT * FROM student WHERE city IN ("mumbai", "delhi", "gurgaon");

-- gives empty or null datas table as there is no datas where city has  ("Los Angeles", "London")
SELECT * FROM student WHERE city in ("Los Angeles", "London");

-- select the datas where there is not any value from the list ("Mumbai", "Delhi") inside city column
SELECT * FROM student WHERE city NOT IN ("mumbai", "delhi");

/*
	LIMIT CLAUSE
       sets upper-limit on the number of (tuples)rows to be returned
       
       SELECT col1, col2 FROM table_name WHERE our_condtions LIMIT upper_limit_number;
*/
SELECT * FROM student WHERE marks > 75 LIMIT 3;

/*
	ORDER BY Clause
		to sort ascending (ASC) and descending (DESC)
        
        SELECT col1, col2 FROM table_name WHERE our_conditions ORDER BY col_name ASC;
*/
-- sort the order by city column value in ascending order
SELECT * FROM student WHERE marks > 90 ORDER BY city ASC;
-- get top three marks scorer student datas
SELECT * FROM student ORDER BY marks DESC LIMIT 3;

/*
	AGGREGATE FUNCTIONS
		IT performs a calculation on a set of values and returns a single values
        
        COUNT(col_name) ===> returns total number of the values inside a column. it doesnot consider null value rows in total count
        COUNT(*) ===> return total number of rows in a table. it also considers null value rows in total count 
        MAX(col_name) ===> return maximum of numeric value in column
        MIN(col_name) ===> returns minimum of numeric value in column
        SUM(col_name) ===> return sum of all numeric values in column
        AVG(col_name) ===> return average of all numeric value in column 
*/
-- get sum of all marks
SELECT SUM(marks) FROM student where city = "mumbai";

-- get average marks 
SELECT AVG(marks) FROM student;

-- get maximum marks scored
SELECt MAX(marks) FROM student;

-- get total number of city
SELECT COUNT(DISTINCT city) FROM student;

-- get minimum marks scored
SELECT MIN(marks) FROM student;

-- get total rows count in a table
SELECT  COUNT(*) FROM student;

-- count(*) gets total number of rows where grade is "A". It gives same result for count(name) as there is no null value.
SELECT COUNT(*) FROM student WHERE grade = "A";

/*
	GROUP BY Clause
		groups the rows by specific column that have same value into summary rows
        it collects datas from multiple records and groups the result by one or more columns
        
        Generally we use GROUP BY clause with some AGGREGATE functions
*/
-- get the total number of student in each city
SELECT city, COUNT(name) as Total_Student FROM student GROUP BY city;