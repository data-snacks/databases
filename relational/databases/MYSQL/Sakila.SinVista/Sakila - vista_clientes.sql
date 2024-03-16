-- Vista para tener los datos en 'vista_clientes'

CREATE VIEW vista_clientes
AS
SELECT cu.customer_id AS ID, 
	   CONCAT(cu.first_name, ' ', cu.last_name) AS name,
       a.address AS address, 
       a.postal_code AS `zip code`,
	   a.phone AS phone,
       city.city AS city, 
       country.country AS country
FROM customer AS cu 
JOIN address AS a ON cu.address_id = a.address_id
JOIN city ON a.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;
