--Query for Question 3

WITH t1
  AS (SELECT f.title film_title,
             c.name category_name,
             f.rental_duration rental_duration,
             NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile 
        FROM film f
        JOIN film_category fc
          ON fc.film_id = f.film_id
        JOIN category c
          ON c.category_id = fc.category_id WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
       ORDER BY 4)
SELECT category_name,
       COUNT(CASE WHEN standard_quartile = 1 THEN film_title END) AS first_quartile, 
       COUNT(CASE WHEN standard_quartile = 2 THEN film_title END) AS second_quartile,
       COUNT(CASE WHEN standard_quartile = 3 THEN film_title END) AS third_quartile,
       COUNT(CASE WHEN standard_quartile = 4 THEN film_title END) AS fourth_quartile
  FROM t1
 GROUP BY 1
 ORDER BY 1;