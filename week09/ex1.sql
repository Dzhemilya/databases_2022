--Exercise 1•From DVD rental database Table address have column address as text (you want to convert address to Longitude/latitude and create new two columns in address table).
alter table address add column longitude integer default 0;
alter table address add column latitude integer default 0;

--Create Function to retrieve addresses that contains “11” and city_id between 400-600

create or replace function ex1(addr_text varchar(45), addr_id_from int, addr_id_to int) 
returns table ("address" varchar(45))  
as 
$$ 
begin 
return query 
select a.address from address as a having a.address like addr_text and a.city_id between addr_id_from and addr_id_to; 
end; 
$$ 
language plpgsql;
select * from ex1('%11%', 400, 600);
