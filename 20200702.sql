GROUP 함수의 특징
1.NULL은 그룹함수 연산에서 제외가 된다.

부서번호별 사원의 sal, comm 컬럼의 총 합을 구하기

SELECT deptno, SUM(sal + comm),
    SUM(sal + NVL(comm, 0)),
    SUM(sal) + SUM(comm)
FROM emp
GROUP BY deptno;

NULL처리의 효율
SELECT deptno, SUM(sal) + NVL(SUM(comm), 0), -- comm을 다 더한후 결과에 대해 NVL 적용 >>효율적
               SUM(sal) + SUM(NVL(comm, 0)) --모든 행에 대해서 NVL 적용 >> 비효율
FROM emp
GROUP BY deptno;

decode 또는 case 사용시 증손자 이상 낳지마라(3중첩 이상)


grp1)
SELECT MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp;

grp2)
1]
SELECT DECODE(deptno,  30, 'SALES', 20, 'RESEARCH', 10, 'ACCOUNTING', 'DDIT') dname, 
        MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno;

2]
SELECT DECODE(deptno,  30, 'SALES', 20, 'RESEARCH', 10, 'ACCOUNTING', 'DDIT') dname, 
        MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY DECODE(deptno,  30, 'SALES', 20, 'RESEARCH', 10, 'ACCOUNTING', 'DDIT');

3]
SELECT DECODE(deptno,  30, 'SALES', 20, 'RESEARCH', 10, 'ACCOUNTING', 'DDIT') dname,
max_sal, min_sal, avg_sal, sum_sal, count_sal, count_mgr, count_all
FROM
(SELECT deptno,MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal, COUNT(sal) count_sal, COUNT(mgr) count_mgr, COUNT(*) count_all
FROM emp
GROUP BY deptno);

grp4)
SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');

grp5)
SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

grp6)
SELECT COUNT(*) cnt
FROM dept;


grp7)
SELECT COUNT(COUNT(*)) cnt
FROM emp
GROUP BY deptno;

SELECT COUNT(*)
FROM
(SELECT deptno
FROM emp
GROUP BY deptno);


jOIN : 컬럼을 확장하는 방법(데이터를 연결한다)
    다른 테이블의 컬럼을 가져온다
    RDBMS가 중복을 최소화하는 구조 이기 때문에
    하나의 테이블에 데이터를 전부 담지 않고, 목적에 맞게 설계한 테이블에
    데이터가 분산이된다.
    하지만 데이터를 조회 할때 다른 테이블의 데이터를 연결하여 컬럼을 가져올 수 있다.

ANSI-SQL American National Standared Institute....SQL
ORACLE-SQL 문법

JOIN : ANSI-SQL, ORACLE-SQL의 차이가 다소 발생

--------------------ANSI-SQL join--------------------

ANSI-SQL : NATURAL JOIN : 조인하고자 하는 테이블간 컬럼명이 동일할 경우 해당 컬럼으로 행을 연결
               컬럼 이름 뿐만 아니라 데이터 타입도 동일해야함. --잘 사용안함
문법 : 
SELECT 컬럼....
FROM 테이블1 NATURAL JOIN 테이블2

emp, dept 두테이블의 공통된 이름을 갖는 컬럼 : deptno;

SELECT emp.empno, emp.ename, deptno, dname --deptno(조인조건) 테이블한정자(테이블.) 사용못함
FROM emp NATURAL JOIN dept;

ANSI-SQL : JOIN WITH USING --잘 사용안함
조인 테이블간 동일한 이름의 컬럼이 복수개 인데 
이름이 같은 컬럼중 일부로만 조인 하고 싶을 때 사용

SELECT *
FROM emp JOIN dept USING (deptno);


ANSI-SQL : JOIN with ON
위에서 배운 NATURAL JOIN, JOIN with USING의 경우 조인 테이블의 조인컬럼의
이름이 같아야 한다는 제약조건이 있음
설계상 두 테이블의 컬럼 이름이 다를수도 있다. 컬럼 이름이 다를경우
개발자가 직접 조인 조건을 기술할 수 있도록 제공 해주는 문법.

SELECT *
FROM emp JOIN dept ON(emp.deptno = dept.deptno);


ANSI-SQL : SELF-JOIN : 동일한 테이블끼리 조인 할 때 지칭하는 명칭
                       (별도의 키워드가 아니다);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e JOIN emp m ON(e.mgr = m.empno);--동일한 이름의 테이블이라 구분이 안가기때문에 별칭을 사용한다.
mgr값이 null인'KING'은 조인에 실패해 호출되지 않는다.

ANSI-SQL : NON-EQUI-JOIN : 조인조건이 = 이 아닌 조인
!= 값이 다를 때 연결



--------------------ORACLE-SQL--------------------

오라클에서는 조인 조건을 WHERE절에 기술
행을 제한하는 조건, 조인 조건 ==> WHERE절에 기술

SELECT *
FROM emp, dept --조인할 테이블 나열
WHERE emp.deptno = dept.deptno; --이름이 동일한 컬럼이 있을시 테이블한정자 사용(테이블.컬럼)

SELECT emp.*, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;


선분 : 직선으로 그려봤을때 빠지는 값이 없는것;
SELECT empno, ename, sal, grade
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal;
-----------------------실습------------------------------
사원중 사원의 번호가 7369~7698인 사원만 대상으로 해당 사원의
사원번호, 이름, 상사의 사원번호, 상사의 이름
ORACLE-SQL;
SELECT a.*, emp.ename
FROM
    (SELECT empno, ename, mgr
    FROM emp
    WHERE empno BETWEEN 7369 AND 7698) a, emp
WHERE a.mgr = emp.empno;

ANSI-SQL;
SELECT e.empno, e.ename, e.mgr, m.ename, m.empno
FROM emp e JOIN emp m ON(e.mgr = m.empno)
WHERE e.empno BETWEEN 7369 AND 7698;

SELECT a.*, emp.ename
FROM
    (SELECT empno, ename, mgr
    FROM emp
    WHERE empno BETWEEN 7369 AND 7698) a JOIN emp ON(a.mgr = emp.empno);
    
    
join0)
emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요

SELECT empno, ename, emp.deptno, dname --ORACLE-SQL
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT empno, ename, emp.deptno, dname    --ANSI-SQL
FROM emp JOIN dept ON(emp.deptno=dept.deptno);

join0_1)

SELECT a.*, dname  --ORACLE-SQL
FROM
(SELECT empno, ename, deptno
FROM emp
WHERE deptno IN(10, 30))a, dept
WHERE a.deptno = dept.deptno;


SELECT empno, ename, emp.deptno, dname    --ANSI-SQL
FROM emp JOIN dept ON(emp.deptno=dept.deptno)
WHERE emp.deptno IN(10, 30);



