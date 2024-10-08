--Query for Question 2

SELECT c.name category_name,
       SUM(f.rental_duration) rental_duration
  FROM film f
  JOIN film_category fc
    ON fc.film_id = f.film_id
  JOIN category c
    ON c.category_id = fc.category_id
 WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
 GROUP BY 1 
 ORDER BY 2 DESC;