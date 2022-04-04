CREATE DATABASE ex1_week07;
--creating tables
create table orders(orderid int primary key, orderdate DATE NOT NULL, customerid INT NOT NULL); 
create table items(itemid int primary key, item_name VARCHAR(255) NOT NULL, price INT NOT NULL); 
create table customers(customerid int primary key, customer_name VARCHAR(255) NOT NULL, city VARCHAR(255) NOT NULL); 
create table orderslist(orderlistid int not null primary key, orderid int not null, itemid int not null, quantity int not null); 
--adding foreign keys
alter table orders add constraint FK_customerid foreign key (customerid) references customers (customerid);
alter table orders add constraint FK_orderlist foreign key (orderlistid) references orderslist (orderlistid);
alter table orders add column orderlistid int not null;
alter table orders add constraint FK_orderlist foreign key (orderlistid) references orderslist (orderlistid);
--insering values
insert into customers (customerid, customer_name, city) values (101, 'Martin', 'Prague'), (107, 'Herman', 'Madrid'), (110, 'Pedro', 'Moscow');
insert into items (itemid, item_name, price) values (3786, 'Net', 35), (4011, 'Racket', 65), (9132, 'Pack-3', 4), (5794, 'Pack-6', 5), (3141, 'Cover', 10); 
--change orders primary key to compound values of orderid and orderlistid
SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE  ;
alter table orders drop constraint orders_pkey;
alter table orders add primary key (orderid, orderlistid);
insert into orderslist (orderlistid, orderid, itemid, quantity) values (1, 2301, 3786, 3), (2, 2301, 4011, 6), (3, 2301, 9132, 8), (4, 2302, 5794, 4), (5, 2303, 4011, 2), (6, 2303, 3141, 2); 
