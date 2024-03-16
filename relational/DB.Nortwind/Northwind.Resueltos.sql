-- Consulta 1
-- Usar Nortwind
use northwind;

-- Consulta 2
-- Mostrar todas las tablas de la base Northwind
show tables;

-- Consulta 3
-- Muestre la definición de la tabla employees - Describe -
describe employees;

-- Consulta 4
-- Mostrar todos los empleados y sus atributos
SELECT * from employees;

-- Consulta 5
-- Mostrat todos los productos y sus atributos
SELECT * from products;

-- Consulta 6
-- Mostrar el id, código del producto, el nombre del producto y su categoría 
SELECT id, product_code, product_name, category from products;

-- Consulta 7
-- Mostrar los productos que pertenecen a la categoría 'Condiments'
SELECT * FROM products
where category = 'Condiments';

-- Consulta 8
-- Mostrar los productos que pertenecen tanto a la categoría 'Condiments' como a 'Oil'
SELECT * FROM products
where category = 'Condiments' or category = 'Oil';

-- Consulta 9
-- Mostrar producos que tienen un precio de lista mayor a 10
SELECT * FROM products
WHERE list_price > 10;

-- Consulta 10
-- Mostrar el producto 'Northwind Traders Chai'
SELECT * FROM products
WHERE product_name = 'Northwind Traders Chai';

-- Consulta 11
-- Mostrar los productos del id 1, 3, 4 y 14 - Use 'IN'
SELECT * FROM products
WHERE id in(1,3,4,14);

-- Consulta 12
-- Mostrar los productos del suppier_id 10 y 7
SELECT * FROM products
WHERE supplier_ids in(10, 7);

-- Consulta 13
-- Mostrar nombre de producto, precio de lista y costo de productos que tienen un precio entre 10 y 25
SELECT product_code, list_price, standard_cost FROM products
WHERE list_price BETWEEN 10 and 25;

-- Consulta 14
-- Mostrar los productos cuyo reorder level está entre 0 y 15
SELECT * FROM products 
WHERE reorder_level between 0 and 15;

-- Consulta 15
-- Mostrar todos los productos que comiencen con c
SELECT * from products
WHERE category like 'c%';

-- Consulta 16
-- Seleccionar el id y el nombre del prodcuto y ordenar la consulta por id (de menor a mayor)
SELECT id, product_name from products
order by id;

-- Consulta 17
-- Seleccionar el id y el nombre del producto y ordenar la consulta por id (de mayor a menor)
SELECT id, product_name from products
order by id desc;

-- Consulta 18
-- Seleccione todos los campos de la tabla cliente, ordenado por nombre del contacto de la compañía, alfabéticamente
SELECT * from customers 
order by first_name;

-- Consulta 19
-- Seleccione todos los campos de la tabla órdenes, ordenados por cantidad, descendentemente.
SELECT * from order_details
order by quantity desc;

-- Consulta 20
-- Seleccione todos los campos de la tabla detalle de la orden, ordenada por cantidad pedida. Ascendentemente.
SELECT * from order_details
order by quantity asc;

-- Consulta 21
-- Obtener todos los productos, cuya categoría comienzan con la letra P y tienen un precio unitario comprendido entre 10 y 120
SELECT * from products
where category like 'p%' and list_price between 10 and 120;

-- Consulta 22
-- Obtener todos os clientes de los países de: USA, Francia y UK ordenado por ciudad de manera descendente:
SELECT * from customers
where country_region in ('USA','Francia','UK')
order by city desc;

-- Consulta 23
-- Obtener todos los productos que tienen un target level mayor a 100, que tienen product code 'NWTB'.
SELECT * from products
where target_level > 100 and product_code like 'NWTB%';

-- Consulta 24
-- Obtener todas las órdenes hechas por el empleado con código: 2, 5 y 7 en el año 2006
SELECT * from orders
where employee_id in (2, 5, 7) and year(order_date) = 2006; 

-- Consulta 25
-- Seleccionar todos los suppliers que sean Manager
SELECT * from suppliers
WHERE job_title like '%manager';

-- Consulta 26
-- Seleccionar todos los proveedores que no sean Managers.
SELECT * from suppliers
WHERE job_title not like '%manager';

-- Joins

-- Consulta 27
-- Seleccionar el tipo de la transacción (no el id) y la cantidad (Sin funciones de agregación)
-- Tablas involucradas: inventory_transaction_types, inventory_transactions
-- Resultado de la consulta: tipo | cantidad

select itype.type_name as tipo,
	   it.quantity as cantidad
from inventory_transaction_types as itype
inner join inventory_transactions as it
on itype.id = it.transaction_type;

-- Consulta 28
-- Agrupar la consulta anterior por tipo 

select 		itype.type_name as tipo,
			sum(it.quantity) as cantidad
from 		inventory_transaction_types as itype
inner join 	inventory_transactions as it
on 			itype.id = it.transaction_type
group by 	tipo;

-- Consulta 29
-- De la consulta anterior mostrar todas la categorías, aunque no tengan valores. (Son 4) ¿Left/Rigth join?

select 		itype.type_name as tipo,
			sum(it.quantity) as cantidad
from 		inventory_transaction_types as itype
left join 	inventory_transactions as it
on 			itype.id = it.transaction_type
group by 	tipo;

-- Consulta 30
-- Seleccionar el nombre del producto,
-- el tipo de la transacción (no el id) y la cantidad (Sin funciones de agregación)
-- Tablas involucradas: inventory_transaction_types, inventory_transactions, products
-- Resultado de la consulta: nombre del producto | cantidad | tipo de transaccion

select p.product_name ,
       itype.type_name as tipo,
       it.quantity
from products as p
inner join inventory_transactions as it
on p.id = it.product_id
inner join inventory_transaction_types as itype
on it.transaction_type = itype.id;

-- Consulta 31
-- Realizar una consulta que retorne el nombre del nombre del producto, la cantidad comprada y el precio pagado por cada unidad
-- El resultado de la consulta debería ser:
-- nombre | cantidad | precio unitario
-- Tablas involucradas: products, order_details

select p.product_name as nombre,
	   o.quantity as cantidad,
       o.unit_price as precio_unitario
from products as p
inner join order_details as o
on p.id = o.order_id;

-- Consulta 32
-- Agrupar la consulta anterior por producto.

select p.product_name as nombre,
	   sum(o.quantity) as cantidad,
       sum(o.unit_price) as precio_unitario
from products as p
inner join order_details as o
on p.id = o.order_id
group by nombre;

-- Consulta 33
-- Realizar una consulta que retorne 
-- La orden de compra (order_id), nombre del producto, la cantidad comprada y el precio pagado por cada unidad
-- El resultado de la consulta debería ser:
-- orden de compra | nombre | cantidad | precio unitario
-- Tablas involucradas: products, order_details

select o.order_id as orden_de_compra,
	   p.product_name as nombre,
	   o.quantity as cantidad,
       o.unit_price as precio_unitario
from products as p
inner join order_details as o
on p.id = o.order_id;

-- Consulta 34
-- Agrupar la consulta anterior por orden de compra

select o.order_id as orden_de_compra,
	   p.product_name as nombre,
	   sum(o.quantity) as cantidad,
       sum(o.unit_price) as precio_unitario
from products as p
inner join order_details as o
on p.id = o.order_id
group by orden_de_compra;

-- Consulta 35
-- Realizar una consulta que retorne el nombre del producto (product_name) y la compañia proveedora(
-- Tablas involucradas: products, suppliers;
-- Resultado de la consulta: 
-- nombre del producto | compañia proveedora

select p.product_name as producto,
	   s.company as proveedor
from products as p
inner join suppliers as s
on p.supplier_ids = s.id;

-- Consulta 36
-- Realizar una consulta que retorne el nombre del producto (product_name) y la status_id
-- Tablas involucradas: products, order_details;
-- Resultado de la consulta: 
-- nombre del producto | status_id

select p.product_name as producto,
	   o.status_id
from products as p
inner join order_details as o
on p.id = o.product_id;

-- Consulta 37
-- Realizar una consulta que retorne el nombre del producto (product_name) y el status (status_name).
-- Tablas involucradas: products, order_details, order_details_status;
-- Resultado de la consulta: 
-- nombre del producto | status

select p.product_name as producto,
       ods.status_name as status
from products as p
inner join order_details as o
on p.id = o.product_id
inner join order_details_status as ods
on o.status_id = ods.id;

-- Consulta 38:
-- Realizar de el conteo de cada uno de los productos por estatus.
-- Resultado de la consulta:
-- status | cantidad de productos

select 		ods.status_name as status,
			count(p.product_name) as cantidad_de_productos
from 		products as p
inner join 	order_details as o
on 			p.id = o.product_id
inner join 	order_details_status as ods
on 			o.status_id = ods.id
group by status;

-- Consulta 39:
-- Mostrar aquellos status que no tienen ningún producto asociado (¿Right/Left?)

select ods.status_name as status,
	   count(p.product_name) as cantidad_de_productos
from products as p
inner join order_details as o
on p.id = o.product_id
right join order_details_status as ods
on o.status_id = ods.id
group by status;

