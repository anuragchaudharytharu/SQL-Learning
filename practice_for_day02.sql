USE college;

-- get avg marks in each city in ascending order
SELECT city, AVG(marks)
FROM student
GROUP BY city
ORDER BY avg(marks) ASC;
-- You are aggregating marks using AVG(marks). After aggregation, there is no column named marks in the result.
-- average_marks is just a custom name for the column

-- we can also do it like this
 SELECT city, avg(marks) AS average_marks
 FROM student
 GROUP BY city
 ORDER BY average_marks ASC;
 
 -- creating bank databse
 CREATE DATABASE IF NOT EXISTS bank;
 -- using bank database
 USE bank;
 
 CREATE TABLE payment (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer VARCHAR(50),
    payment_mode VARCHAR(50),
    city VARCHAR(50)
 );
 
 INSERT IGNORE INTO payment 
 (customer, payment_mode, city)
 VALUES
 ("Olivia Barret", "NetBanking","Portland"),
 ("Ehan Sinclair", "Credit Card", "Miami"),
 ("Maya Hernandez", "Credit Card", "Seattle"),
 ("Liam Donovan", "NetBanking", "Denver"),
 ("Sophia Nguyen", "Credit Card", "New Orleans"),
 ("Caleb Foster", "Debit Card", "Minneapolis"),
 ("Ava Patel", "Debit Card", "Phoenix"),
 ("Lucas Carter", "NetBanking", "Boston"),
 ("Isabella Martinez", "Netbanking", "Nashville"),
 ("Jackson Brooks", "Credit Card", "Boston");
 
 -- get total payment according to each payment method
 SELECT payment_mode, COUNT(customer)
 FROM payment
 GROUP BY payment_mode;