 Consulta 1:
 Mostrar el nombre, precio y precio con iva de los productos fabricados.
 Dónde los precios sean diferentes a cero. Redondear el resultado en ambos.
 tablas: Product
 campos: Name,ListPrice

 Consulta 2:
 Mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea johnson
 tablas: contact
 campos: FirstName,LastName

 Consulta 3:
 Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo precio sea mayor a 500$ de color negro
 tablas: Product
 campos: productid, name, ListPrice,Color

 Consulta 4:
 Mostrar todos los empleados que nacieron entre 1970 y 1985
 tablas: Employee
 campos: BirthDate

 Consulta 5:
 Mostrar el nombre y precio de los accesorios para asientos de las bicicletas cuyo precio sea mayor a 100 pesos
 tablas: Product
 campos: Name,ListPrice,Color

 Consulta 6:
 Mostrar los nombres de los productos que tengan cualquier combinación de 'mountain bike'
 tablas: Product
 campos: Name,ListPrice

 Consulta 7:
 Mostrar los empleados que la segunda letra de su apellido es una s
 tablas: contact
 campos: LastName

 Consulta 8:
 Mostrar los nombres de los productos que su nombre termine en un número
 tablas: Product
 campos: Name

 Consulta 9:
 Mostrar la fecha más reciente de venta
 tablas: SalesOrderHeader
 campos: OrderDate

 Consulta 10:
 Mostrar el precio más barato de todas las bicicletas
 tablas: Product
 campos: ListPrice, ProductNumber

 Consulta 11:
 Mostrar los representantes de ventas (vendedores) que no tienen definido el número de territorio
 tablas: SalesPerson
 campos: TerritoryID


 Consulta 12:
 Mostrar todas las facturas realizadas y el total facturado de cada una de ellas 
 ordenado por número de factura  pero sólo de aquellas órdenes superen un total de $10.000
 tablas: SalesOrderDetail
 campos: SalesOrderID,UnitPrice,OrderQty

 Consulta 13:
 Mostrar la cantidad de facturas que vendieron más de 20 unidades
 tablas: SalesOrderDetail
 campos: SalesOrderID, OrderQty

 Consulta 14:
 Mostrar las subcategorías de los productos que tienen dos o más productos que cuestan menos de $150
 tablas: Product
 campos: ProductSubcategoryID, ListPrice

 Consulta 15:
 Mostrar todos los códigos de categorías existentes junto con la cantidad de productos
 y el precio de lista promedio por cada uno de aquellos productos 
 que cuestan más de $ 70 y el precio promedio es mayor a $ 300.
 tablas: Product
 campos: ProductSubcategoryID, ListPrice

 "Sub Consultas"

 Consulta 16:
 Listar todos los productos cuyo precio sea inferior al precio promedio de todos los productos
 tablas: Production.Product
 campos: Name, ListPrice

 Consulta 17:
 Listar el nombre, precio de lista, precio promedio y diferencia de precios entre cada producto y el valor promedio general
 tablas: Product
 campos: Name, ListPrice

 Consulta 18:
 Mostrar el o los códigos del producto más caro
 tablas: Product
 campos: ProductID,ListPrice

 Consulta 19:
 Mostrar el producto más barato de cada subcategoría. 
 mostrar subcategoría, código de producto y el precio de lista más barato ordenado por subcategoría
 tablas: Product
 campos: ProductSubcategoryID, ProductID, ListPrice

 Consulta 20:
 Mostrar las órdenes de venta que se hayan facturado en territorio de estado unidos únicamente 'us'
 tablas: SalesOrderHeader, SalesTerritory
 campos: CountryRegionCode, TerritoryID

 Consulta 21:
 Mostrar aquellos productos cuya cantidad de pedidos de venta sea igual o superior a 20
 tablas: Product, SalesOrderDetail
 campos: Name, ProductID , OrderQty

 Joins

 Consulta 22:
 Mostrar los empleados que también son vendedores
 tablas: Employee ,  SalesPerson
 campos: EmployeeID, SalespersonID

 Consulta 23:
 Mostrar los productos que sean ruedas
 tablas: Product, ProductSubcategory
 campos: Name 


 Consulta 24:
 Mostrar los nombres de los productos que no son bicicletas
 tablas: Product, ProductSubcategory
 campos: Name

 Consulta 25:
 Mostrar los precios de venta de aquellos productos donde el 
 precio de venta sea inferior al precio de lista recomendado para ese producto ordenados por nombre de producto
 tablas: SalesOrderDetail ,  Product
 campos: ProductID,Name,ListPrice,UnitPrice

 Consulta 26:
 ¿Join de la misma tabla?
 Mostrar todos los productos que tengan igual precio.
 Se deben mostrar de a pares, código y nombre de cada uno de los dos productos y el precio de ambos. ordenar por precio en forma descendente
 tablas: Product
 campos: ProductID, ListPrice

 Consulta 27:
 Mostrar todos los productos que tengan igual precio. 
 Se deben mostrar de a pares. código y nombre de cada uno de los dos productos y el precio de ambos mayores a $15
 tablas: Product
 campos: ProductID, ListPrice

 Consulta 28:

 ¿Cross Join?
 Mostrar el producto cartesiano entre la tabla de vendedores cuyo número de identificación de negocio sea 280
 y el territorio de venta sea el de Francia
 tablas: SalesPerson , SalesTerritory
 campos: SalesPersonID

Consulta 29:
Crear una vista llamada 'Productos' con la siguiente estructura:
Campo	Tabla
salesOrderID	salesorderdetail
order date	salesorderheader
productName	product
nombre categoría	product category
makeFlay	product
color	product
Order QTY	salesorderheader
Unit Price	salesorderheader
customer Name	store
SalesPersonId	salesorderheader
shiped metod	shipmethod

 No vamos a tener en cuenta los registros que tengan al menos un valor null. 
¿Qué join debemos utilizar para descartar los valores null?
