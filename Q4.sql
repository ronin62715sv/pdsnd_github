--Query for Question 4

WITH t1
  AS (SELECT DATE_TRUNC('day', r.rental_date) AS day,
             COUNT(r.rental_id) rental_count 
        FROM rental r 
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
SELECT CASE DATE_PART('dow', day) 
       WHEN 0 THEN 'Sunday'
       WHEN 1 THEN 'Monday'
       WHEN 2 THEN 'Tuesday'
       WHEN 3 THEN 'Wednesday'
       WHEN 4 THEN 'Thursday'
       WHEN 5 THEN 'Friday'
       WHEN 6 THEN 'Saturday' 
        END AS day_of_week,
       AVG(rental_count) AS avg_amt_rentals
  FROM t1
 GROUP BY 1
 ORDER BY 1;