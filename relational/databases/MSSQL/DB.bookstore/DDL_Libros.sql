/* DDL de Creacion de Tablas */

CREATE TABLE LIBRO (NRO_LIBRO int not null, 
                     TITULO char(40),
                     AUTOR char(30),
                     TIPO char(2),
                     PRECIO_ORI decimal(10,2),
                     PRECIO_ACT decimal(10,2),
                     EDICION smallint);

CREATE TABLE TIPOLIBRO (TIPO char(2),
			DESCTIPO char(40));

CREATE TABLE LECTOR (NRO_LECTOR int,
                     NOMBRE char(22),
                     DIRECCION char(30),
                     TRABAJO char(10),
                     SALARIO decimal(10,2));

CREATE TABLE COPIA (NRO_LIBRO int,
                       NRO_COPIA smallint
                       );

CREATE TABLE PRESTAMO (NRO_LECTOR int,
                       NRO_LIBRO int,
                       NRO_COPIA smallint,
                       F_PREST datetime,
                       F_DEVOL datetime);

