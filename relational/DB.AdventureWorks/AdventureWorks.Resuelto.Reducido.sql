-- Consulta 1
-- Mostrar el nombre, precio y precio con iva de los productos fabricados.
-- Dónde los precios sean diferentes a cero. Redondear el resultado en ambos.
-- tablas: Product
-- campos: Name,ListPrice

select Name, ListPrice, ListPrice + (ListPrice * 0.21) as con_Iva
from Product;

-- Consulta 2
-- Mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea johnson
-- tablas: contact
-- campos: FirstName,LastName

select concat(firstName, ' ', LastName)
from contact
WHERE LastName LIKE '%johnson';

-- Consulta 3
-- Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo precio sea mayor a 500$ de color negro
-- tablas: Product
-- campos: productid, name, ListPrice,Color

select productid, name, listPrice, Color
from Product
WHERE (ListPrice < 150 AND Color = 'Red') OR (ListPrice > 500 AND Color = 'Black');

-- Consulta 4
-- Mostrar todos los empleados que nacieron entre 1970 y 1985
-- tablas: Employee
-- campos: BirthDate

select EmployeeID, birthdate from Employee
where BirthDate between '1970.01.01' and '1985.01.01';

-- Consulta 5
-- Mostrar el nombre y precio de los accesorios para asientos de las bicicletas cuyo precio sea  mayor a 100 pesos
-- tablas: Product
-- campos: Name,ListPrice,Color

select name, listPrice from Product
where name like '%seat%' and listprice > 100;

-- Consulta 6
-- Mostrar los nombre de los productos que tengan cualquier combinación de 'mountain bike'
-- tablas: Product
-- campos: Name,ListPrice

select name, listPrice from product
where name like '%mountain bike%';

-- Consulta 7
-- Mostrar los empleados que la segunda letra de su apellido es una s
-- tablas: contact
-- campos: LastName

select lastName from contact
where LastName like '_s%';

-- Consulta 8
-- Mostrar los nombres de los productos que su nombre termine en un número
-- tablas: Product
-- campos: Name

select name from Product
where name like '%9';

-- Consulta 9
-- Mostrar la fecha más reciente de venta
-- tablas: SalesOrderHeader
-- campos: OrderDate

select max(orderDate) from SalesOrderHeader;

-- Consulta 10
-- Mostrar el precio más barato de todas las bicicletas
-- tablas:Production.Product
-- campos: ListPrice, ProductNumber

select min(listPrice) from Product
where ProductNumber like 'bk%';

-- Consulta 11
-- Mostrar los representantes de ventas (vendedores) que no tienen definido el número de territorio
-- tablas: Sales.SalesPerson
-- campos: TerritoryID

select salespersonid from salesperson
where territoryID is null;

-- Consulta 12
-- Mostrar todas las facturas realizadas y el total facturado de cada una de ellas 
-- ordenado por número de factura  pero sólo de aquellas órdenes superen un total de $10.000
-- tablas: SalesOrderDetail
-- campos: SalesOrderID,UnitPrice,OrderQty

select salesorderid, sum(unitprice * orderqty) as subtotal from SalesOrderDetail
group by SalesOrderID
having sum(unitprice * orderqty) > 10000
order by salesorderID;

-- Consulta 13
-- Mostrar la cantidad de facturas que vendieron más de 20 unidades
-- tablas: SalesOrderDetail
-- campos: SalesOrderID, OrderQty

select salesorderid, sum(orderqty) as cantidad from SalesOrderDetail
group by salesorderid
having sum(orderqty) > 20;

-- Consulta 14
-- Mostrar las subcategorías de los productos que tienen dos o más productos que cuestan menos de $150
-- tablas: Product
-- campos: ProductSubcategoryID, ListPrice

select productsubcategoryid, count(*) as cantidad
from Product
where ListPrice > 150
group by productsubcategoryid
having count(*) > 1;

-- Consulta 15
-- Mostrar todos los codigos de categorias existentes junto con la cantidad de productos
-- y el precio de lista promedio por cada uno de aquellos productos 
-- que cuestan mas de $ 70 y el precio promedio es mayor a $ 300.
-- tablas:Product
-- campos: ProductSubcategoryID, ListPrice

select distinct(productsubcategoryid), count(ProductSubcategoryID) as Stock, avg(listprice) as Precio_Promedio
from product
where listprice > 70
group by productsubcategoryid
having avg(listprice) > 300;

-- "Sub Consultas"

-- Consulta 16
-- Listar todos las productos cuyo precio sea inferior al precio promedio de todos los productos
-- tablas:Production.Product
-- campos: Name, ListPrice

select name, listprice
from Product
where listprice < (select avg(listprice) from Product);

-- Consulta 17
-- Listar  el nombre, precio de lista, precio promedio y diferencia de precios entre cada producto y el valor promedio general
-- tablas: Product
-- campos: Name, ListPrice

select name producto,
	   listprice precio_de_lista,
	   (select avg(listprice) from Product) as promedio,
	   listprice - (select avg(listprice) from Product) as diferencia_de_precio
from   Product;

-- Consulta 18
-- Mostrar el o los códigos del producto mas caro
-- tablas: Product
-- campos: ProductID,ListPrice

select productid, listprice
from Product
where ListPrice = (select max(listprice) from Product);

-- Consulta 19
-- Mostrar el producto más barato de cada subcategoría. 
-- mostrar subcaterogia, codigo de producto y el precio de lista mas barato ordenado por subcategoría
-- tablas: Product
-- campos: ProductSubcategoryID, ProductID, ListPrice

select   p1.productsubcategoryid,
	     p1.productid,
	     p1.listprice
from     Product as p1
where    listprice = (
					  select min(listprice)
					  from   Product as p2
					  where  p2.ProductSubcategoryID = p1.ProductSubcategoryID
				     )
order by p1.ProductSubcategoryID;

-- Consulta 20
-- Mostrar las órdenes de venta que se hayan facturado en territorio de estado unidos únicamente 'us'
-- tablas: SalesOrderHeader, SalesTerritory
-- campos: CountryRegionCode, TerritoryID

select salesorderid from SalesOrderHeader
where TerritoryID in (
					   select TerritoryID 
					   from SalesTerritory
					   where CountryRegionCode = 'us'
					  );

-- Consulta 21
-- Mostrar aquellos productos cuya cantidad de pedidos de venta sea igual o superior a 20
-- tablas: Product, SalesOrderDetail
-- campos: Name, ProductID , OrderQty

select name producto
from   Product
where  ProductID in 
					(
					 select productid
					 from   SalesOrderDetail
					 where  OrderQty >= 20
					)
order by name;

-- Joins

-- Consulta 22
-- Mostrar  los empleados que también son vendedores
-- tablas: Employee , SalesPerson
-- campos: EmployeeID, SalespersonID

select e.employeeid, s.salespersonID from Employee as e
join SalesPerson as s on e.employeeID = s.salespersonID;

-- Consulta 23
-- Mostrar los productos que sean ruedas
-- tablas: Product, ProductSubcategory
-- campos: Name 

-- Solución con Like
select p.name,
	   c.name
from   Product as p
join   ProductSubcategory as c
on     p.ProductsubCategoryID = c.ProductsubCategoryID
where  c.Name like 'wheels';  

-- Solución con el ID de la subcategoría.
select p.name,
	   c.name
from   Product as p
join   ProductSubcategory as c
on     p.ProductsubCategoryID = c.ProductsubCategoryID
where  p.ProductsubCategoryID = 17; 

-- Consulta 24
-- Mostrar los nombres de los productos que no son bicicletas
-- tablas: Product, ProductSubcategory
-- campos: Name
select p.name,
	   sc.name
from   Product as p
inner join   ProductSubcategory as sc
on     p.ProductSubcategoryID = sc.ProductSubcategoryID
where  sc.Name not like '%bike%';

-- Consulta 25
-- Mostrar los precios de venta de aquellos productos donde el 
-- precio de venta sea inferior al precio de lista recomendado para ese producto ordenados por nombre de producto
-- tablas: SalesOrderDetail , Product
-- campos: ProductID,Name,ListPrice,UnitPrice

select distinct(p.productid), 
       p.name, 
	   p.listprice, 
	   s.unitprice
from   Product as p
join   SalesOrderDetail as s
on     p.ProductID = s.ProductID
where  s.UnitPrice < p.ListPrice;

-- Consulta 26
-- ¿Join de la misma tabla?
-- Mostrar todos los productos que tengan igual precio.
-- Se deben mostrar de a pares, código y nombre de cada uno de los dos productos y el precio de ambos. ordenar por precio en forma descendente
-- tablas: Product
-- campos: ProductID, ListPrice


select		distinct p.productid,
			p.name,
			p2.productid,
			p2.name,
			p.listprice
from		Product as p
inner join  product as p2
on			p.ListPrice = p2.ListPrice
and			p.ProductID != p2.ProductID 
order by	p.ListPrice desc;

-- Consulta 27
-- Mostrar todos los productos que tengan igual precio. 
-- Se deben mostrar de a pares. código y nombre de cada uno de los dos productos y el precio de ambos mayores a $15
-- tablas: Product
-- campos: ProductID, ListPrice

select distinct p.productid, 
				p.name, 
				p2.productid,
				p2.name,
				p.ListPrice
from			Product as p
inner join		product as p2
on				p.ListPrice = p2.ListPrice
where			p.ProductID != p2.ProductID and	p.ListPrice > 15
order by		p.ListPrice desc;

-- Consulta 28
-- ¿Cross Join?
-- Mostrar el producto cartesiano entre la tabla de vendedores cuyo numero de identificacion de negocio sea 280
-- y el territorio de venta sea el de francia
-- tablas: SalesPerson , SalesTerritory
-- campos: SalesPersonID

select			* 
from			SalesPerson as sp
cross join		SalesTerritory as st
where			sp.salespersonID = 280 and st.name like '%france%';

-- Consulta 29
-- Crear una vista con la siguiente estructura:
-- salesOrderID     | order date       | productName | nombre categoría | makeFlay | color    | Order QTY        | Unit Price       | customer Name  | SalesPersonId    | shiped metod
-- salesorderdetail | salesorderheader | product	 | product category | product  | product  | salesorderheader | salesorderheader | store          | salesorderheader | shipmethod 
-- No vamos a tener en cuenta los registros que tengan al menos un valor null. 
-- ¿Qué join debemos utilizar para descartar los valores null?

select 		sord.salesorderid as orden,
			shea.orderdate as fecha,
            p.name as producto,
            pc.name as categoria,
            p.makeflag as premium,
            p.color as color,
            sord.OrderQty as cantidad,
            sord.UnitPrice as precio_unitario,
            s.name as cliente,
            shea.SalesPersonID,
            ship.name as metodo_envio
from 		salesorderdetail as sord
inner join 	salesorderheader as shea
on 			sord.salesorderid = shea.SalesOrderID
inner join  product as p
on 			p.productid = sord.productid
inner join  productcategory as pc
on			p.ProductSubcategoryID = pc.ProductCategoryID
inner join  shipmethod as ship
on			shea.shipmethodid = ship.shipmethodid
inner join  store as s
on			shea.customerid = s.CustomerID;