-- 1. List all customers who live in Texas (use JOINs)
-- Checking data in address table to see what parameter 'Texas' falls under--
SELECT * 
FROM address;
--Texas is a district 

--- Join ---
SELECT customer_id, first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';

--- Answer: Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, and Ian Still live in Texas.



-- 2. Get all payments above $6.99 with the Customer's Full Name
--- Using payment and customer tables --- finding customers that have payments above 6.99
--- connection is through customer_id
SELECT *
FROM payment;
SELECT *
FROM customer;

--- let's find all payments above 6.99
SELECT payment_id, amount
FROM payment
WHERE amount > 6.99
ORDER BY payment_id ASC;

--- will need to do join to show first_name, last_name, and payments above 6.99
SELECT DISTINCT first_name, last_name, payment_id, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY first_name;
--- added distinct to filter out duplicate names
--- still shows duplicate names for each individual amount greater than 6.99

--- Answer: run query


-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

--- without subquery ---
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY customer_id;

--- WHERE IN Subquery ---
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN(
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);

--- Answer: There are 135 people who've made payments over $175



-- 4. List all customers that live in Nepal (use the city table)
-- will need to connect city table with address table with customer table --  Multijoin?
SELECT *
From city
-- WHERE city = 'Nepal';
--- added this WHERE condition after wrting multijoin to check if Nepal exists in city table, it does not

SELECT first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
WHERE city = 'Nepal';

--- Answer: There are no customers that live in Nepal.



-- 5. Which staff member had the most transactions?
--- staff table + rental table 
--- COUNT(rental_id) will display # of rentals or transactions, ORDER BY DESC

--- finding # of rentals and organize it by staff ID
SELECT staff_id, COUNT(rental_id)
FROM rental
GROUP BY staff_id
ORDER BY COUNT(rental_id) DESC;
--- shows that staff 1 has 8040 rental transations and staff 2 has 8004 transactions

--- try INNER JOIN
SELECT first_name, last_name
FROM staff
INNER JOIN rental
ON staff.staff_id = rental.staff_id
ORDER BY COUNT(rental_ID) DESC; --- doesn't work

--- try subquery
SELECT first_name, last_name
FROM staff
WHERE staff_id IN (
    SELECT staff_id
    FROM rental
    GROUP BY staff_id
    ORDER BY COUNT(rental_id) DESC
); --- shows me Mike first then Jon
--- inner query shows staff_id and organizes them in descending order based off the # of rental_ids or transations associated with their name
--- outer query shows the first name and last name of the staff_id from the inner query following that organization

--- want to confirm by looking at names that go with staff ids and & query above
SELECT first_name, last_name, staff_id
FROM staff
GROUP BY staff_id; --- confirmed Mike is staff 1 and Jon is staff 2

--- Answer: Mike is the staff member with the most rentals



-- 6. How many movies of each rating are there?
--- Will use Day 1's HW as the control to check against
SELECT rating, COUNT(DISTINCT film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(DISTINCT film_id) DESC;
--- however, this considers only distinct movies


--- will use inventory table and film table ---
SELECT *
FROM inventory; --- multiple inventory ids associated with same film id
--- columns we want are rating and # of movies


--- Answer: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
--- using payment table + customer table
--- Query payment table to find customers with payments above 6.99
SELECT DISTINCT customer_id, amount
FROM payment
WHERE amount > 6.99
ORDER BY customer_id;
--- shows distinct customer_id for EACH amount greater than 6.99
--- will still show duplicates of customer_id

SELECT DISTINCT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM payment
    WHERE amount > 6.99
)
ORDER BY first_name;

--- Answer: There are 597 distinct customers that have made at least a single payment above 6.99.



-- 8. How many free rentals did our stores give away?
SELECT *
FROM payment
ORDER BY amount;
--- well doesn't look like any payments had amounts lower than 2.00 but let's try showing a table with NO DATA

--- using payment table + rental table
SELECT COUNT(rental_id) as free_rentals
FROM rental
WHERE rental_id IN (
    SELECT rental_id
    FROM payment
    WHERE amount = 0
);
--- inner query shows any rental_id with payment amount = 0 or free
--- outer query shows the count of rental_ids from the rental table using the condition from the innery query

--- Answer: There were 0 free rentals