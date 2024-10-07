--Query for Question 4

WITH t1
  AS (SELECT DATE_TRUNC('day', r.rental_date) AS day,
             COUNT(r.rental_id) rental_count FROM rental r 
        JOIN inventory i
        ON i.inventory_id = r.inventory_id
        JOIN film f
        ON f.film_id = i.film_id
        JOIN film_category fc
        ON fc.film_id = f.film_id
        JOIN category c
        ON c.category_id = fc.category_id WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
       GROUP BY 1
       ORDER BY 1)
SELECT DATE_PART('dow', day) AS day_of_week,
       AVG(rental_count) avg_amt_rentals
  FROM t1
GROUP BY 1
 ORDER BY 1;