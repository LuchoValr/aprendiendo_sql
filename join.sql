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