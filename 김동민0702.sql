SELECT empno, ename, sal, emp.deptno, dname
FROM emp JOIN dept ON (emp.deptno=dept.deptno)
WHERE sal > 2500
ORDER BY deptno;

SELECT empno, ename, sal, emp.deptno, dname
FROM emp JOIN dept ON (emp.deptno=dept.deptno)
WHERE sal > 2500 AND empno > 7600
ORDER BY deptno;

SELECT empno, ename, sal, emp.deptno, dname
FROM emp JOIN dept ON (emp.deptno=dept.deptno)
WHERE sal > 2500 AND empno > 7600 AND dname = 'RESEARCH'
ORDER BY deptno;

