
/*
	VIEW!!!!
	
	CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name [(alias[,alias,...])]
	AS Subquery 
	[WITH CHECK OPTION [CONSTRAINT constraint ]]
	[WITH READ ONLY]
	
	옵션
	OR REPLACE 이미 존재한다면 다시 생성한다.
	FORCE Base Table 유무에 관계없이 VIEW 을 만든다.
	NOFORCE 기본 테이블이 존재할 경우에만 VIEW 를 생성한다.
	view_name VIEW 의 이름
	Alias Subquery 를 통해 선택된 값에 대한 Column 명이 된다.
	Subquery SELECT 문장을 기술한다.
	WITH CHECK OPTION VIEW 에 의해 액세스 될 수 있는 행만이 입력,갱신될 수 있다. 
	Constraint CHECK OPTON 제약 조건에 대해 지정된 이름이다.
	WITH READ ONLY 이 VIEW 에서 DML 이 수행될 수 없게 한다
*/

GRANT CREATE ANY VIEW TO "KOSA" WITH ADMIN OPTION;

CREATE VIEW VIEW001
AS
SELECT * FROM emp;

-- view001 이라는 객체가 생성되었다 (가상테이블 >>쿼리 문장을 가지고 있는 객체)
-- 이 객체는 테이블처럼 사용할 수 있는 객체

SELECT * FROM VIEW001 v ;
SELECT * FROM VIEW001 v WHERE DEPTNO = 20;

-- VIEW (가상테이블)
-- 사용법 : 일반 테이블과 동일함 (select , insert, update, delete)
-- 단 VIEW가 볼 수 있는 데이터에 한해서 
-- View 통해서 원본 테이블에 insert, update, delete(DML) 가능 ...가능정도만

-- View 목적
-- 1.개발자의 편리성 : join, subquery 복잡한 쿼리 미리 생성두었다가 사용
-- 2. 쿼리 단순화 : view 생성해서 Join 편리성
-- 3. DBA 보안 : 원본테이블은 노출하지 않고 view 만들어서 제공 (특정 컬럼을 노출하지 않는다)

CREATE OR REPLACE VIEW v_001
AS
	SELECT empno, ename
	FROM emp;


CREATE OR REPLACE VIEW  v_emp
AS
	SELECT EMPNO ,ENAME ,JOB ,HIREDATE  FROM emp;

-- 편리성 
CREATE OR REPLACE VIEW v_002
AS
	SELECT empno, ename ,d.DEPTNO ,d.DNAME
	FROM emp JOIN DEPT d  
	ON emp.DEPTNO  = d.DEPTNO ;







CREATE OR REPLACE VIEW v_003
AS
SELECT e.DEPTNO AS DEPTNO , avg(e.SAL) AS avgsal FROM EMP e GROUP BY DEPTNO ;

SELECT * FROM v_003;

SELECT e.EMPNO, e.ENAME, e.SAL, e.DEPTNO 
 FROM EMP e LEFT OUTER JOIN v_003 a
 ON e.DEPTNO = a.DEPTNO
WHERE e.SAL >= a.avgsal;


/*
 view 나름 테이블 (가상)veiw를 통해서 view 볼수 있는 데이터에 대해서 DML(inset, update, delete) 가능함
 */
SELECT * FROM v_002;

SELECT * FROM v_emp;
UPDATE v_emp SET job = 'IT';
SELECT * FROM emp;
ROLLBACK;

--30번 부서 사원들의 직종, 이름 , 월급을 담느
CREATE OR REPLACE VIEW veiw_101
AS
SELECT e.EMPNO ,e.ENAME ,e.SAL 
FROM EMP e 
WHERE e.DEPTNO =30;

CREATE OR REPLACE VIEW view_102
AS
SELECT DEPTNO, AVG(SAL) AS SAL 
FROM emp
GROUP BY DEPTNO;
COMMIT;
SELECT * FROM view_102;