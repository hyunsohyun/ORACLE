/*
 하나의 테이블에 대해서 작업 가능
 JAVA에서 EMP 테이블 접근(CRUD)
 APP(JAVA)
 MVC(패턴) >> model(DTO,DAO,SERVICE), view(html,jsp) controller(servlet) (니가 잘하는 것만 해) 

 DB 작업(DAO) >> EmpDao.java >> DB연결 (CRUD)
 기본적 5개함수 생성
 1. 전체조회 (함수) : select * from emp 처리 함수
 >> 데이터 여러건
 >> public List<Emp> getEmpList() {}
 
 2. 조건조회 (함수) : select * from emp where empno = ?
 >> public Emp getEmpListByEmpno(int empno){ }
 
 3. 삽입 (함수) insert into emp(...)
 >> public int insertEmp(Emp emp) 
 
 4. 수정 (함수) update emp set
 
 
 5. 삭제 (함수) delete emp where

 
  DDL(create, alter, drop, rename ) 테이블(객체) 생성, 수정, 삭제
  -- 코드 몰라도 ... TOOL 마우스 ...코드 폼나게 살자
  
  
 */


select * from tab;
select * from tab WHERE TNAME = LOWER('board') ;

CREATE TABLE board(
	boardid NUMBER,
	title nvarchar2(50), 	--영문자 특수 공백 상관없이 50자
	content nvarchar2(2000), -- 2000자
	regdate date
);

COMMIT;
SELECT  * FROM user_tables;
WHERE LOWER(TABLE_NAME) = 'board';
SELECT COL FROM user_tables;

-- 제약정보 확인하기(반드시)
SELECT * FROM USER_CONSTRAINTS ;

SELECT * FROM USER_CONSTRAINTS WHERE LOWER(TABLE_NAME) = 'board';

-- oracle 11g >> 실무 >> 가상컬럼(조합칼럼)
-- 학생 성적 테이블(국어, 영어, 수학)
-- 합계 평균 ....
-- 학생 성적 테이블 (국어 영어 수학 평균)
-- 각각의 점수 변화 >> 평균의 값 변화 보장 >> 무결성

CREATE TABLE vtable (
 no1 NUMBER,
 no2 NUMBER,
 no3 NUMBER GENERATED ALWAYS AS (no1+no2) virtual
);

SELECT * FROM vtable;
COMMIT;

SELECT * FROM col WHERE LOWER(TNAME) = 'vtable';

INSERT INTO vtable(no1,no2) VALUES(10,20);
--INSERT INTO vtable(no1,no2,no3) VALUES(10,20,30); (x)

-- 실무에서 활용되는 코드
-- 제품정보(입고) : 분기별 데이터 추출(4분기)

CREATE TABLE vtable2 (
 no NUMBER, --순번
 p_code char(4), --제품코드 (A001,B003)
 p_date char(8), --입고일 (20230101)
 p_qty NUMBER, --수량
 p_bungi NUMBER(1) GENERATED ALWAYS AS (
 											CASE WHEN substr(p_date,5,2) IN ('01','02','03') THEN 1
 												 WHEN substr(p_date,5,2) IN ('04','05','06') THEN 2
 												 
 												 WHEN substr(p_date,5,2) IN ('07','08','09') THEN 3
 												ELSE 4
 											end
 										) virtual
);

COMMIT;

SELECT * FROM col WHERE LOWER(TNAME) = 'vtable2';

SELECT * FROM vtable2;

INSERT INTO vtable2(p_date) values('20220101');
INSERT INTO vtable2(p_date) values('20220501');
INSERT INTO vtable2(p_date) values('20220601');
INSERT INTO vtable2(p_date) values('20221101');
INSERT INTO vtable2(p_date) values('20221201');

COMMIT;


SELECT * FROM vtable2(p_date);

--------------------------------------------------------------------------
-- 테이블 만들고 수정 삭제
-- 1. 테이블 생성하기
CREATE TABLE temp6(id number);

-- 2. 테이블 성성 후에 컬럼 추가하기
ALTER TABLE temp6 
ADD ename varchar2(20);

COMMIT;

SELECT * FROM temp6;

-- 3. 기본 테이블에 있는 컬럼이름 잘못표기 (ename -> username )
--기존 테이블 있는 기존 컬럼 이름 바꾸기 (rename)
ALTER TABLE temp6
RENAME column ename TO username; 

-- 4. 기존 테이블에 있는 기존 컬럼의 타입크기 수정 (기억) modify
ALTER TABLE temp6
MODIFY (username varchar2(2000));

--5. 기존 테이블에 기존 컬럼 삭제
ALTER TABLE temp6
DROP COLUMN username;

DESC temp6;

-- 6. 테이블 전체가 필요없어요
-- 6.1 DELETE 데이터만 삭제 
-- 테이블 처음 만들면 크기설정 >> 데이터 넣으면 >> 데이터 크기만큼 테이블 크기 증가
-- 처음 1M >> 데이터 10만건(insert) >> 100M >> delete 10만건 삭제 >> 테이블 크기 100M


-- 테이블 (데이터) 삭제(공간의 크기도 줄일 수 없을까)
-- TRUNCATE ( 단점 : where 절 사용 못해요)
-- 처음 1M >> 데이터 10만건(insert) >> 100M >> delete 10만건 삭제 >> 테이블 크기 100M
-- truncate table emp -- DBA (관리자)

-- 테이블 삭제
DROP TABLE temp6;

---
/*
 * 제약조건 설명
	PRIMARY KEY(PK) 유일하게 테이블의 각행을 식별(NOT NULL 과 UNIQUE 조건을 만족)
	FOREIGN KEY(FK) 열과 참조된 열 사이의 외래키 관계를 적용하고 설정합니다.
	UNIQUE key(UK) 테이블의 모든 행을 유일하게 하는 값을 가진 열(NULL 을 허용)
	NOT NULL(NN) 열은 NULL 값을 포함할 수 없습니다.
	CHECK(CK) 참이어야 하는 조건을 지정함(대부분 업무 규칙을 설정

	제약은 아니지만 default sysdate ....
*/

-- PRIMARY KEY(PK) : NOT NULL과 UNIQUE조건 >> null 데이터와 중복값 안되요
-- 보장 (유일값)
-- empno primary key >> where empno =77888 >> 데이터 1건 보장
-- PK (주민번호, ID)
-- 성능 (PK 자동으로 index ...) >> 조회 empno >> 성능 >> index >> 자동생성

-- 테이블당 1개만 설정 (1개의 의미는 (묶어서)) >> 복합키

-- 언제 
-- 1. create table 생성시 제약 생성
-- 2. create table 생성후에 필요에 따라서 추가 (alter table emp add constraint)

-- 제약확인
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME ='EMP';

CREATE TABLE temp7(
-- id number primary key 권장하지 않아요 (제약이름 자동설정 ... 제약편집 ...)
id NUMBER CONSTRAINT pk_temp7_id PRIMARY KEY, -- 개발자 제약 이름 :  pk_temp7_id
name varchar2(20) NOT NULL,
addr varchar2(50)
) ;
 
COMMIT;

--INSERT INTO temp7 (name,addr) values('홍길동','서울시 강남구'); --cannot insert NULL into ("KOSA"."TEMP7"."ID")
INSERT INTO temp7 (id,name,addr) values(10,'홍길동','서울시 강남구');
SELECT * FROM TEMP7 t ;
INSERT INTO temp7 (id,name,addr) values(10,'야무지개','서울시 강남구');--unique constraint (KOSA.PK_TEMP7_ID) violated

-- Unique (UK) 테이블의 모든 행을 유일하게 하는 값을 가진 열 (NULL을 허용)

CREATE TABLE temp8(
id NUMBER CONSTRAINT pk_temp8_id PRIMARY KEY, -- 개발자 제약 이름 :  pk_temp7_id
name varchar2(20) NOT NULL,
jumin nvarchar2(6) CONSTRAINT uk_temp8_jumin unique,
addr varchar2(50)
) ;

INSERT INTO temp8 (ID, NAME, JUMIN, ADDR) values(10,'홍길동','123456','경기도');

SELECT * FROM temp8;

INSERT INTO temp8 (ID, NAME, JUMIN, ADDR) values(20,'길동','123456','경기도'); --unique constraint (KOSA.UK_TEMP8_JUMIN) violated

INSERT INTO temp8 (ID, NAME, ADDR) values(20,'길동','경기도'); 

--그럼 null 도 중복체크 하나요(아니요)

-- 테이블 생성후에 제약 걸기(추천)
CREATE TABLE temp9(id number);

ALTER TABLE temp9
ADD CONSTRAINT pk_temp9_id PRIMARY KEY(id);

SELECT * FROM USER_CONSTRAINTS WHERE lower(table_name) = 'temp3';

--ADD CONSTRAINT pk_temp9_id PRIMARY KEY(id,num); --복합키
--유일한 한개의 ROW >> WHERE id=100 AND num -1

--컬럼 추가
ALTER TABLE temp9
ADD ename varchar2(50);

--
ALTER TABLE temp9
MODIFY (ename NOT null);

COMMIT;

-------------------------------------
-- check 제약(업무 규칙 : where 조건을 쓰는 것 처럼)
-- where gender in ('남','여')

CREATE TABLE temp10(
	id NUMBER CONSTRAINT pk_temp10_id PRIMARY KEY,
	name varchar2() NOT NULL,
	jumin char(6) NOT NULL CONSTRAINT uk_temp10_jumin unique,
	addr varchar2(30),
	age NUMBER CONSTRAINT ck_temp10_age check(age >= 19)
);



CREATE TABLE c_emp
AS SELECT empno, ename ,deptno FROM emp WHERE 1=2;

CREATE TABLE c_dept
AS SELECT deptno,DNAME  FROM dept WHERE 1=2;

SELECT * FROM c_emp;

-- 강제 (FK)
ALTER TABLE c_emp 
ADD CONSTRAINT fk_c_emp_deptno FOREIGN key(deptno) REFERENCES c_dept(deptno);
-- c_deptdp deptno 컬럼이 신용이 없어요(PK, UNIQUE) ...

ALTER TABLE c_emp
ADD CONSTRAINT pk_c_dept_deptno PRIMARY KEY(deptno);

