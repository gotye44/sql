OUTER JOIN < == > INNER JOIN

INNER JOIN : 조인 조건을 만족하는 (조인에 성공하는) 데이터만 조회
OUTER JOIN : 조인 조건을 만족하지 않더라도(조인에 실패 하더라도) 기준이 되는 테이블 쪽읜
            데이터(컬럼)은 조회가 되도록 하는 조인 방식;

OUTER JOIN : 
    LEFT OUTER JOIN : 조인 키워드의 왼쪽에 위치하는 테이블을 기준삼아 OUTER JOIN 시행
    RIGHT OUTER JOIN : 조인 키워드의 오른쪽에 위치하는 테이블을 기준삼아 OUTER JOIN 시행
    FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - 중복되는것 제외

OUTER JOIN 시 조인조건(ON 절에 기술)과 일반 조건(WHERE 절에 기술)적용시 주의사항
OUTER JOIN을 사용하는데 WHERE 절에 별도의 다른 조건을 기술할 경우 원하는 결과가 안나올 수 있다.
==> OUTER JOIN의 결과가 무시
ANSI-SQL
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m  ON (e.mgr = m.empno)
WHERE  m.deptno = 10;

--14건의 데이터가 다나오나 조건을 만족하지 않는 행은 NULL
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m  ON (e.mgr = m.empno)
WHERE  m.deptno = 10;
--위위 쿼리는 OUTER JOIN을 적용하지 않은 아래 쿼리와 동일한 결과를 나타낸다
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m  ON (e.mgr = m.empno)
WHERE  m.deptno = 10;

ORACLE-SQL
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+) AND m.deptno(+) = 10;
    
ANSI-SQL
FROM 테이블1 LEFT OUTER JOIN 테이블2 ON (조인조건)

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m  ON (e.mgr = m.empno);


ORACLE-SQL : 데이터가 없는데 나와야하는 테이블의 컬럼
FROM 테이블1, 테이블2
WHERE 테이블1.컬럼 = 테이블2.컬럼(+)

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

RIGHT OUTER JOIN : 기준 테이블이 오른쪽

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m  ON (e.mgr = m.empno);


FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno); : 14건
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno); : 21건

FULL OUTER JOIN : LEFT OUTER + RIGHT OUTER - 중복제거

ORACLE-SQL  에서는 FULL OUTER 문법을 제공하지 않음
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m  ON (e.mgr = m.empno);

FULL OUTER 검증

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m  ON (e.mgr = m.empno)
UNION --합집합
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m  ON (e.mgr = m.empno)
MINUS --차집합
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m  ON (e.mgr = m.empno);

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m  ON (e.mgr = m.empno)
UNION --합집합
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m  ON (e.mgr = m.empno)
INTERSECT --교집합
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m  ON (e.mgr = m.empno);



-------------------------------------------------------
SQL 핵심 키워드
WHERE : 행을 제한
JOIN
GROUP FUNCTION

시도 : 서울 특별시, 충청남도..
시군구 : 강남구, 청주시..
스토어 구분
