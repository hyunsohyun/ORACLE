/*
SEQUENCE 특징 
1) 자동적으로 유일 번호를 생성합니다.
2) 공유 가능한 객체
3) 주로 기본 키 값을 생성하기 위해 사용됩니다.
4) 어플리케이션 코드를 대체합니다.
5) 메모리에 CACHE 되면 SEQUENCE 값을 액세스 하는 효율성을 향상시킵니다


REATE SEQUENCE sequence_name
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALUE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE | NOCACHE}];

**/


CREATE TABLE board(
	boardid NUMBER CONSTRAINT pk_board_boardid PRIMARY KEY,
	title nvarchar2(50)
);

SELECT * FROM USER_CONSTRAINTS WHERE table_name ='BOARD';

--not null , unique , index(검색속도)

--게시판 글쓰기 작업
INSERT INTO board(boardid, TITLE) values(1,'처음글');
INSERT INTO board(boardid, TITLE) values(2,'두번째글');

SELECT * FROM BOARD b ;

--처음 글을 쓰면 글번호가 1번 ... 그 다음글 순차적인 증가값 ... 2번, 3번
SELECT COUNT(boardid)FROM BOARD b ;

INSERT INTO board(boardid, TITLE)
values((SELECT COUNT(boardid)+1 FROM BOARD) ,'내용1');

INSERT INTO board(boardid, TITLE)
values((SELECT COUNT(boardid)+1 FROM BOARD) ,'내용2');

INSERT INTO board(boardid, TITLE)
values((SELECT COUNT(boardid)+1 FROM BOARD) ,'내용3');

COMMIT;
DELETE FROM BOARD b WHERE BOARDID =1;

INSERT INTO board(boardid, TITLE)
values((SELECT nvl(max(boardid),0)+1 FROM BOARD) ,'내용4');

--시퀀스 생성하기(순번 만들기) : 객체(create ....) : 순차적인 번호를 생성하는 객체
CREATE SEQUENCE board_num;
-- 순번
SELECT board_num.nextval FROM dual; -- 채번 (번호표 뽑기);
SELECT board_num.currval FROM dual; -- 현재까지 채번한 번호 확인(마지막)

--공유(객체) >> 하나의 테이블이 아니라 여러개의 테입ㄹ 사용


CREATE TABLE kboard(
	num NUMBER CONSTRAINT pk_kboard_num PRIMARY KEY,
	title nvarchar2(20)
);

CREATE SEQUENCE kboard_num;

INSERT INTO kboard(num,title) values(kboard_num.nextval,'처음글');
INSERT INTO kboard(num,title) values(kboard_num.nextval,'222');
INSERT INTO kboard(num,title) values(kboard_num.nextval,'333');

SELECT * FROM kboard;

--------------------------------------------------------------------------
/*
 공지사항 1
 자유게시판 
 공지사항 
 답변형게시판
 시퀀스 객체 한개 3개 테이블에서 (공유객체)
 
 TIP) 
 sequence 모든DB에 ...
 오라클 
 
--순번을 생성(테이블 종속적으로)
Ms-sql 
create table board(boardnum int identity(1,1) ... title
insert into board(title) values('제목'); >> boardnum >> 1이 자동

my-sql(auto_increment)
create table board()

*/
--옵션
CREATE SEQUENCE seq_num
START WITH 10
INCREMENT BY 2;

SELECT seq_num.nextval FROM dual;

-- 순법
-- 게시판 처음.... 데이터 가져올때 
-- 쿼리문
-- num > 1, 2 ,3 ,,,,,,, 1000 ,,,,,,,10000
-- 가장 나중에 쓴글(최신글
-- SELECT * FROM board ORDER BY num DESC;

-- rownum  의사컬럼 : 실제 물리적으로 존재 x 논리적 컬럼 (create table x 사용안되요)
-- rownum : 실제로 컬럼으로 존재하지 않지만 내부적으로 행 번호를 부여하는 컬럼

SELECT * FROM emp;


SELECT rownum, empno, ename FROM emp;

SELECT rownum, empno, ename ,sal
FROM emp
ORDER BY sal;
-- 실행순서 >> from >> select >> order by 

SELECT rownum ,a.*
from(
SELECT empno, ename ,sal
FROM emp
ORDER BY sal)a;

-- Top-n 쿼리 (기준이 되는 데이터 순으로 정렬시키고 상위 n개 가지고 오기)
-- MS-SQL : SELECT top 10 , * from emp order by sal desc;


-- Oracle Top n (x)
-- rownum (순번부여......상위 n)
-- 1. 정렬의 기준 설정하기 (선행)
-- 2. 정렬된 기준에 rownum 붙이고 ... 데이터 추출

-- 급여를 많이 받는 순으로 정렬된 데이터 (rownum) >> 순번
SELECT rownum ,a.*
from(
SELECT empno, ename ,sal
FROM emp
ORDER BY sal desc
)a;


--급여를 많이 받는 사원 5명
SELECT
	*
FROM
	(
	SELECT
		rownum AS num,
		a.*
	FROM
		(
		SELECT
			empno,
			ename ,
			sal
		FROM
			emp
		ORDER BY
			sal DESC
		)a
)n
WHERE
	num <= 5; -- 대용량 데이터 페이징 처리 원리(TODAY POINT)
	
-- between A and B

----------------------------------------
-- 기업(10만건 ~ 1억건)
-- 게시판 (게시글 10만건)
-- SELECT * from board >> 10만건 조회....
-- 10만건 나누어서 (10건씩, 20건씩)
/*
 totaldata = 100건
 pagesize = 10 한 화면에 보여지는 데이터 row 수 : 10 건
 page 개수 >> 10개
  
  [1][2][3][4][5][6][7][8][9][10]
  <a href = "page.jsp?page=1">1</a>
  1page 클릭 >> 1~10까지 글 : DB 쿼리 : select num between 1 and 10
  2page 클릭 >> 11~20까지 글 : DB 쿼리 : select num between 11 and 20
  3page 클릭 >> 21~30까지 글 : DB 쿼리 : select num between 21 and 30
  
  1. rownum
  2. between
  
*/
	
	
-----------------------------------------------------



