USE college;

CREATE TABLE student_info (
	id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT IGNORE INTO student_info
(id, name)
VALUES
(101, "adam"),
(102, "bob"),
(103, "casey");

CREATE TABLE course_info (
	id INT PRIMARY KEY,
    name VARCHAR(50)
);

ALTER TABLE course_info
RENAME COLUMN name TO course;

INSERT IGNORE INTO course_info
(id, course)
VALUES
(102, "english"),
(105, "math"),
(103, "science");

INSERT IGNORE INTO course_info
VALUES
(107, "computer science");

/*
	JOIN 
		Join is used to combine rows from two or more tables, based on a related column between them
        
        There are multiple joins types:
			INNER JOIN ===> 
                gets common records from multiple tables
						SELECT col1, col2 ====> select the columns we want
						FROM table_A ====> from which table
                        INNER JOIN table_B  ====> to which table should inner join be performed
                        ON table_A.col_name = table_B.col_name ====> on what basis condition should we persorm inner join
						
			OUTER JOIN ===>
				There three outer joins:
                
						LEFT JOIN ===> gets all records of left table and matched records from right table
                        
									    SELECT col1, col2
                                        FROM table1 AS a
                                        LEFT JOIN table2 AS b
                                        On a.col_name = b.col_name
                                  
                        RIGHT JOIN ===> gets all records of right table and matched records from left table
										
										SELECT col1, col2
										FROM table1 as a
										RIGHT JOIN table2 AS b
										On a.col_name = b.col_name
                                        
                        FULL ===> gets all records where there is matchin either left or right table
								  we get common datas only once. iT doesnot repeat common datas
									
								        SELECT col1, col2
                                        FROM table1 AS a
									    LEFT JOIN table2 AS b
									    On a.col_name = b.col_name
									    UNION
									    SELECT col1, col2
									    FROM table1 AS a
									    RIGHT JOIN table2 AS b
									    On a.col_name = b.col_name
                                        
			LEFT EXCLUSIVE JOIN
					gets records that are not available to right table
                    i,e gets records of only left table. 
                    It disregard common records between both tables
                    
							SELECT col1, col2
							FROM table1 AS a
							LEFT JOIN table2 AS b
							On a.col_name = b.col_name
                            WHERE b.col_name IS NULL;
					
            RIGHT EXCLUSIVE JOIN
					gets records that are not available to left table
                    i,e gets records of only right table. 
                    It disregard common records between both tables
                    
							SELECT col1, col2
							FROM table1 AS a
							RIGHT JOIN table2 AS b
							On a.col_name = b.col_name
                            WHERE a.col_name IS NULL;
                            
			FULL EXCLUSIVE JOIN
					gets all records of both tables except common records between both records
			
            SELF JOIN
					Its a regular join but the table is joined with itself
                    
                    SELECT col1, col2
                    FROM table1 AS a
                    JOIN table1 AS b
                    ON a.id = b.id;
			
            UNION
				combine all records and give every unique records i.e removes duplicate rows
					- every SELECT must have same number of columns
                    - same column order
                    - same datatypes (or compatible)
                    - Column names in the result come from the first SELECT
                
				    SELECT col1, col2 FROM table1
                    UNION
                    SELECT col1, col2 FROM table2
                    
			UNIQUE ALL
				same as UNION only but it doesnot removes duplicate rows. And gets every records of all tables
					
					SELECT col1, col2 FROM table1
                    UNION ALL
                    SELECT col1, col2 FROM table2
*/
			
-- get all common datas from both student_info and corse_info table
SELECT *
FROM student_info
INNER JOIN course_info
ON student_info.id = course_info.id;

-- LEFT JOIN ==> gets all records of left table and matched records from right table
SELECT *
FROM student_info AS s
LEFT JOIN course_info AS c
ON s.id = c.id;

-- RIGHT JOIN ==> gets all records of right table and matched records from left table
SELECT *
FROM student_info AS s
RIGHT JOIN course_info AS c
ON s.id = c.id;

-- FULL JOIN ==> gets all records where there is matchin either left or right table
SELECT *
FROM student_info AS s
LEFT JOIN course_info AS c
ON s.id = c.id
UNION
SELECT *
FROM student_info AS s
RIGHT JOIN course_info AS c
ON s.id = c.id;

-- LEFT EXCLUSIVE JOIN ===> gets records that are not available to right table
SELECT *
FROM student_info AS s
LEFT JOIN course_info AS c
On s.id = c.id
WHERE c.id IS NULL;

-- RIGHT EXCLUSIVE JOIN ===> gets records that are not available to left table
SELECT *
FROM student_info AS s
RIGHT JOIN course_info AS c
On s.id = c.id
WHERE s.id IS NULL;

-- SELF JOIN ===> it's a regular join but join is performed with itself
SELECT *
FROM student_info AS s1
JOIN student_info AS s2
ON s1.id = s2.id;

SELECT * FROM student_info;
SELECT * FROM course_info;

CREATE TABLE IF NOT EXISTS employeee (
	id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

RENAME TABLE employeee TO employee;

INSERT IGNORE INTO employee
(id, name, manager_id)
VALUES
(101, "adam", 103),
(102, "bob", 104),
(103, "casey", NULL),
(104, "donal", 103);

-- SELF JOIN ===> gets every mangers employee records
SELECT a.name as manger_name, b.name as employee_name
FROM employee as a
JOIN employee as b
ON a.id = b.manager_id;

-- UNION ===> gets all unique records after combining. Removes duplicate records
SELECT id FROM employee
UNION
SELECT manager_id FROM employee;

-- UNION ALL ===> same as UNION only but it doesnot remove duplicate records and gets every records of all tables
SELECT id FROM employee
UNION ALL
SELECT manager_id FROM employee;

-- select all coumn and its data from employee table
SELECT * FROM employee;

/*
	SQL SUB QUERIES
		A SubQuery or NestedQuery or InnerQuery is a query inside another SQL Query
		It involves 2 SELECT statements
        Its generally written inside WHERE clause, FROM and SELECT statements
        
        NOTE: Must return exactly one value (1 row, 1 column)
*/
-- find all the student whose marks is above class average marks
SELECT name, marks, (SELECT AVG(marks) FROM student) AS average_marks 
FROM student
WHERE marks > (SELECT AVG(marks) FROM student);

-- find the names of all students with even roll numbers
SELECT name, rollno
FROM student
WHERE rollno IN 
(SELECT rollno
FROM student
WHERE rollno % 2 = 0);

-- find names of the student with the max marks in delhi
SELECT name
FROM student
WHERE marks IN 
(SELECT max(marks)
FROM student
WHERE city = "delhi");

-- find the max marks from the students in mumbai
SELECT max(marks) AS maximum_marks
FROM (SELECT * FROM student WHERE city = "mumbai") AS temp;

-- find total marks obtained in each city
SELECT sum(marks), city
FROM student
GROUP BY city;

/*
	MYSQL VIEWS
		A View is like a virtual table in SQL
        It does not store data physically
        It stores a query as a virtual table
        You can query it like a regular table
        Provides security (you can give access to a view instead of full table)
				
                CREATE VIEW view_name AS
				SELECT column1, column2, ...
				FROM table_name
				WHERE condition;
                
                DROP VIEW view_name;
                
                SELECT * FROM view_name ===> select columns and it's data from a view
*/
-- creating a view
CREATE VIEW teacher_view_table AS
SELECT rollno, name, marks, grade
FROM student
WHERE marks > 85;

-- select all column and its datas of a VIEW
SELECT * FROM teacher_view_table;