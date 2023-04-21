SELECT * FROM EMP; 

--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
SELECT ENAME, SAL 
FROM EMP
WHERE SAL >= (SELECT e.SAL FROM EMP e WHERE ENAME = 'SMITH');

SELECT ENAME, SAL
FROM EMP
WHERE SAL>(SELECT SAL
           FROM EMP
           WHERE ENAME='SMITH');

--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.
--SELECT DEPTNO , sal
--FROM EMP e 
--WHERE DEPTNO = 10;
--​
SELECT ENAME ,SAL  
FROM EMP
WHERE SAL IN(SELECT e.SAL FROM EMP e WHERE DEPTNO = 10);

SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN(SELECT SAL
             FROM EMP
             WHERE DEPTNO=10);

--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라.
SELECT ENAME ,HIREDATE 
FROM EMP e 
WHERE e.ENAME != 'BLAKE' 
AND e.DEPTNO = (SELECT emp.DEPTNO FROM emp WHERE emp.ENAME = 'BLAKE');


SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO=(SELECT DEPTNO
              FROM EMP
              WHERE ENAME='BLAKE')
AND ENAME!='BLAKE';

--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력하라.
SELECT e.EMPNO ,e.ENAME ,e.SAL 
FROM EMP e 
WHERE e.SAL > (SELECT avg(SAL) FROM EMP)
ORDER BY e.SAL DESC ;

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL>(SELECT  AVG(SAL)  FROM EMP)
ORDER BY SAL DESC;

--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.
SELECT e2.EMPNO ,e2.ENAME 
FROM EMP e2 
WHERE e2.DEPTNO IN (SELECT DEPTNO FROM EMP e WHERE e.ENAME LIKE '%T%');
​
SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%');

--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)

--SELECT e.SAL 
--FROM EMP e 
--WHERE e.DEPTNO = 30;
--​
--SELECT e.ENAME , e.DEPTNO , e.SAL  
--FROM emp e JOIN (SELECT SAL,DEPTNO FROM EMP WHERE DEPTNO = 30)a 
--ON a.DEPTNO = e.DEPTNO; 
--​

SELECT ename, deptno, sal
FROM emp
WHERE sal > ALL(SELECT sal FROM emp WHERE deptno = 30);

SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL
                FROM EMP
                WHERE DEPTNO=30)


--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.
SELECT emp.ENAME , emp.DEPTNO , emp.JOB 
FROM emp 
WHERE emp.DEPTNO  = (SELECT DEPTNO  FROM DEPT d WHERE LOC = 'DALLAS');

SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO    -- = 이 맞는데  IN
                FROM DEPT
                WHERE LOC='DALLAS');

--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.
SELECT e.DEPTNO ,e.ENAME ,e.JOB 
FROM EMP e 
WHERE e.DEPTNO = (SELECT DEPTNO  FROM DEPT d WHERE DNAME = 'SALES');
SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                FROM DEPT
                WHERE DNAME='SALES')

--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라
--king 이 사수인 사람 (mgr 데이터가 king 사번)
SELECT e.ENAME ,e.SAL  
FROM EMP e 
WHERE e.MGR = (SELECT EMPNO  FROM emp WHERE ENAME = 'KING'); 

SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO
           FROM EMP
           WHERE ENAME='KING');

--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,급여를 출력하라.
SELECT e.EMPNO ,e.ENAME ,e.SAL 
FROM EMP e 
WHERE e.DEPTNO IN(SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%S%')
 AND SAL >= (SELECT avg(SAL) FROM EMP);
 
 
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
             FROM EMP)
AND DEPTNO IN(SELECT DEPTNO
              FROM EMP
              WHERE ENAME LIKE '%S%');
--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.
SELECT emp.ENAME, emp.SAL, emp.DEPTNO  
FROM emp, (SELECT DEPTNO, SAL FROM emp WHERE COMM IS NOT NULL OR COMM != 0) a
WHERE emp.SAL = a.SAL AND emp.DEPTNO = a.DEPTNO;
​
SELECT ENAME, SAL, DEPTNO
FROM emp
WHERE DEPTNO IN(SELECT DEPTNO FROM emp  WHERE COMM IS NOT NULL)
AND SAL IN( SELECT SAL FROM emp WHERE COMM IS NOT NULL);
           
--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.

--SELECT emp.ENAME ,emp.SAL ,emp.COMM 
--FROM emp, (SELECT SAL ,COMM FROM emp WHERE DEPTNO = 30)a
--WHERE emp.SAL != a.SAL AND emp.COMM != a.COMM;

SELECT emp.ENAME ,emp.SAL ,emp.COMM 
FROM emp
WHERE emp.SAL NOT IN (SELECT SAL FROM emp WHERE DEPTNO = 30) 
	AND emp.COMM NOT IN (SELECT COMM FROM emp WHERE DEPTNO = 30 AND (COMM IS NOT NULL OR COMM !=0) ) 
