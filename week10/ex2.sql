drop table if exists users;
create table if not exists users(username text, fullname text, balance int not null, group_id int not null, pr│psql (14.2 (Ubuntu 14.2-1.pgdg20.04+1+b1))
imary key (username));
insert into users values ('jones', 'Alice Jones', 82, 1), ('bitdiddl', 'Ben Bitdiddle', 65, 1), ('mike', 'Michael Dole', 73, 2), ('alyssa', 'Alyssa P.Hacker', 79, 3), ('bbrown', 'Bob Brown', 100, 3);
SELECT * FROM users; 

--ex 2 test with Read committed, Repeatable read isolation levels

--test with read committed

--Do both terminals show the same information? Explain the reason 
--No changes in terminal 1, since we didn't commit anything in the terminal 2. because
--READ COMMITTED guarantees that any data is read is committed at the moment it is read

--Commit the changes and compare again both sessions. 
--After commit, T1 and T2 shows the same data.

--terminal 1
--Start a transaction and display the accounts information.
begin;
set transaction isolation level read committed;
SELECT * FROM users; 
--Display again the accounts table 
SELECT * FROM users; 
--Update the balance for the Alice’s account by +10
update users set balance = balance + 10 where username='ajones';
commit;
SELECT * FROM users; 
SELECT * FROM users; 

--terminal 2
--Start a transaction and update the username for “Alice Jones” as “ajones” 
begin;
set transaction isolation level read committed;
update users set username='ajones' where username='jones';
--Display again the accounts table
SELECT * FROM users; ;
--Commit the changes and compare again both sessions. 
commit;
SELECT * FROM users; 
--Start a new transaction 
begin;
set transaction isolation level read committed;
--Update the balance for the Alice’s account by +20
UPDATE users SET balance = balance + 20 WHERE username = 'ajones';
SELECT * FROM users; 
rollback;

--test with repeatable read
--terminal 1
begin;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM users;
SELECT * FROM users;

UPDATE users SET balance = balance + 10 WHERE username='ajones';
END;
SELECT * FROM users;
--terminal 2
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
update users set username='ajones' where username='jones';
UPDATE users SET balance = balance + 20 WHERE username='ajones';
ROLLBACK;
SELECT * FROM users;



--EXERCISE 2 TASK 2
--FOR  READ COMMITTED

--terminal 1
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM users WHERE group_id = 2;
SELECT * FROM users WHERE group_id = 2;
UPDATE users SET balance = balance + 15 WHERE group_id = 2;
COMMIT;
SELECT * FROM users WHERE group_id = 2;

--terminal 2
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE users SET group_id = 2 WHERE username='bbrown';
COMMIT;
SELECT * FROM users;

--FOR REPEATABLE READ

--termial 1
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM users WHERE group_id = 2;
SELECT * FROM users WHERE group_id = 2;
SELECT * FROM users WHERE group_id = 2;
UPDATE users SET balance = balance + 15 WHERE group_id = 2;
COMMIT;
SELECT * FROM users WHERE group_id = 2;

--terminal 2
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
UPDATE users SET group_id = 2 WHERE username = 'bbrown';
COMMIT;
