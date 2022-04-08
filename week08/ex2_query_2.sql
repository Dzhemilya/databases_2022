--The company has decided to reward the best stores in each of the cities, so it is necessary to have a list of the stores that have made a greater number of sales in term of money during the last month recorded.
explain analyze select distinct on (ls.city_id) ls.*from (select c.city, c.city_id, s.store_id, sum(p.amount) as amount from store s inner join staff stf on stf.store_id=s.store_id inner join payment p on p.staff_id=stf.staff_id inner join "address" a on s.address_id = a.address_id inner join city c on a.city_id = c.city_id group by c.city_id, s.store_id) ls order by ls.city_id;

--Executing this query, we see, that most expensive operation is HashAggregate  (cost=583.30..598.30 rows=1200 width=49) (actual time=11.486..11.495 rows=2 loops=1). What can we do with it? This problem arises because we have many inner joins. We already have btree indexes in primary keys, so creating more indexes on id columns is useless. Making compound indexes with 2 columns from different tables is impossible in PostgreSQL. I can suppose, that creating precomputed views with these inner joins may make the situation better. 





