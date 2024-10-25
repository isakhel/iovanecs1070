SELECT first_name, last_name
FROM customer
WHERE last_name LIKE 'T%'
ORDER BY first_name ASC;

--Question 2
SELECT *
FROM rental
WHERE return_date BETWEEN '2005-05-28' AND '2005-06-01';

--Question 3
SELECT title, COUNT(rental.rental_id)
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY COUNT(rental.rental_id) DESC
LIMIT 10;

--Question 4
SELECT customer.customer_id, SUM(amount)
FROM payment
INNER JOIN customer ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY SUM(amount);

--Question 5
SELECT actor.first_name ||' '|| actor.last_name as actor_name, COUNT(actor.actor_id) as total_movies
from actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.release_year = 2006
GROUP BY actor_name
ORDER BY total_movies DESC
LIMIT 1;

--Question 6
EXPLAIN ANALYZE
SELECT customer.customer_id, SUM(amount)
FROM payment
INNER JOIN customer ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY SUM(amount);
--Sorts results by total spending (sum(payment.amount)), 
--processing 599 rows in 5.969–5.986 ms using quicksort (memory: 48kB).
--HashAggregate: Aggregates total spending per customer,
--grouped by customer.customer_id with a memory usage of 297kB (5.794–5.851 ms).
--Hash Join: Joins payment and customer tables based on customer_id,
--processing 14596 rows (0.132–3.412 ms).
--Sequential Scans:
--Scans the payment table (14596 rows) (0.009–0.881 ms).
--Scans the customer table (599 rows) (0.004–0.057 ms).
--Planning and Execution: Planning took 0.307 ms, with a total execution time of 6.068 ms.

EXPLAIN ANALYZE
SELECT actor.first_name ||' '|| actor.last_name as actor_name, COUNT(actor.actor_id) as total_movies
from actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE film.release_year = 2006
GROUP BY actor_name
ORDER BY total_movies DESC
LIMIT 1;
-- Only 1 result is returned after sorting (actual time: 1.590 ms).
--Actors are sorted by the count of movies they appeared in,
--using top-N heapsort (25kB memory).
--HashAggregate: Aggregates actor names and counts how many movies each appeared 
--in (actual time: 1.571 ms). Hash Join: Joins film_actor and film tables to get
--the list of actors and films released in 2006, using sequential scans 
--on both tables.
--Planning and Execution: The query completed in 1.609 ms.

--Question 7
SELECT category.name as genre, AVG(film.rental_rate)
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY genre;

--Question 8
SELECT category.name as genre, COUNT(rental.rental_id), SUM(payment.amount)
FROM rental
INNER JOIN payment ON rental.rental_id = payment.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY genre
ORDER BY COUNT(rental.rental_id) DESC
LIMIT 5;

--Extra Credit
SELECT to_char(rental.rental_date, 'Month') AS month, category.name AS genre, COUNT(rental.rental_id)
FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY month, genre
ORDER BY month