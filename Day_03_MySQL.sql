USE college;

SHOW TABLES FROM college;

SELECT * FROM student;

/*
	HAVING Clause
		The HAVING clause is used to filter groups created by GROUP BY.
		Think of it as WHERE for aggregate results.
        WHERE → filters rows before grouping
		HAVING → filters groups after aggregation
        
		HAVING our_contions
*/
-- count number of students in each city where maximum marks crosses 90
SELECT city, COUNT(name) as Students_Count
FROM student
GROUP BY city
HAVING MAX(marks) > 90;

-- select students whose grade = "A" amd group them by city with maximum marks more than 93 ordered in ascending order of city
SELECT city
FROM student
WHERE grade = "A"
GROUP BY city
HAVING max(marks) > 93
ORDER BY city ASC;


/*
	GENERAL ORDER OF QUERY
    
		SELECT col_name
        FROM table_name
        WHERE some_conditions
        GROUP BY col_name ===> same column as SELECT when using group by clause
        HAVING some_conditions
        ORDER BY col_name ASC;
*/

/*
	UPDATE
		to update existing rows
    
		UPDATE table_name
		SET col1 = VAl2, col2 = val2
		WHERE some_conditions
*/

/*
	SAFE MODE
		safe mode is on by default
		it prevent changing data in our databse table
        we can turn it off to to changes
        
        SET SQL_SAFE_UPDATES = 0 or 1; ===> 0 for off and 1 is for on
*/

SET SQL_SAFE_UPDATES = 0;

-- update grade column values of student table where grade = "A" to grade = "0"
UPDATE student
SET grade = "O"
WHERE grade = "A";

SELECT grade FROM student;

-- updating it back to original where grade is A instead of O
UPDATE student
SET grade = "A"
WHERE grade = "O";

-- update marks of student to 82 with roll no 105
UPDATE student
SET marks = 82
WHERE rollno = 105;

-- update grade for student whose marks are btween 80-90
UPDATE student
SET grade = "B"
WHERE marks BETWEEN 80 AND 90;

-- update every students marks by 1
UPDATE student
SET marks = marks + 1;
 
 -- insert a new row data inside exisitng table
INSERT IGNORE INTO student
(rollno, marks, name, city, grade)
VALUES
(107, 12, "john", "London", "F");

/*	
	DELETE
		to delete exisitng rows
        
		DELETE FROM table_name
		WHERE some_conditions
*/
-- delete student whose marks are less than 33
DELETE FROM student
WHERE marks < 33;

SELECT * FROM student;

CREATE TABLE IF NOT EXISTS department (
	id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT IGNORE INTO department
(id, name)
VALUES
(101, "english"),
(102, "IT");

SELECT * FROM department;

CREATE TABLE IF NOT EXISTS teacher (
	id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

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

/*
	Find all constraints and constraints name in a table
		SHOW CREATE TABLE temp2;
        
	To delete constraint
		Step 1: Find constraints_name if required
        Step 2: Drop the constraint
				ALTER TABLE table_name
				DROP FOREIGN KEY constraint_name;
				
				ALTER TABLE table_name
				DROP NOT NULL;
        
	Only FROEIGN KEY, UNIQUE and CHECK constraints need constraints_name to be deleted
*/
-- show all constraints and constraint_name in a table
SHOW CREATE TABLE teacher;

-- delete foreign key
ALTER TABLE teacher
DROP FOREIGN KEY teacher_ibfk_1;

-- add Foreign Key constraint in department_id column of teacher table
ALTER TABLE teacher
ADD CONSTRAINT department_id_foreign_key 
	FOREIGN KEY (department_id)
	REFERENCES department(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;

/*
	CASCADE Foreign Key
    
		ON DELETE CASCADE
					When we create a foreign key with this option, it deletes referencing the rows in child table
                    when the referenced row is deleted in the parent table which has primary key
		ON UPDATE CASCADE
					When we create foreign key with this option, the referencing rows are updated in the child table 
                    when the referenced row is updated in parent table which has primary key 
*/

INSERT IGNORE INTO teacher
(id, name, department_id)
VALUES
(101, "Adam", 101),
(102, "Eve", 102);

/*
	here when we update id from 102 to 103 in department table, it automatically updates teacher table data too
	as we provided ON UPDATE CASCADE on the department_id Foreign Key inside teacher table referencing to id of department table

	when parent reference rows gets modified, child referenced row value also gets modified
*/
UPDATE department
SET id = 103
WHERE id = 102;

SELECT * FROM teacher;

select * from student;

/*
	ALTER
		to change the schema
        
        Add Column
				ALTER TABLE table_name
                ADD COLUMN col1 data_type 
					CONSTRAINT constraint_name constraint_type (col1 or someconditions),
				ADD COLUMN col2 data_type 
					CONSTRAINT constraint_name constraint_type (col2 or someconditions);
                    
				
                ALTER TABLE table_name
                ADD COLUMN col1 data_type constraint,
                ADD COLUMN col2 data_tyoe constraint;
                
		DROP COLUMN
				ALTER TABLE table_name
                DROP COLUMN collumn_name;
                
		RENAME TABLE
				ALTER TABLE table_name
                RENAME TO new_name;
                
		RENAME COLUMN
				ALTER TABLE table_name
				RENAME COLUMN old_column_name TO new_column_name;
                
		CHANGE COLUMN i.e rename, datatype, constraints_type except FOREIGN KEY, PRIMARY KEY, UNIQUE, CHECK
                ALTER TABLE table_name
				CHANGE old_column_name new_column_name new_datatype new_constraint_type;

		MODIFY COLUMN i.e datatype, constraints_type except FOREIGN KEY, PRIMARY KEY, UNIQUE, CHECK
				ALTER TABLE table_name
				MODIFY COLUMN column_name new_datatype new_constraint_type;
*/
-- adding age column to student table
ALTER TABLE student
ADD COLUMN age INT NOT NULL DEFAULT 19;

-- modify column student_age datatype
ALTER TABLE student
MODIFY COLUMN age VARCHAR(50);

-- rename column age and change datatype
ALTER TABLE student
CHANGE age student_age INT;

-- rename the student table to stu
ALTER TABLE student
RENAME TO stu;

-- selecting all datas from table
SELECT * FROM stu;

-- renaming the table back to student
ALTER TABLE stu
RENAME TO student;

-- delete column from student table
ALTER TABLE student
DROP COLUMN student_age;

SELECT * FROM student;

/*
	TRUNCATE
			to delete only datas inside table unlike drop which delete the whole table
			
            TRUNCATE TABLE table_name;
*/

-- truncate datas of table i.e delete only datas inside data not the whole table
TRUNCATE TABLE student;

INSERT IGNORE INTO student
(rollno, name, marks, grade, city)
VALUES
(101, "anil", 78, "C", "Pune"),
(102, "bhunika", 93, "A", "Mumbai"),
(103, "chetan", 85, "B", "Mumbai"),
(104, "dhruv", 96, "A", "Delhi"),
(105, "emanuel", 12, "F", "Delhi"),
(106, "farah", 82, "B", "Delhi");

SELECT * FROM student;