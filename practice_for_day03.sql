USE college;

-- change the name of column from name to full_name
ALTER TABLE student
RENAME COLUMN name TO full_name;

SET sql_safe_updates = 0;

-- delete all the students who scored marks less than 80
DELETE FROM student 
WHERE marks < 80;

-- delete the columns for grade
ALTER TABLE student
DROP COLUMN grade;

-- delete all the datas inside student table
TRUNCATE TABLE student;

-- add grade column inside student table
ALTER TABLE student
ADD COLUMN grade VARCHAR(2); 

-- rename the full_name back to name
ALTER TABLE student
RENAME COLUMN full_name TO name;

-- move grade column btween marks and city columns
ALTER TABLE student
MODIFY COLUMN grade VARCHAR(2) AFTER marks;

-- get all datas inside table
SELECT * FROM student;