SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod, buyprod
WHERE buy_prod(+) = prod_id
AND buy_date(+) = '2005/01/25';

SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod ON(buy_prod = prod_id AND buy_date = '2005/01/25');

SELECT NVL(buy_date,'2005/01/25'), buy_prod, prod_id, prod_name, buy_qty
FROM prod LEFT OUTER JOIN buyprod ON(buy_prod = prod_id AND buy_date = '2005/01/25');

SELECT NVL(buy_date,'2005/01/25') buy_date, buy_prod, prod_id, prod_name, NVL(buy_qty,0) buy_qty
FROM prod LEFT OUTER JOIN buyprod ON(buy_prod = prod_id AND buy_date = '2005/01/25');


SELECT NVL(cycle.pid, product.pid) pid, pnm, NVL(cid, 1) cid, NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product LEFT OUTER JOIN cycle ON(cycle.pid = product.pid AND cid = '1');


SELECT NVL(cycle.pid, product.pid) pid, pnm, NVL(cycle.cid, 1) cid,
NVL(cnm, 'brown'), NVL(day, 0) day, NVL(cnt, 0) cnt
FROM product LEFT OUTER JOIN cycle ON(cycle.pid = product.pid AND cid = '1')
LEFT OUTER JOIN customer ON (cycle.cid = customer.cid);

