create database holamundo;
show databases;
use holamundo;
CREATE TABLE animales (
	id int,
    tipo varchar(255),
    estado varchar(255),
    PRIMARY KEY (id)
);

-- INSERT INTO animales (tipo, estado) VALUES ('chanchito', 'feliz');

ALTER TABLE animales MODIFY COLUMN id int auto_increment;

SHOW CREATE TABLE animales;

CREATE TABLE `animales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(255) DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO animales (tipo, estado) VALUES ('chanchito', 'feliz');
INSERT INTO animales (tipo, estado) VALUES ('dragon', 'feliz');
INSERT INTO animales (tipo, estado) VALUES ('felipe', 'triste');

-- Seleccionar elementos dentro de una tabla
-- Con esto listamos la tabla, se muestra toda
SELECT * FROM animales; 
-- Para mostrar determinado registro
SELECT * FROM animales WHERE id = 1;
-- Con un valor como el estado nos puede mostrar más registros
SELECT * FROM animales WHERE estado = 'feliz'; 
-- Se agrega un nuevo condicional 
SELECT * FROM animales WHERE estado = 'feliz' AND tipo = 'chanchito'; 
-- Actualizar registro, en este caso cambiamos el estado de felipe de triste a feliz
UPDATE animales SET estado = 'feliz' where id = 4;

SELECT * FROM animales;

DELETE from animales where estado = 'feliz';
-- Lo anterior genera un error de seguridad creado por SQL 
-- para evitar todos los registros
-- Error Code: 1175. 
-- You are using safe update mode and you tried to update a table, 
-- without a WHERE that uses a KEY column.  To disable safe mode, 
-- toggle the option in Preferences -> SQL Editor and reconnect.

DELETE from animales where id = 1;
SELECT * FROM animales;

UPDATE animales set estado = 'triste' where tipo = 'dragon';
-- esto tambien arroja error 1175
UPDATE animales set estado = 'triste' where id = 5;
SELECT * FROM animales;

-- Ejemplos de condicionales
SELECT FirstName || ' ' || LastName AS Nombre, City AS Ciudad, Region AS [Areá Geografica]
from Employees
WHERE Country = 'USA'
ORDER BY LastName DESC
-- Distinct nos ayuda a mostrar los valores unicos de una columna
select distinct Region from customers
-- Like nos ayuda 
select * from Customers where region like 'Europe'
