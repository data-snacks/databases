-- 1- Usar la base de datos World
use world;

-- 2- Mostrar todas las tablas de la base World
show tables;

-- 3- Mostrar la definición de la tabla city (Describe)
describe city;

-- 4- Mostrar la definición de la tabla country (Describe)
describe country;

-- 5- Mostrar la definición de la tabla countrylanguage (Describe)
describe countrylanguage;

-- 6- Mostrar todas las ciudades y sus atributos
SELECT * from city;

-- 7- Mostrar todos los paises y sus atributos
SELECT * from country;

-- 8- Mostrar todos los lenguajes y sus atributos
SELECT * from countrylanguage;

-- 9- Seleccione el nombre de los países que se encuentra en Asia. Ordenado alfabeticamente, por nombre, de la A a la Z.
SELECT name, continent from country
where continent = 'Asia'
order by name;

Select name, continent from country
where continent in ('Asia')
order by name;

-- 10- Seleccione el nombre y el continente de los países que se encuentra en America. Ordenado, por nombre, de la Z a la A.
SELECT name, continent from country
where continent like '%America'
order by name desc;

-- 11- ¿Cuántos países tiene la base?
select count(code) as cantidad from country;

-- 12- ¿Cuántos idiomas tiene la tabla countrylanguage? 
select count(language) as idiomas 
from countrylanguage
order by idiomas;

-- 13- ¿Cuántos idiomas únicos tiene la tabla countrylanguage?
select count(distinct(language)) as idiomas 
from countrylanguage
order by idiomas;

-- 14- Crear una lista sólo con los idiomas únicos, o sea, no mostrar los duplicados. Ordenar el restultado de manera descendente.
select distinct(language) as idiomas 
from countrylanguage
order by idiomas desc;

-- 15- ¿Cuántos países están en América del norte y cuántos en américa del Sur?
select continent, count(code) from country
where continent like '%America'
group by continent;

-- 16- Muestre sólo los idiomas oficiales
select language as idiomas, isofficial
from countrylanguage
where isofficial = 'T'
order by idiomas;

-- 17- ¿Cuántos idiomas oficiales tenemos?
select count(isofficial) as idiomas_oficiales
from countrylanguage
where isofficial = 'T';

-- 18-  Seleccionar nombre y población de los países. 
-- 			Ordenar los resultados para que el país con más poblacion quede primero.
-- 			Resultado de la consulta: pais | poblacion
select name as pais, population as poblacion from country
order by poblacion desc;

-- 19- Seleccionar nombre y población de los países. 
-- 			Ordenar los resultados para que el país con menor poblacion quede primero.
--          Los paises con población 0 no deben mostrarse.
-- 			Resultado de la consulta: pais | poblacion
select name, population as poblacion from country
where population != 0
order by poblacion;

-- 20- Mostrar sólo el país con mayor población

-- Solución dos pasos: 
-- 		1. busco el valor de la población 
select max(population) from country;
--      2. lo pego a mano en la consulta
select name, population from country
where population = 1277558000;

-- Solución correcta: Consulta con subconsulta.
select name, population from country
where population = (select max(population) from country);

-- 21- Mostrar sólo el país con menor población. El resultado tiene que ser distinto de cero.

-- Solución dos pasos: 
-- 		1. busco el valor de la población 
select min(population) from country
where population > 0;
--      2. lo pego a mano en la consulta
select name, population from country
where population = 50;

-- Solución correcta: Consulta con subconsulta.
select name, population from country
where population = (select min(population) from country where population != 0);

-- 22- Mostrar los paises y sus nombres con población entre 160 y 1.300 millones de habitantes. Ordenar de mayor a menor.
set @millon = 1000000;
select name, population from country
where population between 160*@millon and 1300000000 * @millon
order by population desc;

-- 23- Mostrar el top 5 de paises con mayor población. Ordenar de mayor a menor.
select population, name from country
order by population desc LIMIT 5;

-- 24- ¿Cuál es el promedio de población mundial?
select avg(population) as poblacion_promedio from country;

-- 25- ¿Cuántos países tienen más habiantes que el promedio mundial?

select count(code) as mayor_promedio from country
where population > 25434098;

-- Solución Correcta: Consulta con subconsulta
select count(code) from country
where population > (select avg(population) as poblacion_promedio from country);

-- 26- ¿Cuántos países tienen menos habitantes que el promedio mundial?
select count(code) as mayor_promedio from country
where population < 25434098;

-- Solución Correcta: Consulta con subconsulta
select count(code) from country
where population < (select avg(population) as poblacion_promedio from country);