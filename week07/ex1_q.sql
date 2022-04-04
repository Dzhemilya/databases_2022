--queries task 1

--Calculate the total number of items per order and the total amount to pay for the order.
select a.orderid orderid, sum(b.quantity) quantity, sum(b.quantity * c.price) amount from orders a, orderslist b, items c, customers d where a.orderid = b.orderid and b.itemid = c.itemid and a.customerid = d.customerid group by a.orderid order by a.orderid;

--Obtain the customer whose purchase in terms of money has been greater than the others
select c.customer_name from orderslist a, items b, orders o, customers c where a.orderid = o.orderid and a.itemid = b.itemid and o.customerid = c.customerid group by c.customerid having sum(a.quantity * b.price) >= all(select sum(a.quantity * b.price) amount from orderslist a, items b, orders o, customers c where a.orderid = o.orderid and a.itemid = b.itemid and o.customerid = c.customerid group by c.customerid);
