/* 0418 */

-- 단일 행 함수의 종류 
--1) 문자형 함수 : 문자를 입력 받고 문자와 숫자 값 모두를 RETURN 할 수 있다.
--2) 숫자형 함수 : 숫자를 입력 받고 숫자를 RETURN 한다.
--3) 날짜형 함수 : 날짜형에 대해 수행하고 숫자를 RETURN 하는 MONTHS_BETWEEN 함수를
--제외하고 모두 날짜 데이터형의 값을 RETURN 한다.
--4) 변환형 함수 : 어떤 데이터형의 값을 다른 데이터형으로 변환한다.
--5) 일반적인 함수 : NVL, DECODE
show USER;
SELECT SYSDATE FROM dual;

SELECT * FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

--문자열 함수
SELECT INITCAP('the supermain') FROM dual;
SELECT LOWER('AAA'), UPPER('aaa')FROM dual;
SELECT ename, LOWER(ename) FROM EMP;

SELECT LENGTH('abc') FROM dual;

SELECT LENGTH('     홍 길   동a') FROM dual; --9개

SELECT CONCAT('a','b') FROM dual;
--SELECT CONCAT('a','b','c') FROM dual;
SELECT 'a' || 'b' || 'c' FROM dual;

SELECT CONCAT(ename,job) FROM emp; 
SELECT ename || '  ' || job FROM emp; 


--JAVA :substring 
SELECT SUBSTR('ABCDE', 2, 3) FROM dual;	
SELECT SUBSTR('ABCDE', 3) FROM dual;


/*
사원테이블에서 ename 칼럼의 데이터에 대해서 첫글자는 소문자로 나머지 글자는 대문자로 출력하되 하나의 칼럼으로 만들어서 출력하고 칼럼의 별칭은 fullname하고 
 */
SELECT substr(LOWER(ename),1,1) || substr(UPPER(ename),2) AS fullname  FROM EMP e;

SELECT LPAD('ABC' ,10, '*')FROM dual;
SELECT RPAD('abc' , 10 ,'*') FROM dual; 
-- 사용자 비번 : hong1004 or k1234
-- 화면앞에 2글자만 보여주고 나머지는 특수문자로
 SELECT RPAD(SUBSTR('hong1004',1,2),LENGTH ('hong1004'),'*')FROM dual; 

--emp 테이블에서 en
SELECT RPAD(SUBSTR(ename,1,1),LENGTH (ename),'*') FROM emp;

CREATE TABLE KOSA.MEMBER2 (
	ID NUMBER(38,0) NULL,
	JUMIN VARCHAR2(100) NULL
);

INSERT INTO MEMBER2 m VALUES(100,'123456-1234567');
INSERT INTO MEMBER2 m VALUES(100,'234567-1234567');
COMMIT;

SELECT * FROM MEMBER2 m ;
--출력결과
SELECT SUBSTR(jumin,8)FROM MEMBER2 m ;
SELECT id || '-'||RPAD(SUBSTR(jumin,1,7),LENGTH (jumin),'*') FROM MEMBER2 m ;


--rtrim 함수 
오른쪽 문자를 지워라
SELECT RTRIM('MILLLLL','LLL') FROM dual;--?? 
SELECT LTRIM('MILLLLLer','MIR') FROM dual; 

--TRANSLATE 함수
--TRANSLATE(column1 | expression1, ‘string1’, ‘string2’) FROM dual;

--치환함수
SELECT ename,REPLACE (ename,'A','***')FROM emp;

---------------
--숫자함수
--round 반올림 함수
--TRUNC 절삭함수
--mod 나머지 구하는 함수

-- 반올림
SELECT ROUND(12.345,0) FROM dual; 
SELECT ROUND(12.567,0) FROM dual; 
SELECT ROUND(12.567,1) FROM dual; 
SELECT ROUND(12.567,-1) FROM dual; 
SELECT ROUND(12.567,-1) FROM dual; 

-- 절삭
SELECT trunc(12.345,0) FROM dual; 
SELECT trunc(12.567,1) FROM dual; 
SELECT trunc(12.567,-1) FROM dual; 
SELECT trunc(12.567,-2) FROM dual; 

SELECT 12/10 FROM dual;
SELECT mod(12,10) FROM dual;
SELECT mod(0,0) FROM dual;

-----------------------
SELECT SYSDATE FROM dual;

--Point
--1. Date + Number >> Date
--2. Date - Number >> Date
--3. Date - Date >> Number

SELECT SYSDATE +100 FROM dual;
SELECT SYSDATE +1000 FROM dual;


SELECT HIREDATE FROM emp;

SELECT trunc(MONTHS_BETWEEN(SYSDATE ,'2020-09-26'),0) FROM dual;
SELECT MONTHS_BETWEEN(SYSDATE ,'2020-09-26') FROM dual;

SELECT '2023-01-01' + 100 FROM dual;

--해결함수
SELECT TO_DATE('2023-01-01')+100 FROM dual; 

--사원테이블에서 사원들의 입사일에서 현재날짜까지의 근속월수를 구하세요
-- 사원이름 , 입사일, 근속월수 출력
-- 단 근속월수는 정수부만 출력
SELECT ENAME ,HIREDATE ,trunc(MONTHS_BETWEEN(sysdate,HIREDATE),0)AS 근속월수 FROM EMP e ;

-- 한달이 31일이라고 가정하고 기준에서 근속월수를 구하세용
--단 함수는 사용하지 마세용
SELECT trunc((SYSDATE-HIREDATE)/31,0)AS 근속월수 
FROM emp;

-- 문자함수 , 숫자함수, 날짜함수 end

----------------------------------------------------------
--문자함수 , 숫자함수 , 날짜함수 END ---------------------------

-- 변환함수 Today Point
-- 오라클 데이터 유형: 문자열, 숫자 , 날짜

-- to_char() : 숫자 -> 형식 문자(10000 -> $100,000) >> format 출력형식정의
-- to_char() : 날짜 -> 형식 문자('2023-01-01') -> 2023년 01월 01일 >> format 출력형식

-- to_date() : 문자(날짜형식) -> 날짜
-- SELECT to_date('2023-01-01') + 100 from dual;

-- to_number() : 문자 -> 숫자 (자동형변화)
SELECT '100' + 100 FROM dual;
SELECT TO_NUMBER('100') + 100 FROM dual;

-- 변환시 표 참조 (page 69 ~ 71 참조)
-- 형식 format

SELECT SYSDATE , TO_CHAR(SYSDATE,'YYYY')  || '년' AS yyyy 
, to_char(SYSDATE, 'Year')
, to_char(SYSDATE, 'MM')
, to_char(SYSDATE, 'DD')
, to_char(SYSDATE, 'DAY')
fROM dual;

SELECT ENAME ,EMPNO ,HIREDATE , to_char(SYSDATE, 'Year') AS 입사년도 ,to_char(HIREDATE, 'MM')AS 입사월  FROM emp
WHERE to_char(HIREDATE, 'MM')='12' ;

SELECT*  FROM emp
WHERE to_char(HIREDATE, 'MM')='12' ;

SELECT '>' || TO_CHAR(12345,'999999999999999999') || '<' FROM dual; 
SELECT '>' || LTRIM(TO_CHAR(12345,'999999999999999999')) || '<' FROM dual; 
SELECT '>' || TO_CHAR(12345,'$999,999,999,999,999,999') || '<' FROM dual; 
SELECT '>' || TO_CHAR(12345,'$999,999,999,999,999,999') || '<' FROM dual; 

SELECT sal, TO_CHAR(sal,'$999,999,999') FROM EMP e ; 

----------------------------------------------------------------------------------------------------------------
--문자, 숫자, 날짜, 변환함수(to ...)
----------------------------------------------------------------------------------------------------------------
-- 일반함수 (프로그래밍 성격이 강하다)
-- sql (변수, 제어문 개념이 없다)
-- PL-SQL(변수, 제어문 ....) 고급 기능(트리거, 커서, 프로시져)

-- nvl() null처리 하는 함수
-- decode() >> java if문		>> 통계데이터(분석) > pivot, cube , rollup
-- case() >> java switch문

SELECT comm ,nvl(comm,0) FROM emp;

DROP TABLE t_emp;
CREATE TABLE kosa.t_emp(
	id number(6) , --정수 6자리
	job nvarchar2(20) -- unicode 영문자, 한글 2byte ----20자  >> 40byte
);

INSERT INTO t_emp(id,job) VALUES(100,'IT');
INSERT INTO t_emp(id,job) VALUES(200,'SALES');
INSERT INTO t_emp(id,job) VALUES(300,'MANAGER');
INSERT INTO t_emp(id,job) VALUES(400);
INSERT INTO t_emp(id,job) VALUES(500,'MANAGER');


SELECT * FROM T_EMP te;

SELECT id, DECODE(id, 100 ,'아이티',
					200 ,'영업팀'
					300 ,'관리팀',
						'기타부서') AS 부서이름
FROM T_EMP; 


CREATE TABLE KOSA.t_emp2(
	id number(2),
	job char(7) 
);

COMMIT;
SELECT * FROM t_emp2;
INSERT INTO t_emp2 VALUES(1,'1234567');
INSERT INTO t_emp2 VALUES(2,'2234567');
INSERT INTO t_emp2 VALUES(3,'3234567');
INSERT INTO t_emp2 VALUES(4,'4234567');
INSERT INTO t_emp2 VALUES(5,'5234567');
COMMIT;

SELECT * FROM t_emp2;

/*
 t_emp2 테이블에서 id,jumin 데이터를 출력하되 jumin 컬럼의 앞자리가 1이면 
 남성, 2이면 
 */
SELECT
	id
	, SUBSTR(job, 1, 1) AS 주민
	, DECODE(SUBSTR(job, 1, 1), '2', '여성'
						, '1', '남성'			
						, '3', '중성', '기타') AS 성별
FROM
	t_emp2;


-- case문
/*
 case 조건식 when 결과1 then 출력1
		   when 결과1 then 출력1
		   when 결과1 then 출력1
		   when 결과1 then 출력1
 		   else 출력 
  END "컬럼명"
 */

SELECT * FROM T_ZIP tz ;

SELECT '0' || TO_CHAR(zipcode)
	, CASE zipcode WHEN 2 THEN '서울'
	WHEN 31 THEN '경기'
	ELSE '기타'
	END 지역이름
FROM T_ZIP tz ;

/*
집계함수(그룹)
1. count(*) >> row수, count(칼럼명) >> 데이터 건수
2. sum() 
3. avg()
4. max()
5. min()
기타

1. 집계함수는 group by 절과 같이 사용
2. 모든 집계함수는 null갑 무시
3. select절애 집계함수 이외에 다른 칼럼이 오면 반드시 그칼럼은 group by졸에 명시
*/ 

SELECT COUNT(*) FROM emp;
SELECT COUNT(empno) FROM emp;
SELECT COUNT(comm) FROM emp;	--6 (null 아니 데이터 count)
SELECT COUNT(nvl(comm,0)) FROM emp;

SELECT sum(sal) FROM emp;

SELECT TRUNC(avg(sal))FROM emp;

SELECT SUM(comm) FROM emp; 


--수당의 평균은 얼마지?
SELECT trunc(avg(comm),0) FROM emp; 		--null인값 빼고 통계
SELECT trunc(avg(nvl(comm,0)),0) FROM emp;	-- null값 포함 통계

SELECT MAX(sal) FROM emp; 
SELECT Min(sal) FROM emp;

SELECT sum(sal) , avg(sal) , MAX(sal) , MIN(sal) , COUNT(*) ,count(sal) FROM emp;

SELECT empno, count(empno) FROM emp
GROUP BY empno;

--부서별 평균 급여를 구하세요
SELECT deptno, avg(sal)
FROM emp
GROUP BY DEPTNO;

--직종별 평균 급여
SELECT JOB, TRUNC(AVG(SAL)) 
FROM EMP e 
GROUP BY JOB;

SELECT JOB , avg(sal) , MAX(sal) , MIN(sal) , COUNT(*) ,count(sal) 
FROM EMP e
GROUP BY JOB 

/*
group 
distinct 컬럼명1, 컬럼명2 
order by 컬럼명1, 컬럼명2
group by 컬럼명1, 컬럼명2
 */

SELECT deptno, job, sum(sal) , COUNT(sal) 
FROM EMP e 
GROUP BY DEPTNO ,JOB 
ORDER BY DEPTNO ; --부서번호, 그안에서 직종별로 그룹 합계

-- 직종별 평균급여가 3000달러 이상인 사원의 직종과 평균급여를 출력하세용
SELECT job, AVG(sal) AS a
FROM emp
GROUP BY JOB
HAVING avg(sal) >= 3000
ORDER BY a;

--from 절의 조건절 >> WHERE 
--group by 절의 조건절 >> having (집계함수 조건을 처리)

SELECT * FROM emp;

SELECT job,sum(sal) 
FROM EMP e
WHERE COMM IS NOT null
GROUP BY JOB
HAVING sum(sal) >= 5000;

/* 
사원테이블에서 직종별 급여합을 출력하되 수당은 지급 받고 급여의 합이 5000 이상인 
사원들의 목록을 출력하세요  (comm 0인 놈도 받는 것으로 ....)
급여의 합이 낮은 순으로 출력하세요 
*/
SELECT job, sum(sal) AS sumsal
FROM EMP e 
WHERE comm IS NOT NULL 
GROUP BY JOB
HAVING sum(sal) >= 5000
ORDER BY sumsal DESC ;
--GROUP BY SAL 

/* 사원테이블에서 부서 인원이 4명보다 많은 부서의 부서번호 ,인원수 , 급여의 합을 출력하세요 */

SELECT DEPTNO ,count(*) AS 부서별인원수 ,sum(sal) AS 급여의합
FROM EMP e
GROUP BY DEPTNO 
HAVING count(*) > 4;

/* 사원테이블에서 직종별 급여의 합이 5000를 초과하는 직종과 급여의 합을 출력하세요
단 판매직종(salesman) 은 제외하고 급여합으로 내림차순 정렬하세요 */
SELECT job ,sum(sal) AS sumsal
FROM EMP e
WHERE job != 'SALESMAN'
GROUP BY job 
HAVING sum(sal) > 5000
ORDER BY sumsal desc;


-- 단일 테이블 쿼리 END
--ETC
--CREATE table(칼럼명 타입. )
CREATE Member3 {private int age; setter , getter}

--1건
/*
 데이터타입 
 문자열 데이터 타입
 char(10)		>> 10byte >> 한글 5자, 영문자, 특수, 공백 10자 >> 고정길이 문자열
 varchar2(10)	>> 10byte >> 한글 5자, 영문자, 특수, 공백 10자 >> 가변길이 문자열
 
 고정길이(데이터와 상관없이 크기를 갖는것)
 가변길이(들어오는 데이터 크기만큼 확보)
 
 char(10) >> 'abc' >> [][][]][][][][][][][] >> 공간크기 변화 없어요
 varchar2(10) >> 'abc' >> [a][b][c] >> 데이터 크기 만큼 공간 확보
 
 누가봐도 varchar2(10)
 
 성능....데이터 검색 >> char() >> 고정길이 ... 가변보다는 좀 앞서 검색
 
 char(2) :고정길이 (남,여....대중소 주민번호)
 
 한글 , 영어권 >> 한문자 >> unicode >> 한글, 영문 >>2byte
 
 nchar(20) >> 20자 >> 영문자 특수문자 공백 상관없이 >> 4byte
 nvarchar2(20) >> 20자
 */
  --오라클 함수 ......

select * from SYS.NLS_DATABASE_PARAMETERS;

--NLS_CHARACTERSET  : 	AL32UTF8  한글 3byte 인식
--KO16KSC5601 2Byte (현재 변환하면 한글 다깨짐)

select * from nls_database_parameters where parameter like '%CHAR%';
------------------------------------------------------------------------------
create table test2(name varchar2(2));

insert into test2(name) values('a');
insert into test2(name) values('aa');
insert into test2(name) values('가'); --한글 1자 3byte 인지
-------------------------------------------------------------------------------
​ COMMIT;


------------------------------------------
/*
Join 의 종류 
Join 방법 설 명

Cartesian Product 모든 가능한 행들의 Join
Equijoin Join 조건이 정확히 일치하는 경우 사용(일반적으로 PK 와 FK 사용)
Non-Equijoin Join 조건이 정확히 일치하지 않는 경우에 사용(등급,학점)
Outer Join Join 조건이 정확히 일치하지 않는 경우에도 모든 행들을 출력
Self Join 하나의 테이블에서 행들을 Join 하고자 할 경우에 사용
Set Operators 여러 개의 SELECT 문장을 연결하여 작성한다

Equijoin
Non-Equijoin 
Outer Join
Self Join

관계형 DB (RDBMS)
관계 (테이블과 테이블의 관계)


create table M (M1 char(6) , M2 char(10));
create table S (S1 char(6) , S2 char(10));
create table X (X1 char(6) , X2 char(10));

insert into M values('A','1');
insert into M values('B','1');
insert into M values('C','3');
insert into M values(null,'3');
commit;

insert into S values('A','X');
insert into S values('B','Y');
insert into S values(null,'Z');
commit;

insert into X values('A','DATA');
commit;

*/

SELECT * FROM M;
SELECT * FROM S;
SELECT * FROM X;

--1. 등가조인 
-- 대응대는 테이블에 있는 칼럼의 데이터를 1:1 매칭
-- SQL JOIN 문법 (오라클) 간단
-- ANSI 문법 권장 >> 무조건! >> [inner] join on 조건절
SELECT * 
FROM m,s
WHERE m.m1 = s.s1; 

SELECT m.M1, M2, s2 
FROM m,s
WHERE m.m1 = s.s1; 

--Ansi
SELECT *
FROM m JOIN S 
ON m.M1 = s.S1 ;

SELECT * FROM DEPT;
SELECT * FROM EMP; 
SELECT * FROM MEMBER; 

--사원번호 , 사원이름, 부서번호, 부서이름
SELECT EMP.EMPNO, EMP.ENAME, EMP.DEPTNO, DEPT.DNAME 
FROM EMP JOIN DEPT 
ON EMP.DEPTNO  = DEPT.DEPTNO ;

SELECT e.EMPNO, e.ENAME, e.DEPTNO, d.DNAME 
FROM EMP e JOIN DEPT d 
ON e.DEPTNO  = d.DEPTNO ;

--조인은 SELECT * 하고나서 칼럼을 명시
SELECT *
FROM s JOIN X
ON s.S1 = x.X1 ;
