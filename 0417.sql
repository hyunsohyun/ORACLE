
SELECT * FROM DEPT d ;
SELECT * FROM emp e ;
SELECT * FROM SALGRADE s ;

-----------------------------------
--1. 사원테이블에서 모든 데이터를 출력하세요.
SELECT * FROM emp;

--2. 특정 칼럼 데이터 출력하기
SELECT EMPNO,ENAME,SAL  FROM emp;

SELECT ename FROM  emp;

--3. 가명칭 사용하기 별칭 alias
SELECT EMPNO '사   번' , ENAME 이름 
FROM EMP; 

--권장문법(ansit) >> 표준 >> 구문 작성하면 (Oracle, MS-sql ,Mysql) 모무 동작
SELECT EMPNO AS '사   번' , ENAME  AS '이  름' 
FROM EMP; 

--Oracle 문자열 데이터 엄격하게 대소문자 구별
/*
JAVA : 문자 > 'A' . 문자열 > 'AAA'
ORACLE : 문자열 '' 
**/

SELECT * FROM emp WHERE ENAME = 'king'; --결과가 안나옴
SELECT * FROM emp WHERE ENAME = 'KING';


--연산자
--JAVA : + 숫자(산술연산) , + 문자열(결합연산)
--Oravle :
--결합연산자 ||
--산술연산자 +(산술)
--
--ms-SQL : + (산술,결합)

SELECT '사원이름은 ' || ENAME || '입니다' AS 사원정보
FROM emp;

--테이블의 기본정보 (칼럼, 타입)
desc emp;

/*
JAVA : class Emp(private int empno , private String ename)
*/

--형변환(자동) >> 숫자를 문자열로 변환
SELECT empno || ename FROM emp; 
SELECT empno + ename FROM emp;	--오류  invalid number

--사장님 .. 우리회사에 직종이 몇개나 있나
SELECT job FROM emp;

SELECT DISTINCT job FROM emp;
--grouping 


--distinct
--재미로
SELECT DISTINCT job , deptno
FROM emp
ORDER BY job;

SELECT job , deptno
FROM emp
ORDER BY job;

--oravle sql 언어
--java 거의 도일 (+,-,*,/) 나머지 %
-- or
--

-- 사원테이블에서 사원의 급여를 100달러 인상한 결과를 출력하세요 
SELECT empno, ename, sal, sal+100 AS 인상급여 FROM emp;
--dual 임시테이블
SELECT 100 + 100 FROM dual;
SELECT 100 || 100 FROM dual; 	--100100
SELECT '100' + 100 FROM dual;	--'100' 숫자형 문자 ex) '123456'
SELECT 'A100' + 100 FROM dual;	--SQL Error [1722] [42000]: ORA-01722: invalid number


-- 비교연산자
-- <> <= 
-- 주의
-- JAVA : 같다(==) 할당(=) javascript : (==),(===)
-- ORACLE : 같다 = 같지 않다 !=

-- 논리연산자 (AND,OR,NOT)

SELECT empno, ENAME , SAL  FROM EMP e 
WHERE sal >= 2000;

--사원의 이름이 king 사원의 사번 이름 급여 정보를 출력하세요

-- 초과, 미만
-- 이상, 이하 (=)

-- 급여가 
SELECT * 
FROM emp
WHERE sal>= 2000 OR job='MANAGER';

SELECT * FROM emp
WHERE sal > 2000 AND job = 'MANAGER';

-- 
SELECT SYSDATE FROM dual;

SELECT * FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI:SS';
SELECT SYSDATE FROM dual;	--2023-04-17 14:36:10.000

-- 도구 > 환경설정 >데이터베이스 > NLS 날짜 형식 수정해도 된다1!

SELECT * FROM emp;

--날짜 데이터 검색 >> 문자열 검색처럼 >> '날짜'
SELECT * FROM EMP e 
WHERE HIREDATE = '1980-12-17';

SELECT * FROM EMP e 
WHERE HIREDATE = '1980/12/17';

SELECT * FROM EMP e 
WHERE HIREDATE = '1980.12.17';

SELECT * FROM EMP e 
WHERE HIREDATE = '80-12-17';	-- 현재 날짜 (yyyy-mm-dd)

-- 사원의 급여가 2000이상이고 4000 이하인 모든 사원의 정보 출력
SELECT * FROM EMP
WHERE SAL>=2000 AND sal<=4000;

SELECT * FROM EMP
WHERE sal BETWEEN 2000 AND 4000;

-- 부서번호가 10번 20번
SELECT * FROM EMP 
WHERE DEPTNO IN (10,20,30);


SELECT * FROM EMP
WHERE DEPTNO !=10 AND DEPTNO !=20;

SELECT * FROM EMP
WHERE DEPTNO NOT IN (10,20);

--TODAY Point
-- null에 대한 이야기
-- 값이 없다.
-- 필요악

CREATE TABLE MEMBER (
	userid varchar2(20) NOT NULL , --null을 허용하지 않겠다	(필수 입력)
	name varchar2(20) NOT NULL,	--필수 입력
	hobby varchar2(50) --DEFAULT NULL 허용 선택입력 ....
);

SELECT * FROM MEMBER;

INSERT INTO member(userid ,hobby) values('kim','농구'); --Error [1400] [23000]: ORA-01400: cannot insert NULL into ('KOSA'.'MEMBER'.'NAME')
INSERT INTO member(userid , name , hobby) values('kim' , '','농구');

SELECT * FROM MEMBER;

--기본적으로 쿼리문 시행시 BEGIN tran 구문이 자동 ~~ 개발자는 end(완료, 취소)
--오라클은 대기상태 ... 마지막 명령(commt 실제 반영, ROLLBACK  취소) 작업완료
--
--ms-SQL
--자동 auto-COMMIT
--DELETE FROM emp; 자동 commit
-- begin tran 
-- DELETE FROM emp
-- commit or ROLLBACK 하지 않으면 데이터처리 안된다

DELETE FROM emp;
SELECT * FROM emp;
COMMIT;

--DB TRANSACTION : 논리적인 작업 단위(성공, 실패) 락 수반
--OLTP (웹환경 : 실시간으로 데이터 처리
--BEGIN tran
--	UPDATE ... 계좌 -1000
--	UPDATE ... 동생계좌 +1000
--end


--OLAP (데이터 분석 : 일정기간 데이터 모아서 분석)
--
--오라클에서 INSERT, UPDATE, DELETE 하면 반드시 
--******COMMIT ,ROLLBACK 처리여부 결정해야한다,


----------------------------------------------
--수당(comm) 을 받지 않는 모든 사원의 정보를 출력하세요
SELECT * FROM emp 
WHERE COMM IS NULL;

-- 사원

SELECT  EMPNO ,ENAME,SAL,comm, NVL(comm,0)+sal AS 총급여 FROM EMP e 

/*
 null 이란 녀서
 1. null 과의 모든 연산 결과는 null ex) null+100 > null
 2. null 이란 ... 험슈 > nvl(), nvl2() 암기
 
 Tip)
 Mysql > null > IFNULL()  > select ifnull(null,'')
 MS-sql > null > Convert()
 **/

SELECT 1000+ NULL FROM dual;
SELECT 1000 + nvl(NULL,100) FROM dual;

--사원의 급여가 1000이상이고 수당을 받지 않는 사원의 사번, 이름, 직종, 급여 , 수당을 출력하세요
SELECT * FROM EMP 
WHERE sal>= 1000 and comm IS NULL;

--문자열 검색
-- Like 뭄자열 패턴 검색
-- 와일드 카드%


SELECT * FROM EMP e 
WHERE ENAME like '%A%A%'; --A가 두개

SELECT * FROM EMP e 
WHERE ENAME like '_A%'; --두번째 글자는 A인사람!

-- 정규표현식 regexp_like()
SELECT * FROM emp WHERE REGEXP_LIKE(ENAME,'[A-C]'); 
-- 과제 (정규 표현식 5개 만들기) 추후 카페에 올리면하세용

-- 데이터 정렬하기 
-- order by 칼럼명 : 문자, 숫자. 날짜 정렬가능
-- 오름차순 : asc : 낮은순 : default
-- 내림차순 : desc  높은순
-- 정렬(알고리즘) >> 비용이 많이 드는 작업

SELECT * 
FROM EMP e 
ORDER BY sal;

SELECT *
FROM EMP 
ORDER BY sal DESC ;


-- 입사일이 가장 늦은 순으로 정렬해서 사번,이름,급여,입사일출력하세용
SELECT EMPNO ,ENAME ,HIREDATE FROM EMP e 
ORDER BY HIREDATE DESC;


SELECT empno, ename,SAL ,JOB , HIREDATE  
FROM emp
WHERE JOB ='MANAGER'
ORDER BY HIREDATE DESC ;

SELECT job,deptno
FROM EMP e 
ORDER BY JOB ASC, DEPTNO DESC ;

/*
 select 절  3
 from절     1
 where 절   2
 order by 절 4(select 결과를 정렬)
 -- grouping
 
 */

-- 연산자
-- 합집합(union)		: 테이블과 테이블의 데이터를 합치는 것(중복값 배제)
-- 합집합(union all)	: 테이블과 테이블으 데이터를 합치는 것(중복값 허용)

CREATE TABLE uta(name varchar2(20));

INSERT INTO uta(name) values('AAA');
INSERT INTO uta(name) values('BBB');
INSERT INTO uta(name) values('CCC');
INSERT INTO uta(name) values('DDD');
COMMIT;

CREATE TABLE ut(name varchar2(20));
INSERT INTO ut(name) values('AAA');
INSERT INTO ut(name) values('BBB');
INSERT INTO ut(name) values('CCC');
COMMIT;

SELECT * FROM uta;
SELECT * FROM ut;

SELECT * FROM uta
UNION ALL
SELECT * FROM ut;

--union 
--1. [대응]되는 [칼럼]의 [타입]이 동일

SELECT EMPNO ,ENAME  FROM EMP e 
UNION
SELECT dname,DEPTNO  FROM DEPT d;


SELECT EMPNO ,ENAME  FROM EMP e 
UNION
SELECT DEPTNO, dname  FROM DEPT d;
-- 순서 나중에 subquery 를 사용해서 가상테이블....

SELECT * 
FROM (
	SELECT EMPNO ,ENAME  FROM EMP 
	UNION
	SELECT DEPTNO, dname  FROM DEPT
)m
ORDER BY m.empno DESC;

--2. [대응]되는 [칼럼]의 개수가 [동일]
-- 필요악 (null) 칼럼의 대체 
SELECT EMPNO ,ENAME ,job, sal FROM EMP 
UNION
SELECT DEPTNO, dname, loc ,null  FROM DEPT;

--초급 개발자 의무적으로 해야하는 코드(단일 테이블 select)


