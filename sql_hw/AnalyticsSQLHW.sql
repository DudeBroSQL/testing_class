
SELECT 
    first_name, last_name
FROM
    sakila.actor;
SELECT 
    CONCAT_WS(' ', UPPER(first_name), UPPER(last_name)) AS 'Actor Name'
FROM
    sakila.actor;
SELECT 
    actor_id, first_name, last_name
FROM
    sakila.actor
WHERE
    first_name = 'joe';
SELECT 
    actor_id, first_name, last_name
FROM
    sakila.actor
WHERE
    last_name LIKE '%gen%';
SELECT 
    actor_id, first_name, last_name
FROM
    sakila.actor
WHERE
    last_name LIKE '%li%'
ORDER BY last_name , first_name;
SELECT 
    country_id, country
FROM
    sakila.country
WHERE
    country IN ('Afghanistan' , 'Bangladesh', 'China');
alter table sakila.actor add description blob null;
alter table sakila.actor drop description ;
SELECT 
    COUNT(*), last_name
FROM
    sakila.actor
GROUP BY last_name;
SELECT 
    COUNT(*), last_name
FROM
    sakila.actor
GROUP BY last_name
HAVING COUNT(*) > 1;
UPDATE sakila.actor 
SET 
    first_name = 'HARPO'
WHERE
    last_name = 'williams'
        AND first_name = 'GROUCHO';
UPDATE sakila.actor 
SET 
    first_name = 'GROUCHO'
WHERE
    last_name = 'williams'
        AND first_name = 'HARPO';
SHOW CREATE TABLE sakila.address;
SELECT 
    addy.address, st.*
FROM
    sakila.address addy
        JOIN
    sakila.staff st ON addy.address_id = st.address_id;

SELECT 
    SUM(amount) AS total, st.staff_id
FROM
    sakila.staff st
        LEFT JOIN
    sakila.payment pay ON st.staff_id = pay.staff_id
GROUP BY ST.staff_id;

SELECT 
    COUNT(*) AS total, F.FILM_ID
FROM
    sakila.FILM_ACTOR FA
        INNER JOIN
    sakila.FILM F ON F.FILM_ID = FA.FILM_ID
GROUP BY FA.FILM_ID;

SELECT 
    COUNT(*)
FROM
    sakila.inventory i
        JOIN
    sakila.film f ON i.film_id = f.film_id
WHERE
    f.title = 'Hunchback Impossible';

SELECT 
    SUM(p.amount) Total_Amount_Paid, c.last_name, c.first_name
FROM
    sakila.payment p
        JOIN
    sakila.customer c ON p.customer_id = c.customer_id
GROUP BY c.last_name
ORDER BY c.last_name;

SELECT 
    f.title
FROM
    sakila.film f
WHERE
    language_id IN (SELECT 
            language_id
        FROM
            sakila.language
        WHERE
            name = 'English')
        AND (f.title LIKE 'K%' OR f.title LIKE 'Q%');


SELECT 
    *
FROM
    sakila.film_actor fa,
    sakila.actor a
WHERE
    fa.film_id IN (SELECT 
            f.film_id
        FROM
            sakila.film f
        WHERE
            f.title = 'Alone Trip')
        AND a.actor_id = fa.actor_id;

SELECT 
    cust.email, cust.first_name, cust.last_name, c.country
FROM
    sakila.country c
        JOIN
    sakila.city ci ON c.country_id = ci.country_id
        JOIN
    sakila.address a ON a.city_id = ci.city_id
        JOIN
    sakila.customer cust ON cust.address_id = a.address_id
WHERE
    c.country = 'Canada';

SELECT 
    f.title movie_title, c.name category_type
FROM
    sakila.film_category fc
        JOIN
    (SELECT 
        *
    FROM
        sakila.category cat
    WHERE
        cat.name = 'Family') c ON fc.category_id = c.category_id
        JOIN
    sakila.film f ON f.film_id = fc.film_id;
    
SELECT 
    COUNT(f.film_id) Num_Rentals, f.title Mov_Title
FROM
    sakila.rental r
        JOIN
    sakila.inventory i ON r.inventory_id = i.inventory_id
        JOIN
    sakila.film f ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY COUNT(f.film_id) DESC;

SELECT 
    s.store_id, SUM(p.amount) revenue
FROM
    sakila.payment p
        JOIN
    sakila.rental r ON p.rental_id = r.rental_id
        JOIN
    sakila.inventory i ON i.inventory_id = r.inventory_id
        JOIN
    sakila.store s ON s.store_id = i.store_id
GROUP BY s.store_id;

SELECT DISTINCT
    s.store_id, c.city, co.country
FROM
    sakila.store s
        JOIN
    sakila.address a ON s.address_id = a.address_id
        JOIN
    sakila.city c ON a.city_id = c.city_id
        JOIN
    sakila.country co ON co.country_id = c.country_id;

SELECT 
    c.name Category_Nm, SUM(p.amount) Revenue
FROM
    sakila.category c,
    sakila.film_category fc,
    sakila.inventory i,
    sakila.payment p,
    sakila.rental r,
    sakila.film f
WHERE
    c.category_id = fc.category_id
        AND f.film_id = fc.film_id
        AND i.film_id = f.film_id
        AND r.inventory_id = i.inventory_id
        AND p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

CREATE VIEW sakila.top_five_genres AS
    (SELECT 
        c.name Category_Nm, SUM(p.amount) Revenue
    FROM
        sakila.category c,
        sakila.film_category fc,
        sakila.inventory i,
        sakila.payment p,
        sakila.rental r,
        sakila.film f
    WHERE
        c.category_id = fc.category_id
            AND f.film_id = fc.film_id
            AND i.film_id = f.film_id
            AND r.inventory_id = i.inventory_id
            AND p.rental_id = r.rental_id
    GROUP BY c.name
    ORDER BY SUM(p.amount) DESC
    LIMIT 5);

SELECT 
    *
FROM
    sakila.top_five_genres;

drop view sakila.top_five_genres;




