create database ex1_week10
create table accounts(id int not null primary key, name varchar(50), credit int, currency varchar(50));
insert into accounts(id, name, credit, currency) values (1, 'Xavier', 1000, 'RUB');
insert into accounts(id, name, credit, currency) values (2, 'Hamza', 1000, 'RUB');
insert into accounts(id, name, credit, currency) values (3, 'Darko', 1000, 'RUB');

begin; 
savepoint beforetrnasactions; 
update accounts set credit = credit-500.00 where id=1; update accounts set credit =credit+500.00 where id=3; 
savepoint transact1; 
update accounts set credit=credit-700.00 where id=2; update accounts set credit=credit+700.00 where id=1; 
savepoint transact2; 
update accounts set credit =credit-100.00 where id=2; update accounts set credit=credit+100.00 where id=3; 
commit;

begin; savepoint beforetrnasactions; update accounts set credit = credit-500.00 where id=1; update accounts set credit =credit+500.00 where id=3; savepoint transact1; update accounts set credit=credit-700.00 where id=2; update accounts set credit=credit+700.00 where id=1; savepoint transact2; update accounts set credit =credit-100.00 where id=2; update accounts set credit=credit+100.00 where id=3; rollback to beforetransactions; commit;


