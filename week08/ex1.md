1) explain analyze select * from customer c where c.name like 'Brandon%';

```bash 
 Seq Scan on customer c  (cost=0.00..4286.23 rows=986 width=211) (actual time=0.023..20.747 rows=460 loops=1)
   Filter: (name ~~ 'Brandon%'::text)
   Rows Removed by Filter: 99540
 Planning Time: 0.164 ms
 Execution Time: 20.796 ms
(5 rows)
```

```sql
create index idx_name on customer(name);
explain analyze select * from customer c where c.name like 'Brandon%';
```

```bash
Seq Scan on customer c  (cost=0.00..4286.00 rows=986 width=211) (actual time=0.024..18.760 rows=460 loops=1)
   Filter: (name ~~ 'Brandon%'::text)
   Rows Removed by Filter: 99540
 Planning Time: 0.670 ms
 Execution Time: 18.816 ms
```

 2)explain analyze select * from customer c where c.address = '%Richmond Plaza%';

```bash
Seq Scan on customer c  (cost=0.00..4286.00 rows=1 width=211) (actual time=17.157..17.158 rows=0 loops=1)
   Filter: (address = '%Richmond Plaza%'::text)
   Rows Removed by Filter: 100000
 Planning Time: 0.183 ms
 Execution Time: 17.183 ms
(5 rows)
```

```sql
 create unique index idx_address on customer using btree (address);
 explain analyze select * from customer c where c.address = '%Richmond Plaza%';
```

```bash
Index Scan using idx_address on customer c  (cost=0.42..8.44 rows=1 width=211) (actual time=0.096..0.097 rows=0 loops=1)
   Index Cond: (address = '%Richmond Plaza%'::text)
 Planning Time: 0.445 ms
 Execution Time: 0.129 ms
```
