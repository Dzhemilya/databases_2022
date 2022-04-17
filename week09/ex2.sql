--creating function retrievecustomers for ex2
create or replace function retrievecustomers(ID_FROM INT, ID_TO INT) returns table(first_name VARCHAR(45), last_name VARCHAR(45), address_id SMALLINT) as $$ begin IF ID_TO > 600 or ID_FROM < 0 OR  ID_FROM > ID_TO then raise exception 'Incorrect ID, insert id from 0 till 599'; end if; return query select cus.first_name, cus.last_name, cus.address_id from customer as cus where cus.customer_id between ID_FROM and ID_TO order by address_id; end; $$ language plpgsql; 
-- TEST the function
select * from retrievecustomers(10,40);
--! Testing exceptions: "Incorrect ID, insert id from 0 till 599"
select * from retrievecustomers(-10,40);

