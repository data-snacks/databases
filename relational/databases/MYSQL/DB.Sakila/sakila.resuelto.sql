-- Consulta 0:
-- Corroborar que en las tablas: 
-- actor, customer, film, rental, payment, city, country, inventory, store y address
-- haya datos.
select * from actor;
select * from customer;
select * from film;
select * from rental;
select * from payment;
select * from city;
select * from country;
select * from inventory;
select * from store;
select * from address;

-- Consulta 1:
-- Obtener el nombre y apellido de los primeros 5 actores disponibles.
-- Utilizar aliases para mostrar los nombres de las columnas en español.

select first_name as nombre, last_name as apellido from actor limit 5;

-- Consulta 2:
-- Obtener el nombre y apellido concatenados en un mismo campo 'Nombre completo'.
-- Utilizar aliases para mostrar los nombres de las columnas en español.

select concat(first_name," ", last_name) as nombre_completo from actor;

-- Consulta 3:
-- Obtener el nombre, apellido, mes último de actualización y año último de actualización.
-- Utilizar aliases para mostrar los nombres de las columnas en español.
-- nombre | apellido | mes | año

select first_name as nombre,
	   last_name  as apellido,
       monthname(last_update) as mes,
       year(last_update) as año
from   actor;

-- Consulta 4:
-- Obtener todos los campos de los actores entre el id 88 y 109.

select * from actor
where actor_id between 88 and 109;

-- Consulta 5:
-- Obtener un listado que incluya nombre, apellido y correo electrónico de los clientes (customers) INACTIVOS.
-- Utilizar aliases para mostrar los nombres de las columnas en español

select first_name as nombre, 
	   last_name as apellido,
       email as correo_electronico
from   customer
where  active = 0;

-- Consulta 6:
-- Obtener un listado de films incluyendo título, año y descripción de los films que tienen un rental_duration mayor a cinco. 
-- Ordenar por rental_duration de mayor a menor.
-- Utilizar aliases para mostrar los nombres de las columnas en español

select 		title as titulo, 
			rental_duration as duracion,
			release_year as lanzamiento, 
			description as descripcion
from   		film
where  		rental_duration > 5
order by 	rental_duration;

-- Consulta 7:
-- Obtener un listado de alquileres (rentals) que se hicieron durante el mes de Mayo de 2005. 
-- Incluir en el resultado todas las columnas disponibles.

select * from rental
where year(rental_date) = 2005 and month(rental_date) = 05;

-- Consulta 8:
-- Obtener la cantidad TOTAL de alquileres (rentals).
-- Utilizar un alias para mostrarlo en una columna llamada “cantidad”

select count(*) as cantidad_total from rental;

-- Consulta 9:
-- Obtener la suma TOTAL de todos los pagos (payments) disponibles.
-- Utilizar un alias para mostrarlo en una columna llamada “total”

select sum(amount) as total from payment;

-- Consulta 10:
-- Obtener la suma TOTAL de todos los pagos (payments) disponibles.
-- Utilizar un alias para mostrarlo en una columna llamada “total”
-- Redondear el monto.

select round(sum(amount)) as total from payment;

-- Consulta 11:
-- Generar un reporte que responda a la pregunta:
-- ¿Cuáles son los diez clientes que más dinero gastan?
-- ¿Los datos están en la tabla Rental o Payment?

select customer_id, sum(amount) from payment
group by customer_id
order by sum(amount) desc
limit 10;

-- Consulta 12:
-- Generar un reporte que indique: 
-- id de cliente, cantidad de alquileres y monto total.
-- Para todos los clientes que hayan gastado más de 150 dólares en alquileres

select customer_id,
	   count(rental_id) as cantidad,
       sum(amount) as monto_total
       from payment
group by customer_id
having sum(amount) > 150;
-- having monto_total > 150 -- También funciona


-- Consulta 13:
-- Generar un reporte que indique:
-- Cantidad y Monto total de alquileres para los meses pertenecientes al año 2005.
-- Deben aparecer el nombre de los meses. No importa el orden. (tabla payment)
-- Redondear el monto total y mostrar los nombre de los meses

select monthname(payment_date) as mes,
	   count(rental_id) as cantidad,
       round(sum(amount)) as monto_total
       from payment
where year(payment_date) = 2005
group by monthname(payment_date);

-- Consulta 14:
-- Generar un listado que especifique la cantidad de inventarios alquilados. Ordenados por cantidad de inventarios. 
-- (Columna inventory_id - Tabla rental). Para cada una de ellas indicar la cantidad de alquileres.
-- Resultado de la consulta: id | cantidad

select inventory_id as id, 
	   count(rental_id) as cantidad
from rental
group by inventory_id
order by cantidad desc
limit 5;

-- Consulta 15:
-- ¿Cuántos alquileres hubo por año?
-- Resultado de la consulta: año | cantidad
select year(rental_date) as año, 
       count(rental_id) as cantidad
from rental
group by año;

-- JOINS

-- Consulta 16
-- Tablas involucradas: film, language.
-- Listar el film_id, title, release_year, el languaje_id (de language) y el name (languaje)
-- Resultado de la consulta:
-- film_id | title | release_year | language_id | name

 
select 		f.film_id, 
			f.title,
			f.release_year,
			f.language_id,
			l.name
from 		film as f
inner join  language as l
on			f.language_id = l.language_id;

-- Consulta 17.
-- Obtener un listado de las ciudades y el país al que pertenece.
-- La consulta debería retornar una estructura similiar a:
-- city_id | city | country
-- Tablas involucradas: country, city

select ci.city_id, ci.city, co.country from city as ci
join country as co
on	ci.country_id = co.country_id;

-- Consulta 18:
-- Generar un reporte que responda a la pregunta:
-- ¿Cuáles son los diez clientes que más dinero gastan y en cuantos alquileres lo hacen?
-- ¿Los datos están en la tabla Rental o Payment?
-- Ahora en vez del ID debe aparecer el apellido y el nombre (en campos separados) del cliente
-- Estos campos se encuentran. En la tabla customer.

select 		p.customer_id, 
			c.last_name, 
			c.first_name,
			sum(p.amount) 
from   		payment as p
inner join	customer as c
on			p.customer_id = c.customer_id
group by    p.customer_id
order by    sum(p.amount) desc
limit 10;

-- Consulta 19:
-- Generar un reporte que indique: 
-- id de cliente, cantidad de alquileres y monto total.
-- redonde el monto total
-- Para todos los clientes que hayan gastado más de 150 dólares en alquileres.
-- customer_id | nombre_completo | cantidad | monto_total

select p.customer_id,
	   concat(c.first_name,' ', c.last_name) as nombre_completo,
	   count(p.rental_id) as cantidad,
       round(sum(p.amount)) as monto_total
       from payment as p
inner join customer as c
on p.customer_id = c.customer_id
group by p.customer_id
having sum(p.amount) > 150;

-- Consulta 20: -- Join de tres tablas
-- Generar un reporte que responda a la pregunta: 
-- ¿Cuáles son los títulos más alquilados más alquilados?
-- Tablas involucradas: rental, inventory, film.
-- (Columna inventory_id - Tabla rental). Para cada una de ellas indicar la cantidad de alquileres.
-- Resultado de la consulta:
-- title | cantidad

select f.title,
	   count(r.rental_id) as cantidad
from rental as r
inner join inventory as i on r.inventory_id = i.inventory_id
inner join film as f on i.film_id = f.film_id
group by f.title;

-- Consulta 21 - Joins de cuatro tablas.
-- Obtener un listado del numero de inventario, titulo de la pelicula, dirección donde se encuentra (Local).
-- La consulta debería retornar una consulta estructurada de la siguiente manera:
-- Inventory_id | Title | dirección | mes | año
-- Tablas involucradas: Inventory, Store, film, adresss

select inventory_id, 
	   film_id,
       store_id, 
       monthname(last_update) as mes,
       year(last_update) as año 
from inventory as i;

select i.inventory_id,
	   i.film_id,
       i.store_id, 
       f.title,
       s.address_id as id_adress,
       a.address as direccion,
       monthname(i.last_update) as mes,
       year(i.last_update) as año 
from inventory as i
inner join film as f on i.film_id = f.film_id
inner join store as s on i.store_id = s.store_id
inner join address as a on s.address_id = a.address_id;

select i.inventory_id,
       f.title,
       a.address as direccion,
       monthname(i.last_update) as mes,
       year(i.last_update) as año 
from inventory as i
inner join film as f on i.film_id = f.film_id
left join store as s on i.store_id = s.store_id
left join address as a on s.address_id = a.address_id;




