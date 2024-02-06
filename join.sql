create table products (
	id int not null auto_increment,
    name varchar(50) not null,
    created_by int not null,
	marca varchar(50) not null,
    primary key(id),
    foreign key(created_by) references user(id)
);
-- renombrar tablas
rename table products to product;

insert into product (name, created_by, marca)
values
	('ipad', 1, 'apple'),
    ('iphone', 2, 'apple'),
    ('watch', 2, 'apple'),
    ('macbook', 1, 'apple'),
    ('imac', 3, 'apple'),
    ('ipad mini', 2, 'apple');
    
select * from product;
-- Left join: se toman todos los datos de la tabla de usuarios que puedan entrar al coincidir con la tabla de product
select u.id, u.email, p.name from user u left join product p on u.id = p.created_by;
-- Right join, si en el left join usamos el user que era el de la izquierda, 
-- ahora los datos los tomaremos del de la derecha que es product
select u.id, u.email, p.name from user u right join product p on u.id = p.created_by;
-- Inner join: se juntan ambos ambos de las tablas siempre y cuando puedan coincidir
select u.id, u.email, p.name from user u inner join product p on u.id = p.created_by;
-- Cross join: se cruzan todos los user con todos los productos
select u.id, u.name, p.id, p.name from user u cross join product p;

-- Group by
select count(id), marca from product group by marca;
select count(p.id), u.name from product p left join user u on u.id = p.created_by group by p.created_by;

select count(p.id), u.name from product p left join user u on u.id = p.created_by group by p.created_by having count(p.id) >= 2;

drop table product;
drop table animales;
drop table user;

-- Otra forma de hacer JOIN
select * from customers join orders on customers.customerID = orders.customerID

-- Con condicionales y eligiendo determinados campos
select OrderID, C.CustomerID, CompanyName, OrderDate FROM Customers C
	join Orders O on C.CustomerID = O.CustomerID
where O.CustomerID = 'ALFKI'

-- Combinar con mas de dos tablas
select OrderID, C.CustomerID, CompanyName, OrderDate, E.FirstName || ' ' || E.LastName AS Comercial FROM Customers C
	join Orders O on C.CustomerID = O.CustomerID
	join Employees E on O.EmployeeID = E.EmployeeID
where C.Country = 'Spain' and O.EmployeeID = 5

-- Realizar una consulta para una tabla que tiene dos ID dentro de ella
select E1.EmployeeID, E1.FirstName || ' ' || E1.LastName AS Jefe,
	E2.FirstName || ' ' || E2.LastName AS Empleado 
FROM Employees E1 join Employees E2 on E2.ReportsTo = E1.EmployeesID

-- Subconsultas

select CustomerID, CompanyName FROM Customers
where CustomerID NOT IN (select distinct CustomerID from Orders)

select CustomerID, CompanyName from Customers C
where (select count(CustomerID) from Orders O where O.CustomerID = C.CustomerID) = 0

EXPLAIN QUERY PLAN
select CustomerID, CompanyName from Customer C
where (select OrderID from Orders O where O.CustomerID) is null

select ProductName, UnitPrice,
(select sum(UnitPrice*Quantity*(1-Discount) as VentasTotales from OrderDetails OD where OD.ProductID = P.ProductID) as VentasTotales
from Products P
where VentasTotales >= 100
order by VentasTotales desc

-- Conjuntos
select Country from Customers 
-- Podemos poner UNION, UNION ALL, EXCEPT e INTERCEPT entre estos dos select
select ShipCountry from Orders

-- Group By y Estadisticos, having funciona como un where pero para agregados y va despues del group by
select count(*) as TotalFiles, count(ShippedDate) as PedidosYaEnviados,
min(ShipppedDate) as FechaMin, max(ShipppedDate) as FechaMax,
sum(Freight) as PesoTotal, avg(Freight) as PesoMedio
from Orders

select Employee.FirstName || ' ' || Employees.LastName as Comercial, 
Shippers.CompanyName as Transportista,
count(*) as TotalFiles count(ShippedDate) as NumPedidosYaEnviados,
min(ShipppedDate) as FechaMin, max(ShipppedDate) as FechaMax,
sum(Freight) as PesoTotal, avg(Freight) as PesoMedio
from Orders
join Employees on Orders.Employee = Employee.EmployeeID
join Shippers on Orders.ShipVia = Shippers.ShipperID
where Employees.ReportTo is not null
group by Comercial, Transportista
HAVING PesoTotal > 3000 and NumPedidosYaEnviados > 4
order by Comercial, NumPedidosYaEnviados desc
