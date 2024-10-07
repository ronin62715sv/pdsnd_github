--Query for Question 3

WITH t1
  AS (SELECT f.title film_title,
             c.name category_name,
             f.rental_duration rental_duration,
             NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile FROM film f
        JOIN film_category fc
        ON fc.film_id = f.film_id
        JOIN category c
        ON c.category_id = fc.category_id WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
       ORDER BY 4)
SELECT category_name,
       standard_quartile,
       COUNT(film_title)
  FROM t1
GROUP BY 1,
         2
 ORDER BY 1,
          2;