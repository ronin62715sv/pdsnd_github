{\rtf1\ansi\ansicpg1252\cocoartf2761
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 HelveticaNeue;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \

\f1\fs26 --Query for Question 1\
\
SELECT f.title film_title,\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx4458\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0        c.NAME category_name,\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0
\cf0        COUNT(r.rental_id) rental_count\
  FROM rental r\
  JOIN inventory i\
    ON i.inventory_id = r.inventory_id\
  JOIN film f\
    ON f.film_id = i.film_id\
  JOIN film_category fc\
    ON fc.film_id = f.film_id\
  JOIN category c\
    ON c.category_id = fc.category_id\
GROUP BY 1,\
         2\
HAVING c.NAME IN ('Animation', 'Children', 'Classics', 'Comedy',\
   'Family', 'Music')\
 ORDER BY 2,\
          1;\
\
\
\
\pard\pardeftab560\slleading20\pardirnatural\partightenfactor0
\cf0 --Query for Question 2\
\
SELECT f.title film_title,\
       c.name category_name,\
       f.rental_duration rental_duration,\
       NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile\
  FROM film f\
  JOIN film_category fc\
    ON fc.film_id = f.film_id\
  JOIN category c\
    ON c.category_id = fc.category_id\
 WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music');\
\
\
\
--Query for Question 3\
\
WITH t1\
  AS (SELECT f.title film_title,\
             c.name category_name,\
             f.rental_duration rental_duration,\
             NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile FROM film f\
        JOIN film_category fc\
        ON fc.film_id = f.film_id\
        JOIN category c\
        ON c.category_id = fc.category_id WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')\
       ORDER BY 4)\
SELECT category_name,\
       standard_quartile,\
       COUNT(film_title)\
  FROM t1\
GROUP BY 1,\
         2\
 ORDER BY 1,\
          2\
\
\
\
--Question 4\
\
WITH t1\
  AS (SELECT DATE_TRUNC('day', r.rental_date) AS day,\
             COUNT(r.rental_id) rental_count FROM rental r\
        JOIN inventory i\
        ON i.inventory_id = r.inventory_id\
        JOIN film f\
        ON f.film_id = i.film_id\
        JOIN film_category fc\
        ON fc.film_id = f.film_id\
        JOIN category c\
        ON c.category_id = fc.category_id WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')\
       GROUP BY 1\
       ORDER BY 1)\
SELECT DATE_PART('dow', day) AS day_of_week,\
       AVG(rental_count) avg_amt_rentals\
  FROM t1\
GROUP BY 1\
 ORDER BY 1;}