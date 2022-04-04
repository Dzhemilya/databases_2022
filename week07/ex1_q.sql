--queries task 1

--Calculate the total number of items per order and the total amount to pay for the order.
SELECT a.orderid orderid, SUM(b.quantity) quantity, SUM(b.quantity * c.price) amount 
FROM orders a, orderslist b, items c, customers d
WHERE a.orderid = b.orderid AND b.itemid = c.itemid AND a.customerid = d.customerid
GROUP BY a.orderid
ORDER BY a.orderid;

--Obtain the customer whose purchase in terms of money has been greater than the others
SELECT c.customer_name
FROM orderslist a,
     items b,
     orders o,
     customers c
WHERE a.orderid = o.orderid
  AND a.itemid = b.itemid
  AND o.customerid = c.customerid
GROUP BY c.customerid
HAVING SUM(a.quantity * b.price) >= ALL
  (SELECT SUM(a.quantity * b.price) amount
   FROM orderslist a, items b, orders o, customers c
   WHERE a.orderid = o.orderid
     AND a.itemid = b.itemid
     AND o.customerid = c.customerid
   GROUP BY c.customerid);
