-- We can use both capital and small lettes for query command

/* 
	-- some_comment ===> for single line comment
    comment comment used for this is used for mutiline comments
*/

-- CREATE DATABASE db_name ===> create database 
CREATE DATABASE IF NOT EXISTS temp1;
create database if not exists college;
-- DROP DATABASE db_name ====> delete specified database 
DROP DATABASE IF EXISTS temp1;
drop database if exists college;

-- DROP DATABASE if exists db_name ===> delete database if it exist
DROP DATABASE if exists startersql;

-- creating startersql database 
CREATE DATABASE IF NOT EXISTS startersql;

/* USE db_name ===> use specific database */
USE startersql;

-- DROP TABLE table_name ===> delete table
DROP TABLE IF EXISTS startersql;

/*
	Creating table with constraint name
		Custom constraint names make it easy to drop or modify constraints later
        We can only give custom constraint name to PRIMARY KEY, FROEIGN KEY, UNIQUE and CHECK
        
			CREATE TABLE teacher (
				teacher_id INT,
				department_id INT,
				salary INT,

				CONSTRAINT pk_teacher PRIMARY KEY (teacher_id),
				CONSTRAINT fk_teacher_department FOREIGN KEY (department_id) REFERENCES department(id) 
					ON DELETE CASCADE
					ON UPDATE CASCADE,
				CONSTRAINT chk_salary_positive CHECK (salary >= 0)
			);
*/

-- CREATE TABLE table_name(table_datas) ===> creating table 
CREATE TABLE IF NOT EXISTS startersql (
id INT AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(100) NOT NULL,
 email VARCHAR(100) UNIQUE NOT NULL,
 gender ENUM('Male', 'Female', 'Other'),
 date_of_birth DATE,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SELECT * from table_name; ===> select all columns from table . * denotes all columns.
SELECT * from startersql;
-- select specific columns
SELECT id, email from startersql;

-- RENAME TABLE current_table_name TO new_table_name ===> rename existing table
RENAME TABLE startersql to customers;
-- renaming again to users table name
RENAME TABLE customers to users;

-- ALTER TABLE table_name ADD COLUMN column_name constraints_for_added_column_datas ===> add new column with constraints inside certain table
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
-- finding all columns after adding new column
SELECT * from users; 

-- ALTER TABLE table_name DROP COLUMN column_name ===> delete specific column inside certain table 
ALTER TABLE users DROP COLUMN is_active;
-- finding all columns after deleting new column
SELECT * from users;

-- Modifying a Column Type
ALTER TABLE users MODIFY COLUMN name VARCHAR(150);
-- finding all columns after modifying column type
SELECT * from users;

-- To move a column (e.g., email ) to the first position. Data type must be mentioned when moving column position
-- Constraints are preserved automatically so, its not necessay to mention constraints when moving column position
ALTER TABLE users MODIFY COLUMN email VARCHAR(100) FIRST;
-- finding all columns after moving a email column to first position
SELECT * from users;

-- To move a column after another column (e.g., move gender after name ):
ALTER TABLE users MODIFY COLUMN email VARCHAR(100) AFTER id;
-- finding all columns after moving a email column after id column
SELECT * from users;

-- creating college database
CREATE DATABASE IF NOT EXISTS college;

-- using college database
USE college; 

-- creating table
CREATE TABLE student (
	rollno INT PRIMARY KEY,
    name VARCHAR(100)
);
 -- selecting all columns from college database
 SELECT * from student;
 
 -- INSERT INTO table_name (col1, col2) VALUES (val1), (val2) ===> inserting values to table columns. order is important col1 must contain val1 and so on
 -- NOTE: If there is AUTO_INCREMENT for any column while creating, we donot need to give values and mention its column when inserting 
 INSERT INTO student
 (rollno, name)
 VALUES
 (101, "max"),
 (102, "john"),
 (103, "lesly");
 
 INSERT INTO student VALUES (104, "miya"); -- ===> IT's done when only single value is to be added to table. It work same as above but we didnt mention the columns. It also works in same order like above
 
 -- selecting from student table
 SELECT * FROM student;
 
 -- SHOW DATABASE ===> show all databases
 SHOW DATABASES;
 
 -- SHOW TABLES ===> show all tables in the current active database i.e last executed database which in this case is college database
 SHOW TABLES;
 
 -- SHOW TABLES FROM db_name ===> show tables from specific database even from the database before the current executed database
SHOW TABLES FROM startersql;
 
-- SHOW TABLES IN db_name ===> show tables from specific database even from the database before the current executed database
 SHOW TABLES IN startersql;
 
/* 
	SELECT table_name
	FROM information_schema.tables
	WHERE table_schema = 'startersql';

===> show tables from specific database even from the database before the current executed database
*/
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'startersql';