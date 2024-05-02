-- Consulta que alimenta la vista clintes.

select 		cu.customer_id as id,
			cu.last_name as apellido,
			cu.first_name as nombre,
			cu.email,
			cu.active as activo,
			ad.address as domicilio,
            ci.city as ciudad,
            co.country as pais,
            count(pa.rental_id) as cantidad,
            sum(pa.amount) as importe_gastado
from   		customer as cu
inner join 	address as ad on cu.address_id = ad.address_id
inner join  city as ci on ad.city_id = ci.city_id
inner join  country as co on ci.country_id = co.country_id
inner join  payment as pa on  cu.customer_id = pa.customer_id
group by cu.customer_id;


-- Actualmente está conformada de la siguiente manera
--     ID   | apellido |  nombre  | email    | activo   | direccion | ciudad |   pais  | cantidad de alquileres | suma total gastada |
-- Customer | customer | customer | customer | customer | address   |  city  | country |         payment        |      payment       |

-- Se la va a modificar para que quede de la siguiente manera:
-- fecha    |    ID    | apellido y nombre  |  email    | activo   | direccion | ciudad |  pais   |	alquileres |  gastado | días_transcurridos
-- payment	| Customer |      customer      | customer  | customer |  address  |  city  | country |   payment  |  payment |       rental

-- Cambio el id para que sea único. Pasa de Customer Id a rental id.
-- Concateno nombre y apellido.
-- Me quedo sólo con la fecha - ¿Es una buena práctica? ¿Qué se puede recomendar?
-- Calculo la diferencia entre la fecha de entrega y la de devolución.

select 		date(pa.payment_date) as fecha,
			re.rental_id as id,
			concat(cu.last_name, ' ',cu.first_name) as Nombre_Completo,
			cu.email,
			cu.active as activo,
			ad.address as domicilio,
            ci.city as ciudad,
            co.country as pais,
            pa.amount as importe_gastado,
            datediff(return_date, rental_date) as dias_transcurridos
from   		customer as cu
join	 	address as ad on cu.address_id = ad.address_id
join  		city as ci on ad.city_id = ci.city_id
join  		country as co on ci.country_id = co.country_id
join  		payment as pa on  cu.customer_id = pa.customer_id
join		rental as re on pa.rental_id = re.rental_id;
