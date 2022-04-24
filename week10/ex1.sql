create database ex1_week10
create table accounts(uid int not null primary key, name varchar(50), credit decimal, currency varchar(50));
insert into accounts(uid, name, credit, currency) values (1, 'Xavier', 1000, 'RUB');
insert into accounts(uid, name, credit, currency) values (2, 'Hamza', 1000, 'RUB');
insert into accounts(uid, name, credit, currency) values (3, 'Darko', 1000, 'RUB');

--ex 1, page 1

begin; --T1
savepoint T1; 
update accounts set credit = credit-500.00 where uid=1; update accounts set credit =credit+500.00 where uid=3; 
select credit from accounts;
rollback to T1; 
select credit from accounts;
commit;

begin; --T2
savepoint T2;
update accounts set credit=credit-700.00 where uid=2; update accounts set credit=credit+700.00 where uid=1; 
select credit from accounts;
rollback to T2;
select credit from accounts;
commit;

begin;
savepoint T3;
update accounts set credit =credit-100.00 where uid=2; update accounts set credit=credit+100.00 where uid=3; 
select credit from accounts;
rollback to T3;
select credit from accounts;
commit;

--ex 1, page 2, 3


alter table accounts add column bank_name text;
update accounts set bank_name = 'SberBank' where uid in (1, 3);
update accounts set bank_name = 'Tinkoff'  where uid = 2;
insert into accounts values (4, 'Account 4', 0, 'RUB', null); --account for bank fee record

create table ledger(uid SERIAL, from_uid int not null, to_uid int not null,	fee decimal not null, amount decimal not null, date_of_transaction TIMESTAMPTZ not null, primary key (uid), foreign key (from_uid) references accounts(uid), foreign key (to_uid) references accounts(uid));


create or replace function transaction_with_fee(from_uid INT, to_uid INT, amount DECIMAL) returns table	(uid INT, name VARCHAR, credit DECIMAL, currency VARCHAR, bank_name text) as
$$
#variable_conflict use_column -- to not use uid_ in the arguments, plpgsql will understand the difference between output and the input
	begin
		update accounts set credit = credit + amount where uid = to_uid;
		update accounts set credit = credit - amount where uid = from_uid;
-- 		transfer_the_money(from_uid, to_uid, amount);
		if 
            exists (select 1 from accounts as a1, accounts as a2 where a1.uid = from_uid and a2.uid = to_uid and a1.bank_name != a2.bank_name) then
			update accounts set credit = credit - 30 WHERE uid = to_uid;
			update accounts set credit = credit + 30 WHERE uid = 4;
			insert into ledger (from_uid, to_uid, fee, amount, date_of_transaction) values (from_uid, to_uid, 30, amount, NOW());
		else
			insert into ledger (from_uid, to_uid, fee, amount, date_of_transaction) values (from_uid, to_uid, 0, amount, NOW());
		end if;
		RETURN QUERY 
			select * from accounts;
	end	
$$ LANGUAGE plpgSQL;

select transaction_with_fee(1, 2, 700);
select * from ledger;
select sum(credit) from accounts;






