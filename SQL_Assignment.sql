#! 
CREATE TABLE employees (emp_id INTEGER NOT NULL PRIMARY KEY,emp_name VARCHAR(255) NOT NULL,
age INTEGER CHECK (age >= 18),email VARCHAR(255) UNIQUE,salary DECIMAL DEFAULT 30000);

#2
-- Add a NOT NULL constraint on the name column
ALTER TABLE employees
MODIFY name VARCHAR(255) NOT NULL;  -- Adjust the data type as needed

-- Add a UNIQUE constraint on the email column
ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

-- Add a PRIMARY KEY constraint on the employee_id column
ALTER TABLE employees
ADD CONSTRAINT pk_employee_id PRIMARY KEY (employee_id);

-- Add a FOREIGN KEY constraint on the department_id column
ALTER TABLE employees
ADD CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(department_id);

-- Add a CHECK constraint to ensure age is 18 or older (MySQL 8.0+)
ALTER TABLE employees
ADD CONSTRAINT check_age CHECK (age >= 18);



#3 - The NOT NULL constraint ensures every record in a column has a value, maintaining data integrity and preventing errors.
#answer A primary key cannot have NULL values because it must uniquely identify each record. Allowing NULLs would compromise this uniqueness.

#4-- Add a UNIQUE constraint on the email column
ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

-- Remove the UNIQUE constraint from the email column
ALTER TABLE employees
DROP CONSTRAINT unique_email;


#5
-- Create a sample table for demonstration
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,  -- NOT NULL constraint
    email VARCHAR(255) UNIQUE,    -- UNIQUE constraint
    department_id INT,            -- Foreign key column
    age INT CHECK (age >= 18));   -- CHECK constraint

-- Example of violating NOT NULL constraint
INSERT INTO employees (name, email, department_id, age) 
VALUES (NULL, 'test@example.com', 1, 25);  -- This will cause an error

-- Example of violating UNIQUE constraint
INSERT INTO employees (name, email, department_id, age) 
VALUES ('John Doe', 'test@example.com', 1, 25);  -- Assuming this email already exists

-- Example of violating FOREIGN KEY constraint
INSERT INTO employees (name, email, department_id, age) 
VALUES ('Jane Doe', 'jane@example.com', 999, 30);  -- Assuming department_id 999 does not exist

-- Example of violating CHECK constraint
INSERT INTO employees (name, email, department_id, age) 
VALUES ('Alice', 'alice@example.com', 1, 17);  -- This will cause an error

-- Clean up: Drop the table if needed
DROP TABLE employees;


#6
-- Create the products table without constraints
CREATE TABLE products (product_id INT,product_name VARCHAR(50),price DECIMAL(10, 2));

-- Modify the products table to add a PRIMARY KEY constraint on product_id
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- Modify the products table to set a default value of 50.00 for the price column
ALTER TABLE products
MODIFY price DECIMAL(10, 2) DEFAULT 50.00;  

#7
SELECT Students.student_name, Classes.class_name
 FROM Students
 INNER JOIN Classes ON Students.class_id = Classes.class_id;

#8
 SELECT o.order_id, c.customer_name, p.product_name
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
 LEFT JOIN Products p ON o.order_id = p.order_id;

#9
SELECT p.product_name, SUM(s.amount) AS total_sales FROM Sales s
INNER JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;


#10
 SELECT o.order_id, c.customer_name, SUM(od.quantity) AS total_quantity
 FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
 INNER JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY o.order_id, c.customer_name;


#SQL Commands

#1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
-- To find primary and foreign keys, you need to use the database schema or data dictionary views.
-- Here’s a query for MySQL to find them:
USE mavenmovies;
SELECT TABLE_NAME,     COLUMN_NAME,     CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'maven_movies_db';  


#2- List all details of actors
SELECT * FROM actor;


#3 -List all customer information from DB.
SELECT * FROM Customer;


#4 -List different countries.
SELECT * FROM Country;

#5 -Display all active customers.
SELECT * FROM Customer
WHERE active = 1;



#6 -List of all rental IDs for customer with ID 1.
SELECT rental_id FROM Rental
WHERE customer_id = 1;


#7 - Display all the films whose rental duration is greater than 5 .
SELECT * FROM Film
WHERE rental_duration > 5;


#8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT COUNT(*) AS total_films FROM Film
WHERE replacement_cost > 15 AND replacement_cost < 20;


#9 - Display the count of unique first names of actors.
SELECT COUNT(DISTINCT first_name) AS unique_first_names FROM Actor;


#10- Display the first 10 records from the customer table .
SELECT * FROM Customer LIMIT 10;


#11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT * FROM Customer WHERE first_name LIKE 'B%' LIMIT 3;


#12 -Display the names of the first 5 movies which are rated as ‘G’.
SELECT title FROM Film WHERE rating = 'G' LIMIT 5;


#13-Find all customers whose first name starts with "a".
SELECT * FROM Customer WHERE first_name LIKE 'A%';


#14- Find all customers whose first name ends with "a".
SELECT * FROM Customer WHERE first_name LIKE '%A';


#15- Display the list of first 4 cities which start and end with ‘a’ .
SELECT DISTINCT city FROM City WHERE city LIKE 'A%' AND city LIKE '%A' LIMIT 4;


#16- Find all customers whose first name have "NI" in any position.
SELECT * FROM Customer
WHERE first_name LIKE '%NI%';


#17- Find all customers whose first name have "r" in the second position .
SELECT * FROM Customer
WHERE first_name LIKE '_R%';


#18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * FROM Customer
WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;


#19 nd all customers whose first name starts with "a" and ends with "o".
SELECT * FROM Customer
WHERE first_name LIKE 'A%O';

#20- Get the films with pg and pg-13 rating using IN operator.
SELECT * FROM Film
WHERE rating IN ('PG', 'PG-13');

#21- t the films with length between 50 to 100 using between operator.
SELECT * FROM Film
WHERE length BETWEEN 50 AND 100;

#22- Get the top 50 actors using limit operator.
SELECT * FROM Actor LIMIT 50;


#23- Get Distinct Film IDs from the Inventory Table
SELECT DISTINCT film_id FROM Inventory;


#Functions
#Question 1:Retrieve the total number of rentals made in the Sakila database.Hint: Use the COUNT() function.
SELECT COUNT(*) AS total_rentals FROM rental;


#Question 2:Find the average rental duration (in days) of movies rented from the Sakila database.Hint: Utilize the AVG() function.
SELECT AVG(rental_duration) AS average_rental_duration FROM film;  -- Assuming 'rental_duration' is in the 'film' table



#Question 3:Display the first name and last name of customers in uppercase.Hint: Use the UPPER () function.
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper FROM customer;


#Question 4:Extract the month from the rental date and display it alongside the rental ID.Hint: Employ the MONTH() function.
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;




#Question 5:Retrieve the count of rentals for each customer (display customer ID and the count of rentals).Hint: Use COUNT () in conjunction with GROUP BY.

SELECT customer_id, COUNT(*) AS rental_count FROM rental GROUP BY customer_id;

#Question 6:Find the total revenue generated by each store.Hint: Combine SUM() and GROUP BY.
SELECT store.store_id, SUM(payment.amount) AS total_revenue
FROM store JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

#Question 7:Determine the total number of rentals for each category of movies.Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
SELECT c.name AS category_name, COUNT(r.rental_id) AS rental_count
FROM rental r JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;


#Question 8: Find the average rental rate of movies in each language.Hint: JOIN film and language tables, then use AVG () and GROUP BY.
SELECT l.name AS language_name, AVG(f.rental_rate) AS average_rental_rate 
FROM film f JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;


#Joins
#Questions 9 -Display the title of the movie, customer s first name, and last name who rented it.Hint: Use JOIN between the film, inventory, rental, and customer tables.
SELECT f.title AS movie_title, c.first_name AS customer_first_name, c.last_name AS customer_last_name
FROM rental r JOIN inventory i ON r.inventory_id = i.inventory_id JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;



#Question 10:Retrieve the names of all actors who have appeared in the film "Gone with the Wind."Hint: Use JOIN between the film actor, film, and actor tables.
SELECT a.first_name AS actor_first_name, a.last_name AS actor_last_name FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
WHERE f.title = 'Gone with the Wind';



#Question 11:Retrieve the customer names along with the total amount they've spent on rentals.Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.

SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, SUM(p.amount) AS total_spent
FROM customer c JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;


#Question 12:List the titles of movies rented by each customer in a particular city (e.g., 'London').Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY

SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, f.title AS movie_title
FROM customer c JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.customer_id, f.title;

#Question 13:Display the top 5 rented movies along with the number of times they've been rented.Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
SELECT f.title AS movie_title, COUNT(r.rental_id) AS rental_count
FROM film f JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 5;




#Question 14:Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY
SELECT c.customer_id, c.first_name AS customer_first_name, c.last_name AS customer_last_name
FROM customer c JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;

#Windows Function:

#1. Rank the customers based on the total amount they've spent on rentals.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank
FROM customer c JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;


#2. Calculate the cumulative revenue generated by each film over time.
SELECT f.title AS film_title, r.rental_date, SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM film f JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id;


#3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT f.title AS film_title, f.length, AVG(f.rental_duration) OVER (PARTITION BY f.length) AS average_rental_duration
FROM film f;


#4. Identify the top 3 films in each category based on their rental counts.
SELECT c.name AS category_name, f.title AS film_title, COUNT(r.rental_id) AS rental_count,
RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
FROM film f JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, f.film_id
HAVING rank_in_category <= 3;

#5 Calculate the difference in rental counts between each customer's total rentals and the average rentals

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals,
AVG(COUNT(r.rental_id)) OVER () AS average_rentals_across_customers,
COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER () AS rental_difference
FROM customer c JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;


#6. Find the monthly revenue trend for the entire rental store over time.
SELECT DATE_FORMAT(p.payment_date, '%Y-%m') AS month, SUM(p.amount) AS monthly_revenue,
SUM(SUM(p.amount)) OVER (ORDER BY DATE_FORMAT(p.payment_date, '%Y-%m')) AS cumulative_revenue
FROM payment p
GROUP BY month
ORDER BY month;


#7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
SELECT customer_id, first_name, last_name, total_spent
FROM (SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
           NTILE(5) OVER (ORDER BY SUM(p.amount) DESC) AS spending_percentile
    FROM customer c JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id) AS spending_data
WHERE spending_percentile = 1;


#8. Calculate the running total of rentals per category, ordered by rental count.
SELECT c.name AS category_name, f.title AS film_title, COUNT(r.rental_id) AS rental_count,
SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS running_total
FROM film f JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, f.film_id;


#9. Find the films that have been rented less than the average rental count for their respective categories.
SELECT f.title AS film_title, c.name AS category_name, COUNT(r.rental_id) AS rental_count,
AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id) AS category_avg_rentals
FROM film f JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, c.category_id
HAVING COUNT(r.rental_id) < category_avg_rentals;

#10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
SELECT month, monthly_revenue
FROM (SELECT DATE_FORMAT(p.payment_date, '%Y-%m') AS month, SUM(p.amount) AS monthly_revenue,
RANK() OVER (ORDER BY SUM(p.amount) DESC) AS revenue_rank FROM payment p
GROUP BY month) AS ranked_months
WHERE revenue_rank <= 5;


#Normalisation & CTE

#1.a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
-- Question 1: First Normal Form (1NF)
-- Identify a table in Sakila that violates 1NF, such as the `address` table 
-- if it stores multiple phone numbers in a single row. To achieve 1NF:
-- Solution: Create a new table `phone` to store multiple phone numbers separately.

CREATE TABLE phone (phone_id INT AUTO_INCREMENT PRIMARY KEY,address_id INT,phone_number VARCHAR(15),
    FOREIGN KEY (address_id) REFERENCES address(address_id));


#2. a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.

-- Question 2: Second Normal Form (2NF)
-- Choose a table, for example, `film_actor`, and check for partial dependencies. 
-- If it violates 2NF, we need to separate non-key attributes into a new table.

-- Step 1: Create a new table to remove partial dependencies.
CREATE TABLE actor_details (actor_id INT PRIMARY KEY,
    other_attributes VARCHAR(255));

-- Step 2: Update `film_actor` to link to `actor_details`.
ALTER TABLE film_actor ADD FOREIGN KEY (actor_id) REFERENCES actor_details(actor_id);




#3. : a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 

-- Question 3: Third Normal Form (3NF)
-- Identify a table, such as `film`, that violates 3NF due to transitive dependencies.
-- Solution: Create a `language` table to eliminate transitive dependency.

-- Step 1: Create the new `language` table.
CREATE TABLE language (language_id INT PRIMARY KEY,language_name VARCHAR(50));

-- Step 2: Remove `language_name` from `film` and link it to `language`.
ALTER TABLE film DROP COLUMN language_name;
ALTER TABLE film ADD FOREIGN KEY (language_id) REFERENCES language(language_id);





#4. a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
-- Question 4: Normalization Process
-- Assume an unnormalized table called `orders`. We will normalize it from unnormalized 
-- form to at least 2NF.

-- Step 1: Ensure atomic values for each attribute to achieve 1NF.

-- Step 2: Remove partial dependencies to achieve 2NF by separating repeating groups into a new table `order_items`.

CREATE TABLE order_items (item_id INT PRIMARY KEY,order_id INT,product_name VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id));


#5.  a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they  have acted in from the actor and film_actor tables.
WITH actor_films AS (SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS film_count
    FROM actor JOIN film_actor ON actor.actor_id = film_actor.actor_id
    GROUP BY actor.actor_id)
SELECT first_name, last_name, film_count FROM actor_films;



#6a. Create a CTE that combines information from the film and language tables to display the film title,  language name, and rental rate.
WITH film_language AS (SELECT film.title, language.name AS language_name, film.rental_rate FROM film
    JOIN language ON film.language_id = language.language_id)
SELECT * FROM film_language;


#7 a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)  from the customer and payment tables.
WITH customer_revenue AS (SELECT customer.customer_id, SUM(payment.amount) AS total_revenue
    FROM customer
    JOIN payment ON customer.customer_id = payment.customer_id
    GROUP BY customer.customer_id)
SELECT customer_id, total_revenue FROM customer_revenue;


#8 a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

WITH film_rank AS (SELECT title, rental_duration,
    RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank FROM film)
SELECT * FROM film_rank;

 #9. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.
 WITH frequent_customers AS (SELECT customer_id, COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING rental_count > 2)
SELECT customer.* FROM customer
JOIN frequent_customers ON customer.customer_id = frequent_customers.customer_id;

 
 #10 a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table
WITH monthly_rentals AS (SELECT DATE_FORMAT(rental_date, '%Y-%m') AS rental_month, COUNT(*) AS total_rentals FROM rental
    GROUP BY rental_month)
SELECT * FROM monthly_rentals;


 #11a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film  together, using the film_actor table.

WITH actor_pairs AS (SELECT a1.actor_id AS actor1, a2.actor_id AS actor2, fa1.film_id
    FROM film_actor fa1 JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    JOIN actor a1 ON fa1.actor_id = a1.actor_id
    JOIN actor a2 ON fa2.actor_id = a2.actor_id
    WHERE fa1.actor_id < fa2.actor_id)
SELECT * FROM actor_pairs;


#12.  Implement a recursive CTE to find all employees in the staff table who report to a specific manager,  considering the reports_to column
WITH RECURSIVE staff_hierarchy AS (SELECT staff_id, first_name, last_name, reports_to FROM staff
    WHERE staff_id = 1 
    UNION ALL
    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s INNER JOIN staff_hierarchy sh ON s.reports_to = sh.staff_id)
SELECT * FROM staff_hierarchy;

