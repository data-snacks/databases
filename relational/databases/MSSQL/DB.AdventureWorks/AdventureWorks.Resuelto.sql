--Laboratorio "Select - Where"

--Mostrar los empleados que tienen más de 90 horas de vacaciones
--tablas: HumanResources.Employee
--campos: VacationHours

select VacationHours 
from HumanResources.Employee
where VacationHours > 90;

--Mostrar el nombre, precio y precio con iva de los productos fabricados
--tablas:Production.Product
--campos: Name,ListPrice

select Name, ListPrice, ListPrice + (ListPrice * 0.21) as "con Iva"
from Production.Product;

--Mostrar los diferentes títulos de trabajo que existen
--tablas:HumanResources.Employee
--campos: JobTitle

select distinct JobTitle
from HumanResources.Employee;

--Mostrar todos los posibles colores de productos
--tablas:Production.Product
--campos: Color

select distinct Color
from Production.Product;

--Mostrar todos los tipos de personas que existen
--tablas:Person.Person
--campos: PersonType

select distinct PersonType
from Person.Person;

--Mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea johnson
--tablas:Person.Person
--campos: FirstName,LastName

select concat(firstName, ' ', LastName)
from Person.Person
WHERE LastName LIKE '%johnson';

--Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo precio sea mayor a 500$ de color negro
--tablas:Production.Product
--campos: ListPrice,Color

select listPrice, Color
from Production.Product
WHERE (ListPrice < 150 AND Color = 'Red') OR (ListPrice > 500 AND Color = 'Black')

--Mostrar el código, fecha de ingreso y horas de vacaciones de los empleados ingresaron a partir del año 2000
--tablas: HumanResources.Employee
--campos: BusinessEntityID,HireDate,VacationHours

select BusinessEntityID, HireDate, VacationHours
from HumanResources.Employee
where Year(hireDate) >= 2000;

--Mostrar el nombre, número de producto, precio de lista y el precio de lista
-- incrementado en un 10% de los productos cuya fecha de fin de venta sea anterior al día de hoy
--tablas:Production.Product
--campos: Name, ProductNumber, ListPrice

select name, ProductNumber, ListPrice + (listPrice * 0.21)
FROM Production.Product
where SellEndDate < getdate();

--Adventure Works 2016

--Laboratorio "Between & IN"

--Mostrar todos los productos cuyo precio de lista esté entre 200 y 300
--tablas:Production.Product        
--campos: ListPrice

select name, ListPrice from Production.product
where ListPrice between 200 and 300

--Mostrar todos los empleados que nacieron entre 1970 y 1985
--tablas: HumanResources.Employee
--campos: BirthDate

select BusinessEntityID, birthdate from HumanResources.Employee
where BirthDate between '1970.01.01' and '1985.01.01'

--Mostrar los códigos de venta y producto,cantidad de venta y precio unitario de los artículos 750,753 y 770
--tablas:Sales.SalesOrderDetail
--campos: SalesOrderID, OrderQty, ProductID, UnitPrice

select salesOrderID, orderQty, productID, UnitPrice from Sales.SalesOrderDetail
where ProductID in(750, 753, 770)

--Mostrar todos los productos cuyo color sea verde, blanco y azul
--tablas:Production.Product
--campos:Color

select productid, name, color from Production.Product
where color in ('green', 'white', 'blue')

--Mostrar el la fecha,numero de version y subtotal de las ventas efectuadas en los años 2005 y 2006
--tablas: Sales.SalesOrderHeader
--campos: OrderDate, AccountNumber ,SubTotal

select orderdate, accountNumber, subTotal from sales.SalesOrderHeader
where orderdate between '2005/01/01' and '2006/01/01'

--Laboratorio "Like"

--Mostrar el nombre, precio y color de los accesorios para asientos de las bicicletas cuyo precio sea  mayor a 100 pesos
--tablas:Production.Product
--campos: Name,ListPrice,Color

select name, listPrice, color from Production.Product
where name like '%seat%' and listprice > 100

--Mostrar trar las bicicletas de montaña que  cuestan entre $1000 y $1200
--tablas:Production.Product
--campos: ProductNumber,ListPrice

select name, productNumber, listPrice from Production.Product
where ProductNumber like 'bk%' and listprice between 1000 and 1200

--Mostrar los nombre de los productos que tengan cualquier combinación de ‘mountain bike’
--tablas:Production.Product
--campos: Name,ListPrice

select name, listPrice from Production.product
where name like '%mountain bike%'

--Mostrar las personas que su nombre empiece con la letra “y”
--tablas:Person.Person
--campos: FirstName

select FirstName from Person.person
where firstName like 'y%'

--Mostrar las personas que la segunda letra de su apellido es una s
--tablas:Person.Person
--campos: LastName

select lastName from person.person
where LastName like '_s%'

--Mostrar el nombre concatenado con el apellido de las personas cuyo apellido tengan terminación española (ez)
--tablas:Person.Person
--campos: FirstName,LastName

select CONCAT(firstname,' ',lastname) as [nombre completo] from Person.person
where lastname like '%ez'

--Mostrar los nombres de los productos que su nombre termine en un número
--tablas:Person.Person
--campos: Name

select name from Production.Product
where name like '%[0-9]'

/*
Mostrar las personas cuyo  nombre tenga una c o c como primer caracter, 
cualquier otro como segundo caracter, ni d ni d ni f ni g como tercer caracter, 
cualquiera entre j y r o entre s y w como cuarto caracter y el resto sin restricciones
tablas:Person.Person
campos: FirstName
*/

select firstname from person.person
where firstname like '[C,c]_[^DdFg][J-W]%'

--Laboratorio "Order by"

--Mostrar las personas ordenadas primero por su apellido y luego por su nombre
--tablas:Person.Person
--campos: Firstname ,Lastname

select firstname, lastname from person.person
order by LastName, FirstName

--Mostrar cinco productos más caros y su nombre ordenado en forma alfabética
--tablas:Production.Product
--campos: Name,ListPrice

select top 5 listPrice, name from Production.Product
order by ListPrice desc, name

--Laboratorio "Funciones de Agrupación"

--Mostrar la fecha más reciente de venta
--tablas:Sales.SalesOrderHeader
--campos: OrderDate

select max(orderDate) from sales.SalesOrderHeader

--Mostrar el precio más barato de todas las bicicletas
--tablas:Production.Product
--campos: ListPrice, ProductNumber

select min(listPrice) from Production.Product
where ProductNumber like 'bk%'

--Mostrar la fecha de nacimiento del empleado más joven
--tablas: HumanResources.Employee
--campos: BirthDate

select max(BirthDate) from humanresources.employee

--Laboratorio "Null"

--Mostrar los representantes de ventas (vendedores) que no tienen definido el número de territorio
--tablas: Sales.SalesPerson
--campos: TerritoryID

select businessentityid from sales.salesperson
where TerritoryID is null

--Mostrar el peso promedio de todos los artículos. si el peso no estuviese definido, reemplazar por cero
--tablas:Production.Product
--campos: Weight

select avg(isnull(weight,0)) from Production.Product

--Laboratorio "Group By"

--Mostrar el código de subcategoría y el precio del producto más barato de cada una de ellas
--tablas:Production.Product
--campos: ProductSubcategoryID,ListPrice

select Productsubcategoryid, min(listprice) from Production.Product
group by Productsubcategoryid


--Mostrar los productos y la cantidad total vendida de cada uno de ellos
--tablas: Sales.SalesOrderDetail
--campos: ProductID, OrderQty

select productID, sum(orderqty) as vendidos from sales.SalesOrderDetail
group by productid

--Mostrar los productos y la cantidad total vendida de cada uno de ellos, ordenarlos por mayor cantidad de ventas
--tablas: Sales.SalesOrderDetail
--campos: ProductID, OrderQty

select productid, sum(orderqty) as vendidos from sales.salesorderdetail
group by productid
order by vendidos desc


--Mostrar todas las facturas realizadas y el total facturado de cada una de ellas ordenado por número de factura.
--tablas: Sales.SalesOrderDetail
--campos: SalesOrderID,UnitPrice,OrderQty

select salesorderid, sum(unitprice * orderqty) from sales.SalesOrderDetail
group by salesorderid
order by SalesOrderID

--Laboratorio "Having"

/*
Mostrar todas las facturas realizadas y el total facturado de cada una de ellas 
ordenado por número de factura  pero sólo de aquellas órdenes superen un total de $10.000
tablas: Sales.SalesOrderDetail
campos: SalesOrderID,UnitPrice,OrderQty
*/

select salesorderid, sum(unitprice * orderqty) as subtotal from sales.SalesOrderDetail
group by SalesOrderID
having sum(unitprice * orderqty) > 10000
order by salesorderID

--Mostrar la cantidad de facturas que vendieron más de 20 unidades
--tablas: Sales.SalesOrderDetail
--campos: SalesOrderID, OrderQty

select salesorderid, sum(orderqty) as cantidad from sales.SalesOrderDetail
group by salesorderid
having sum(orderqty) > 20

--Mostrar las subcategorías de los productos que tienen dos o más productos que cuestan menos de $150
--tablas:Production.Product
--campos: ProductSubcategoryID, ListPrice

select productsubcategoryid, count(*) as cantidad
from production.Product
where ListPrice > 150
group by productsubcategoryid
having count (*) > 1

/*
Mostrar todos los codigos de categorias existentes junto con la cantidad de productos
y el precio de lista promedio por cada uno de aquellos productos 
que cuestan mas de $ 70 y el precio promedio es mayor a $ 300.
tablas:Production.Product
campos: ProductSubcategoryID, ListPrice
*/

select distinct(productsubcategoryid), count(ProductSubcategoryID) as Stock, avg(listprice) as Precio_Promedio
from production.product
where listprice > 70
group by productsubcategoryid
having avg(listprice) > 300

--Laboratorio "Compute"

--Mostrar el numero de factura, el monto vendido, y al final, totalizar la facturacion.
--tablas:Sales.SalesOrderDetail
--campos: SalesOrderID, UnitPrice, OrderQty

select salesorderid, (unitprice * orderqty) as subtotal from Sales.SalesOrderDetail
order by salesorderid


--		Unidad 3 - Laboratorio "Joins"

--Mostrar  los empleados que también son vendedores
--tablas: HumanResources.Employee , Sales.SalesPerson
--campos: BusinessEntityID

select e.businessEntityID, s.businessEntityID from HumanResources.Employee as e
join sales.SalesPerson as s on e.BusinessEntityID = s.BusinessEntityID

select e.*
from HumanResources.Employee as e
join sales.SalesPerson as s
on e.BusinessEntityID = s.BusinessEntityID

--Mostrar  los empleados ordenados alfabéticamente por apellido y por nombre
--tablas: HumanResources.Employee , Person.Person
--campos: BusinessEntityID, LastName,FirstName

select p.firstname + ' ' + p.lastname as nombre_completo
from Person.person as p
join HumanResources.Employee as e
on p.BusinessEntityID = e.BusinessEntityID
order by nombre_completo

select *
from HumanResources.Employee as e
join person.Person as p
on e.BusinessEntityID = p.BusinessEntityID
order by p.lastname, p.firstname

--Mostrar el código de logueo, número de territorio y sueldo básico de los vendedores
--tablas: HumanResources.Employee ,Sales.SalesPerson
--campos: e.LoginID,TerritoryID,Bonus, BusinessEntityID

select e.loginID, s.territoryID, s.Bonus 
from HumanResources.Employee as e
join sales.SalesPerson as s 
on e.BusinessEntityID = s.BusinessEntityID;

select e.loginid,
	   territoryID,
	   bonus
from   HumanResources.Employee as e
join   sales.SalesPerson as s
on     e.BusinessEntityID = s.BusinessEntityID;

--Mostrar los productos que sean ruedas
--tablas: Production.Product, Production.ProductSubcategory
--campos: Name 

select p.name,
	   c.name
from   Production.Product as p
join   Production.ProductSubcategory as c
on     p.ProductsubCategoryID = c.ProductsubCategoryID
where  c.Name like 'wheels'  

select     *
FROM       production.Product as p
inner join Production.ProductSubcategory as s 
on         p.ProductSubcategoryID = s.ProductSubcategoryID
where      s.name = 'wheels'


--Mostrar los nombres de los productos que no son bicicletas
--tablas:Production.Product, Production.ProductSubcategory
--campos: Name

select p.name,
	   sc.name
from   Production.Product as p
inner join   Production.ProductSubcategory as sc
on     p.ProductSubcategoryID = sc.ProductSubcategoryID
where  sc.Name not like '%bike%'

select p.name as producto
from Production.Product as p
inner join Production.ProductSubcategory as s
on p.ProductSubcategoryID = s.ProductSubcategoryID
where s.name not like '%bikes%'

--Mostrar los precios de venta de aquellos productos donde el 
--precio de venta sea inferior al precio de lista recomendado para ese producto ordenados por nombre de producto
--tablas: Sales.SalesOrderDetail ,Production.Product
--campos: ProductID,Name,ListPrice,UnitPrice

select distinct p.productid, 
       p.name, 
	   p.listprice, 
	   s.unitprice
from   Production.Product as p
join   Sales.SalesOrderDetail as s
on     p.ProductID = s.ProductID
where  s.UnitPrice < p.ListPrice

select distinct p.productid,
                p.name as product,
				p.listprice as [precio de lista],
				sd.unitprice as 'Precio de Venta Recomendado'
from            sales.SalesOrderDetail as sd
inner join      Production.Product as p
on				sd.ProductID = p.ProductID
and				sd.UnitPrice < p.ListPrice

--Mostrar todos los productos que tengan igual precio.
--Se deben mostrar de a pares, código y nombre de cada uno de los dos productos y el precio de ambos. ordenar por precio en forma descendente
--tablas:Production.Product
--campos: ProductID, ListPrice

select		distinct p.productid,
			p.name,
			p2.productid,
			p2.name,
			p.listprice
from		Production.Product as p
inner join  Production.product as p2
on			p.ListPrice = p2.ListPrice
and			p.ProductID != p2.ProductID 
order by	p.ListPrice desc

select distinct p1.name, p2.name, p1.listprice
from			Production.Product p1
inner join		Production.product p2
on				p1.ListPrice = p2.ListPrice
where			p1.ProductID > p2.ProductID
order by		p1.ListPrice desc


--Mostrar todos los productos que tengan igual precio. 
--Se deben mostrar de a pares. código y nombre de cada uno de los dos productos y el precio de ambos mayores a $15
--tablas:Production.Product
--campos: ProductID, ListPrice

select distinct p.productid, 
				p.name, 
				p2.productid,
				p2.name,
				p.ListPrice
from			Production.Product as p
inner join		Production.product as p2
on				p.ListPrice = p2.ListPrice
where			p.ProductID != p2.ProductID and	p.ListPrice > 15
order by		p.ListPrice desc

select distinct p1.name, p2.name, p1.listprice
from			Production.Product p1
inner join		Production.Product p2
on				p1.ListPrice = p2.ListPrice
where			p1.ListPrice > 15
order by		p1.ListPrice desc

--Mostrar el nombre de los productos y de los proveedores cuya subcategoría es 15 ordenados por nombre de proveedor
--tablas: Production.Product ,Purchasing.ProductVendor , Purchasing.Vendor
--campos: Name ,ProductID,  BusinessEntityID, ProductSubcategoryID

select		p.name,
			v.name
from		Production.Product as p
inner join	Purchasing.ProductVendor as sp
on			p.ProductID = sp.ProductID
inner join  Purchasing.Vendor as v
on			sp.BusinessEntityID = v.BusinessEntityID
where		p.ProductSubcategoryID = 15
order by	v.name

select		p.name producto,
			v.name proveedores
from		Production.product as p
inner join	Purchasing.ProductVendor pv
on			p.ProductID = pv.ProductID
inner join  Purchasing.Vendor v
on			pv.BusinessEntityID = v.BusinessEntityID
where		ProductSubcategoryID = 15
order by	v.Name

--Mostrar todas las personas (nombre y apellido) y en el caso que sean empleados mostrar también el login id, sino mostrar null
--tablas: Person.Person, HumanResources.Employee
--campos: FirstName, p.LastName, e.LoginID, BusinessEntityID

select		p.firstname,
			p.lastname,
			e.loginID
FROM		person.person as p
left join	HumanResources.Employee as e
on			p.BusinessEntityID = e.BusinessEntityID

select			p.firstname, p.lastname, e.loginid
from			person.person p
left outer join HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID

--Mostrar el producto cartesiano entre la tabla de vendedores cuyo numero de identificacion de negocio sea 280
--y el territorio de venta sea el de francia
--tablas: Sales.SalesPerson ,Sales.SalesTerritory
--campos: BusinessEntityID, Name

select			* 
from			sales.SalesPerson as sp
cross join		sales.SalesTerritory as st
where			sp.BusinessEntityID = 280 and st.name like '%france%'

select			p.businessEntityid codigo,
				t.name territorio
from			sales.SalesPerson p
cross join		sales.SalesTerritory t
where			p.BusinessEntityID = 280 and t.name = 'france'

--Laboratorio "Sub Consultas"

--Listar todos las productos cuyo precio sea inferior al precio promedio de todos los productos
--tablas:Production.Product
--campos: Name, ListPrice

select name, listprice
from Production.Product
where listprice < (select avg(listprice) from Production.Product)

select *
from   production.Product
where  listprice < (
					select avg(listPrice)
					from Production.Product
					)
order by ListPrice desc, name

--Listar  el nombre, precio de lista, precio promedio y diferencia de precios entre cada producto y el valor promedio general
--tablas:Production.Product
--campos: Name, ListPrice

select name producto,
	   listprice [precio de lista],
	   (select avg(listprice) from Production.Product) promedio,
	   listprice - (select avg(listprice) from Production.Product) [diferencia de precio]
from   Production.Product

--Mostrar el o los códigos del producto mas caro
--tablas:Production.Product
--campos: ProductID,ListPrice

select productid, listprice
from production.Product
where ListPrice = (select max(listprice) from Production.Product)

--Mostrar el producto más barato de cada subcategoría. 
--mostrar subcaterogia, codigo de producto y el precio de lista mas barato ordenado por subcategoría
--tablas:Production.Product
--campos: ProductSubcategoryID, ProductID, ListPrice

select   p1.productsubcategoryid,
	     p1.productid,
	     p1.listprice
from     Production.Product p1
where    listprice = (
					  select min(listprice)
					  from   Production.Product p2
					  where  p2.ProductSubcategoryID = p1.ProductSubcategoryID
				     )
order by p1.ProductSubcategoryID

--Laboratorio "Sub Consultas con Exists"

--Mostrar los nombres de todos los productos presentes en la subcategoría de ruedas
--tablas:Production.Product, Production.ProductSubcategory
--campos: ProductSubcategoryID, Name

select p.name, pscat.name 
from Production.Product as p
inner join Production.ProductSubcategory as pscat
on p.ProductSubcategoryID = pscat.ProductSubcategoryID
where pscat.name like '%wheels%'

select *
from   Production.Product
where  exists (
		       select * 
			   from   Production.ProductSubcategory
			   where  ProductSubcategoryID = Production.Product.ProductSubcategoryID
			   and    name like '%wheels%'
			  )

--Mostrar todos los productos que no fueron vendidos
--tablas:Production.Product, Sales.SalesOrderDetail
--campos: Name, ProductID

select p.productid,
       p.name producto
from   Production.Product p
where  not exists (
					select 1
					from sales.SalesOrderDetail sod
					where p.ProductID = sod.ProductID
				  )

--Mostrar la cantidad de personas que no son vendedores
--tablas: Person.Person, Sales.SalesPerson
--campos: BusinessEntityID  

select count(*)
from   person.Person p
where  not exists (
					select 1 from sales.SalesPerson s
					where p.businessEntityid = s.BusinessEntityID
				  )

--Mostrar todos los vendedores (nombre y apellido) que no tengan asignado un territorio de ventas
--tablas: Person.Person, Sales.SalesPerson, HumanResources.Employee
--campos: BusinessEntityID, TerritoryID ,LastName, FirstName

select			 sp.businessEntityid codigo,
				 p.lastname apellido,
				 p.firstname nombre
from			 sales.salesperson as sp
inner join		 HumanResources.Employee as e
on				 (e.BusinessEntityID = sp.businessEntityID)
inner join		 person.Person as p
on				 (e.businessentityid = p.businessentityid)
where not exists (
					select 1 from sales.SalesTerritory st
					where		  sp.territoryid = sp.territoryid
				 )

--Laboratorio "Sub Consultas con IN y Not IN"

--Mostrar las órdenes de venta que se hayan facturado en territorio de estado unidos únicamente 'us'
--tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
--campos: CountryRegionCode, TerritoryID

select salesorderid from Sales.SalesOrderHeader
where TerritoryID in (
					   select TerritoryID 
					   from sales.SalesTerritory
					   where CountryRegionCode = 'us'
					  )

--Al ejercicio anterior agregar ordenes de Francia e Inglaterra
--tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
--campos: CountryRegionCode, TerritoryID

select salesorderid
from   sales.SalesOrderHeader 
where  TerritoryID in (
						select TerritoryID
						from   sales.SalesTerritory
						where  CountryRegionCode = 'us'
						or
						CountryRegionCode = 'FR'
						or
						CountryRegionCode = 'GB'
					   )

select		*
from		sales.SalesOrderHeader s
where		s.TerritoryID in (
								select territoryid
								from   sales.SalesTerritory
								where  countryregioncode
								in     ('US','FR','GB')
							 )

--Mostrar los nombres de los diez productos más caros
--tablas:Production.Product
--campos: ListPrice



select name, listprice from Production.Product
where ListPrice in (select top 10 listprice from Production.Product
				    order by ListPrice desc
				   )

--Mostrar aquellos productos cuya cantidad de pedidos de venta sea igual o superior a 20
--tablas:Production.Product, Sales.SalesOrderDetail
--campos: Name, ProductID , OrderQty

select s.productid, p.name, s.orderqty as suma from Production.Product as p
inner join sales.SalesOrderDetail as s
on p.ProductID = s.ProductID
where s.orderqty >= 20

select name producto
from   Production.Product
where  ProductID in 
					(
					 select productid
					 from   sales.SalesOrderDetail
					 where  OrderQty >= 20
					)
order by name

--Laboratorio "Sub Consultas con ALL y ANY"

--Mostrar los nombres de todos los productos de ruedas que fabrica adventure works cycles
--tablas:Production.Product, Production.ProductSubcategory        
--campos: Name, ProductSubcategoryID

select name producto
from   production.product
where  productsubcategoryID = any (
									select productsubcategoryid
									from   production.productsubcategory
									where  name = 'Wheels'					
								  )

--Mostrar los clientes ubicados en un territorio no cubierto por ningún vendedor
--tablas:Sales.Customer, Sales.SalesPerson
--campos: TerritoryID

select * 
from   sales.Customer
where  TerritoryID <> ALL (
							select TerritoryID
							from   Sales.salesperson
						  )

--Listar los productos cuyos precios de venta sean mayores o iguales que el precio de venta máximo de cualquier subcategoría de producto.
--tablas:Production.Product
--campos: Name, ListPrice, ProductSubcategoryID

SELECT name producto
from   Production.Product
where  listprice >= any (
							select ProductSubcategoryID,
							max(listprice)
							From Production.Product
							group by ProductSubcategoryID
					    )

--Laboratorio "Expresión Case"

--Listar el nombre de los productos, el nombre de la subcategoría a la que pertenece junto a su categoría de precio. 
--La categoría de precio se calcula de la siguiente manera.
--		si el precio está entre 0 y 1000 la categoría es económica.
--		si la categoría está entre 1000 y 2000, normal
--		y si su valor es mayor a 2000 la categoría es cara.
--tablas:Production.Product, Production.ProductSubcategory
--campos: Name, ListPrice

select p.name producto,
	   listprice [precio de lista],
	   psc.name subcategoria,
	   (case
			 when listprice between 0 and 1000 then 'economica'
			 when listprice between 1000 and 2000 then 'normal'
			 else 'Cara'
	    end) as categoria
from   production.product p
inner join production.ProductSubcategory psc
on     (p.productsubcategoryID = psc.productsubcategoryID)

--Tomando el ejercicio anterior, mostrar únicamente aquellos productos cuya categoría sea "economica"
--tablas:Production.Product, Production.ProductSubcategory
--campos: Name, ListPrice 
select * from
(
select p.name producto,
	   listprice [precio de lista],
	   psc.name subcategoria,
	   (case
			 when listprice between 0 and 1000 then 'economica'
			 when listprice between 1000 and 2000 then 'normal'
			 else 'Cara'
	    end) as categoria
from   production.product p
inner join production.ProductSubcategory psc
on     (p.productsubcategoryID = psc.productsubcategoryID)
) mitabla
where mitabla.categoria = 'economica'
 

--Laboratorio "Insert, Update y Delete"

--Aumentar un 20% el precio de lista de todos los productos  
--tablas:Production.Product
--campos: ListPrice

--Aumentar un 20% el precio de lista de los productos del proveedor 1540
--tablas:Production.Product, Purchasing.ProductVendor
--campos: ProductID, ListPrice, BusinessEntityID


--Eliminar los detalles de compra (purchaseorderdetail) cuyas fechas de vencimiento pertenezcan al tercer trimestre del año 2006
--tablas: Purchasing.PurchaseOrderDetail
--campos: DueDate

--Laboratorio "Bulk Copy"

--Clonar estructura y datos de los campos nombre ,color y precio de lista de la tabla production.product en una tabla llamada productos
--tablas:Production.Product
--campos: Name, ListPrice,Color


--Clonar solo estructura de los campos identificador ,nombre y apellido de la tabla person.person en una tabla llamada productos
--tablas: Person.Person
--campos: BusinessEntityID,FirstName,LastName


--Insertar un producto dentro de la tabla productos.tener en cuenta los siguientes datos. el color de producto debe ser rojo, el nombre debe ser "bicicleta mountain bike" y el precio de lista debe ser de 4000 pesos.
--tablas:productos
--campos: Color,Name, ListPrice


--Copiar los registros de la tabla person.person a la tabla personas cuyo identificador esté entre 100 y 200
--tablas: Person.Person
--campos: BusinessEntityID,FirstName,LastName


--Aumentar en un 15% el precio de los pedales de bicicleta
--tablas: productos
--campos: Name, ListPrice


--Eliminar de las personas cuyo nombre empiece con la letra m
--tablas: personas
--campos: firstname


--Borrar todo el contenido de la tabla productos
--tablas: productos


--Borrar todo el contenido de la tabla personas sin utilizar la instrucción delete.
--tablas: personas

