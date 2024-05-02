-- Debemos generar una consulta que nos devuelva el siguiente resultado:

--     ID   | apellido |  nombre  | email    | activo   | direccion | ciudad |   pais  | cantidad de alquileres | suma total gastada |
-- Customer | customer | customer | customer | customer | address   |  city  | country |         payment        |      payment       |

-- Selecciono los campos relevantes de la tabla customer. Listo el resto en comentarios

       
-- Primer Join: Address.
       
-- Segundo Join: Ciudad 

-- Tercer Join: Country
     
-- Cuarto Join: Payment

-- Elimino campos innecesarios

-- Creo Vista: clientes

SELECT
    cu.customer_id AS id,
    cu.last_name AS apellido,
    cu.first_name AS nombre,
    cu.email,
    cu.active AS activo,
    ad.address AS domicilio,
    ci.city AS ciudad,
    co.country AS pais,
    COUNT(pa.rental_id) AS cantidad_de_alquileres
    SUM(pa.amount) AS importe_gastado
FROM
    customer AS cu
INNER JOIN address AS ad ON cu.address_id = ad.address_id
INNER JOIN city AS ci ON ad.city_id = ci.city_id
INNER JOIN country AS co ON ci.country_id = co.country_id
INNER JOIN payment AS pa ON cu.customer_id = pa.customer_id
GROUP BY cu.customer_id, cu.last_name, cu.first_name, cu.email, cu.active, ad.address, ci.city, co.country;