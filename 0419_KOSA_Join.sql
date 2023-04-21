/* 0419 */

SELECT SYSDATE FROM dual;
-------------------
SELECT * FROM M ;
SELECT * FROM S ;
SELECT * FROM X ;

SELECT * FROM M ,S,X  WHERE x.x1 = s.S1 ;

--ansi 문법(권장)
SELECT * 
FROM m JOIN s ON m.M1 = s.S1 
		JOIN x ON s.S1 = x.X1 ;
		
SELECT * FROM EMP;
SELECT * FROM SALGRADE s ;

-- 사원의 등급(하나의 칼럼으로 매칭이 안되요) >> 컬럼 2개
-- 비등가 조인(non-equi) 1:1
-- 문법 등가와 동일함

SELECT * FROM EMP e JOIN ON SALGRADE d BETWEEN d. AND s.hisal;

-- outer join (equi 조인이 선행되고 나서 >> 남아있는 데이터를 가져오는 방법)
--1. 주종관계 (주인이 되는 쪽에 남아있는 데이터를 가져오는 방법)
--2.1 left outer join
--2.2 right outer join
--2.3 full outer join
 
SELECT * 
FROM S LEFT OUTER JOIN M  
ON S.S1 = M.M1  ; 
SELECT * 
FROM S right OUTER JOIN M  
ON S.S1 = M.M1  ; 
SELECT * 
FROM S full OUTER JOIN M  
ON S.S1 = M.M1  ; 

-- self join(자기참조) -> 문법(x) -> 의미만 존재 -> 등가조인 문법
-- 하나의 테이블에 있는 컬럼이 자신의 테이블에 있는 특정 칼럼을 참조하는 경우
use KOSA;


SELECT * FROM emp;
-- smith 사원의 사수 이름
-- 사원테이블, 관리자테이블 만드는 것이 ... 중복데이터 ...
-- 테이블 가명칭 >> 2개, 3개 있는 것 처럼

SELECT e.EMPNO ,e.ENAME ,m.EMPNO AS 사수empno ,m.ENAME AS 사수ename  
FROM emp e LEFT OUTER JOIN emp m 
ON e.MGR = m.EMPNO ;



-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
SELECT e.ENAME ,e.DEPTNO , d.dname 
FROM EMP e JOIN DEPT d 
ON d.DEPTNO = e.DEPTNO ;

-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 출력하라.
SELECT e.ENAME , e.JOB, e.DEPTNO, d.DNAME 
FROM EMP e JOIN DEPT d 
ON d.DEPTNO = e.DEPTNO 
WHERE d.LOC ='DALLAS';

-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
SELECT e.ENAME ,d.DNAME 
FROM EMP e JOIN DEPT d 
ON d.DEPTNO = e.DEPTNO 
WHERE e.ENAME LIKE '%A%';
​
-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을
--출력하는데 월급이 3000이상인 사원을 출력하라.
SELECT e.ENAME ,d.DNAME ,e.SAL  
FROM EMP e JOIN DEPT d 
ON d.DEPTNO = e.DEPTNO 
WHERE e.SAL >= 3000;
​

-- 5. 직위(직종)가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
SELECT e.JOB ,e.ENAME , d.DNAME 
FROM EMP e JOIN DEPT d 
ON d.DEPTNO = e.DEPTNO 
WHERE e.JOB  = 'SALESMAN';

​

-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.
--(비등가 ) 1 : 1 매핑 대는 컬럼이 없다
 
SELECT  e.EMPNO AS "사원번호" , e.ENAME  AS "사원이름", e.SAL AS "연봉" ,e.SAL+nvl(e.COMM,0) AS "실급여" ,s.GRADE AS "실급여"
FROM EMP e JOIN SALGRADE s 
ON e.SAL BETWEEN s.LOSAL AND s.HISAL 
WHERE e.COMM IS NOT null;  

select e.empno as 사원번호, e.ename as 사원이름,
       e.sal as 연봉, e.sal+e.comm as 실급여, s.grade as 급여등급
from emp e join salgrade s
on e.sal between s.losal and s.hisal
where e.comm is not null;

-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
SELECT e.EMPNO , e.DEPTNO  ,d.DNAME ,s.GRADE 
FROM EMP e JOIN DEPT d 
ON d.DEPTNO = e.DEPTNO JOIN SALGRADE s 
ON e.SAL BETWEEN s.LOSAL AND s.HISAL 
WHERE e.DEPTNO = 10;
​

-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름,

-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된

-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로

-- 정렬하라.

SELECT  e.EMPNO , e.DEPTNO  ,d.DNAME ,s.GRADE
FROM EMP e JOIN DEPT d 
ON d.DEPTNO = e.DEPTNO JOIN SALGRADE s 
ON e.SAL BETWEEN s.LOSAL AND s.HISAL 
WHERE e.DEPTNO in (10,20)
ORDER BY e.DEPTNO DESC,e.SAL asc;

-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의

-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',

-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.

--SELF JOIN (자기 자신테이블의 컬럼을 참조 하는 경우)

SELECT e.EMPNO AS "사원번호" ,e.ENAME AS "사원이름" ,m.EMPNO AS "관리자번호" ,m.ENAME AS "관리자이름"
FROM emp e LEFT OUTER JOIN emp m
ON e.MGR = m.EMPNO ;


-- 사원테이블에서 사원들의 평균월급보다 더 많은 월급을 받는 사원의 사번 이름 급여를 출력하세요
SELECT * FROM emp;

-- 1. 평균급여
SELECT trunc(avg(sal)) FROM emp;

SELECT e.EMPNO , e.ENAME , e.SAL 
FROM EMP e 
WHERE e.SAl >= (SELECT trunc(avg(sal)) FROM emp);


/* 
subquery
서브쿼리
만능해결사!
1.  single row subquery : 실행결과가 단일컬럼에 단일 로우값 인 경우  (한개의값)
	``ex) select sum(sal) from emp 

2.  multi row subquery : 실행결과가 단일컬럼에 여러개 로우값인 경우
	``ex) select deptno from emp, select sal  from emp
	
연산자 : IN, NOT IN, ANY, ALL
ALL : sal > 1000 and sal > 40000 and
ANY : sal > 1000 or sal > 40000 or

문법)
1. 괄호안에 있어야 한다 	(select max(sal) from emp)
2. 단일 컬럼 구성 		(select max(sal), min(sal) from emp) 
3. 서브쿼리가 단독으로 실행가능

서브쿼리와 메인쿼리
1. 서브쿼리 실행되고 그 결과를 가지고 
2. 메인쿼리가 실행된다.

TIP) 
select (subquery) >> scala
from (subquery) >> in line view(가상테이블)
where (subquery) >> 조건
**/


-- 사원테이블에서 jonesd
SELECT sal
FROM EMP e 
WHERE e.ENAME = 'JONES';

SELECT * 
FROM EMP e 
WHERE sal >= (SELECT sal FROM EMP e WHERE e.ENAME = 'JONES');

SELECT * FROM EMP e 
WHERE SAL NOT in (SELECT sal FROM emp WHERE DEPTNO = '30');
--sal != and

--부하직원이 있는 사원의 사번과 이름을 출력하세요 
SELECT mgr  
FROM EMP e 

SELECT * FROM EMP e
WHERE EMPNO IN (SELECT mgr FROM EMP e );

SELECT * FROM EMP e
WHERE EMPNO NOT IN (SELECT nvl(mgr,0) FROM EMP e );

--king에게 보고하는 즉 직속상관이 king인 사원의 이름 
SELECT mgr
FROM EMP e; 

SELECT e.ENAME , e.EMPNO ,e.JOB , e.MGR 
FROM EMP e 
WHERE e.MGR =(SELECT empno FROM EMP e WHERE ENAME='KING');

--20번 부서의 사원중에서 가장 많은 급여를 받는 사원보다 더 많은 급여를 받는 사원의 
-- 사번, 이름, 급여, 부서번호를 출력

SELECT max(sal)
FROM  EMP e 
WHERE e.DEPTNO = 20; 

SELECT e.EMPNO ,e.ENAME ,e.SAL ,e.DEPTNO 
FROM EMP e 
WHERE e.SAL >= (SELECT max(sal) FROM  EMP e WHERE e.DEPTNO = 20); 


SELECT * FROM EMP e ;

SELECT e.empno ,e.ENAME ,e.DEPTNO ,(SELECT d.DNAME  FROM DEPT d WHERE d.DEPTNO =e.DEPTNO) AS dept_name
FROM EMP e 
WHERE e.SAL >= 3000;

--자기부서의f

 SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO ,a.avgsal
 FROM EMP e LEFT OUTER JOIN 
  (SELECT e.DEPTNO AS DEPTNO , avg(e.SAL) AS avgsal FROM EMP e GROUP BY DEPTNO) a
 ON e.DEPTNO  = a.DEPTNO
WHERE e.SAL >= a.avgsal;


​select *
FROM EMP; 

--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
​select 
FROM EMP e 
WHERE sal > = (SELECT sal FROM emp WHERE ENAME = 'SMITH')

--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.

--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라.

--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력하라.
​
--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.

--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)

--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.

--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.

--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라
--king 이 사수인 사람 (mgr 데이터가 king 사번)

--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,급여를 출력하라.

--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.

--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.


SELECT * FROM tab; --사용자(KOSA) 계정이 가지고 있는 테이블 목록

SELECT * FROM tab WHERE TNAME ='BOARD';
SELECT * FROM tab WHERE TNAME ='EMP';
SELECT * FROM col WHERE TNAME = 'EMP';

-------------------------------------------------------------------------------------------
--INSERT , UPDATE, DELETE 무조건 암기
-- 1. INSERT

CREATE TABLE temp(
	id NUMBER PRIMARY KEY, --NOT NULL UNIQUE 받겠다.(회원 ID , 주민번호)
	name varchar2(20)
);

DESC temp;

INSERT INTO temp(id,NAME) VALUES (100,'홍길동');

--commit, rollback 하기 전까지 실반영하지 않아요
SELECT * FROM temp;
COMMIT;

-- 2. 컬럼 목록 생략 (insert) 쓰지 마세요
INSERT INTO TEMP VALUES(200,'김유신');
ROLLBACK;

-- 3. 문제 ..... INSERT 
INSERT INTO temp(name) VALUES('아무개');

INSERT INTO temp(id,NAME) values(100,'개똥이');
--PK >> id >> 중복 데이터 (x) unique constraint (KOSA.SYS_C007003) violated

INSERT INTO temp(id,NAME) values(200,'정상이');
COMMIT;

------------------------------------------------------------------------------------------------
--PL-SQL
CREATE TABLE temp2(id varchar2(50));
COMMIT;
BEGIN
	FOR i IN 1..100 LOOP
		INSERT INTO temp2(id) values('A'|| to_char(i));
	END LOOP;
END;
COMMIT;

CREATE TABLE temp3(
	memberid number(3) NOT NULL,
	name varchar(10),
	regdate DATE DEFAULT sysdate
);
COMMIT;
SELECT * FROM temp3;

SELECT SYSDATE FROM dual;
INSERT INTO temp3(memberid,name,regdate)
values(100,'홍길동','2023-04-19');


INSERT INTO temp3(memberid,name)
VALUES(200,'김유신');

--3. 컬럼 하나 
INSERT INTO temp3(memberid)
VALUES(300);

--4. 오류 
INSERT INTO temp3(name)	--id NULL 값 >> NOT null
values('나누구');

--Tip)
CREATE TABLE temp4(id number);
CREATE TABLE temp5(num number);

INSERT INTO temp4 values(1);
INSERT INTO temp4 values(2);
INSERT INTO temp4 values(3);
INSERT INTO temp4 values(4);
INSERT INTO temp4 values(5);
INSERT INTO temp4 values(6);
INSERT INTO temp4 values(7);
INSERT INTO temp4 values(8);
INSERT INTO temp4 values(9);
INSERT INTO temp4 values(10);

SELECT * FROM temp4;
SELECT * FROM temp5;
--temp4 테이블에 있는 모든 데이터를 temp5 넣고 싶어요
--insert into 테이블명(컬럼리스트) values ...
--insert into 테이블명(컬럼리스트) select 절 *******************

INSERT INTO temp5(num)
SELECT id FROM temp4;
COMMIT;

--2. 대량데이터 삽입하기
-- 데이터를 담을 테이블도 없고 >> 테이블 구조(복제) : 스키마 + 데이터 삽입
-- 단 제약정보는 복제 안됩니다 (PK,FK)
-- 순수한 데이터 구조 + 데이타
 CREATE TABLE copyemp
 AS 
 SELECT * FROM emp;

 SELECT * FROM copyEmp;
 
CREATE TABLE copyemp2
 AS 
 SELECT empno,ename,sal
	FROM emp
WHERE DEPTNO = 30;
 

SELECT * FROM copyemp2;

COMMIT;

--토막퀴즈 
--틀만(스키마) 복제 데이터는 복사하고 싶지 않아요 
CREATE TABLE copyemp3
AS 
SELECT * FROM emp WHERE 1=2;

SELECT * FROM copyemp3;


---------------------------------------------------------------------------------
--insert end
--update
/*
 update 테이블명
 set 컬럼명 = 값, 컬럼명 = 값2
 where 조건절
 
 update 테이블명 
 set 컬럼명 = (subquery)
 where 컬럼명  = (subquery)
 */
SELECT * FROM copyemp;

UPDATE copyemp
SET SAL = 0;

ROLLBACK;

UPDATE COPYEMP 
SET SAL= 1111
WHERE DEPTNO = 20;
ROLLBACK;

UPDATE COPYEMP 
SET SAL = (SELECT sum(SAL) FROM emp);

UPDATE COPYEMP SET ename='AAA' ,job = 'BBB' , hiredate = SYSDATE , sal= (SELECT sum(SAL) FROM emp)
WHERE empno=7788;

SELECT * FROM copyemp WHERE empno=7788;
COMMIT;
----------------------------------------------------------------------------------
--UPDATE end
DELETE FROM copyemp;

SELECT * FROM copyemp;
ROLLBACK;

DELETE FROM COPYEMP WHERE deptno = 20;
SELECT * FROM copyemp WHERE deptno=20;
COMMIT;

----------------------------------------------------------------------------------
--DELETE end


