--The company is preparing its campaign for next Halloween, so the list of movies that have not been rented yet by the clients is needed, whose rating is R or PG-13 and its category is Horror or Sci-fi
explain analyze select distinct on (f.film_id) f.title, i.inventory_id , f.film_id from film_category fc inner join film f on f.film_id=fc.film_id inner join category c on c.category_id=fc.category_id inner join inventory i on f.film_id = i.film_id where c.name in ('Horror','Sci-fi') and rating in ('R','PG-13') and i.inventory_id not in (select inventory_id from rental) order by f.film_id;

-- From the explain analysis we can conclude that most expensive step of this querie is Seq Scan on rental (cost=0.00..310.44 rows=16044 width=4). We can use indexes in order to simplify the comparison. 
-- Thus, we can create index for better performance 
create index idx_inventory_id on rental(inventory_id);
create index idx_name on category (name);
create index idx_name on category (name);

--after executing same query with created indexes, we can see, that cost of Seq Scan on rental operation is fallen from 0.00..327.00 to 0.00..310.44.



