--Query for Question 1

SELECT f.title film_title,
    c.NAME category_name,        
    COUNT(r.rental_id) rental_count
  FROM rental r
  JOIN inventory i
    ON i.inventory_id = r.inventory_id
  JOIN film f
    ON f.film_id = i.film_id
  JOIN film_category fc
    ON fc.film_id = f.film_id
  JOIN category c
    ON c.category_id = fc.category_id
GROUP BY 1,
         2
HAVING c.NAME IN ('Animation', 'Children', 'Classics', 'Comedy',
   'Family', 'Music')
 ORDER BY 2,
          1;