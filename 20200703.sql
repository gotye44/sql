join1)

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM lprod, prod
WHERE lprod.lprod_gu = prod.prod_lgu;

SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM lprod JOIN prod ON (lprod.lprod_gu = prod.prod_lgu);


join2)

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id);

join3)

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE mem_id = cart_member
AND prod_id = cart_prod;

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM
(SELECT mem_id, mem_name, cart_qty, cart_prod
FROM member, cart, prod
WHERE mem_id = cart_member) a, prod
WHERE a.cart_prod = prod_id;



SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON(mem_id = cart_member)
      JOIN prod ON (prod_id = cart_prod);

join4)

COUSTOMER : 고객
PRODUCT : 제품
CYCLE(주기) : 고객 제품 애음 주기


SELECT customer.cid, cnm, pid, day, cnt
FROM customer, cycle
WHERE customer.cid = cycle.cid
AND (cnm = 'brown' OR cnm = 'sally');

SELECT customer.cid, cnm, pid, day, cnt
FROM customer JOIN cycle ON (customer.cid = cycle.cid)
WHERE cnm = 'brown' OR cnm = 'sally';


join5)

SELECT customer.cid, cnm, product.pid, pnm, day, cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND product.pid = cycle.pid 
AND (cnm = 'brown' OR cnm = 'sally');

SELECT customer.cid, cnm, product.pid, pnm, day, cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid) JOIN product ON (cycle.pid = product.pid)
WHERE cnm = 'brown' OR cnm = 'sally';


join6)


SELECT customer.*, product.pid, pnm, SUM(cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND product.pid = cycle.pid 
GROUP BY customer.cid, cnm, product.pid, pnm;

SELECT cnm, product.pid, pnm, cycle.*
FROM
(SELECT cid, pid, SUM(cnt)
FROM cycle
GROUP BY cid, pid) cycle, customer, product
WHERE customer.cid = cycle.cid
AND product.pid = cycle.pid;

join7)
SELECT cycle.pid, pnm
FROM cycle, product
WHERE product.pid = cycle.pid 
GROUP BY customer.cid, cnm, product.pid, pnm;


조인 성공 여부로 데이터 조회를 결정하는 구분방법
INNER JOIN : 조인에 성공하는 데이터만 조회하는 조인 방법
OUTTER JOIN : 조인에 실패 하더라도, 개발자가 지정한 기준이 되는 테이블의
            데이터는 나오도록 하는 조인

복습 - 사원의 관리자 이름을 알고싶은 상황
조회 컬럼 : 사원의 사번, 사원의 이름, 사원의 관리자의 사번, 사원의 관리자의 이름

동일한 테이블끼리 조인 되었기 때문에 : SELP-JOIN
조인 조건을 만족하는 데이터만 조회 되었기 때문에 : INNER-JOIN
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;


KING의 경우 PRESIDENT이기 떄문에 mgr 컬럼의 값이 NULL ==> 조인에 실패
==> KING의 데이터는 조회되지 않음(총 14건 데이터중 13건의 데이터만 조인 성공)

OUTER 조인을 이용하여 조인 테이블중 기준이 되는 테이블을 선택하면
조인에 실패하더라도 기준 테이블의 데이터는 조회 되도록 할 수 있다.
LEFT / RIGHT OUTER
ANSI-SQL
테이블1 JOIN 테이블2 ON(조건)
테이블1 LEFT OUTER JOIN 테이블2 ON(조건)
위 쿼리는
테이블2 RIGHT OUTER JOIN 테이블1 ON(조건)

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);


