DROP TABLE score;
DROP TABLE department;

--학과 테이블
--학과코드 데이터는 중복되거나 NULL 값을 허용하면 안된다,
--학과명 은 null값을 허락하지 않는다
CREATE TABLE department(
	department_code char(1) PRIMARY KEY,
	department_name varchar2(20) NOT NULL
);

CREATE TABLE score(
	id NUMBER PRIMARY KEY,
	name varchar2(20) NOT NULL,
	department_code char(1),
	kor NUMBER DEFAULT 0,
	eng NUMBER DEFAULT 0,
	math NUMBER DEFAULT 0,
	score_sum NUMBER  GENERATED ALWAYS AS (kor+eng+math) virtual,
	score_avg NUMBER  GENERATED ALWAYS AS (trunc((kor+eng+math)/3)) virtual
	
	CONSTRAINT fk_score_department_code FOREIGN key(department_code) REFERENCES department(department_code);
);


ALTER TABLE score 
ADD CONSTRAINT fk_score_department_code FOREIGN key(department_code) REFERENCES department(department_code);

--샘플 데이터 insert ..
--그리고 select 결과는

INSERT INTO department(department_code, department_name) VALUES('e','전자공학과'); 
INSERT INTO department(department_code, department_name) VALUES('m','물리학과');
INSERT INTO department(department_code, department_name) VALUES('c','컴퓨터공학과'); 

SELECT * FROM department;

INSERT INTO score(id, name, department_code, kor, eng, math) VALUES(1,'현소현','c',85,95,95); 
INSERT INTO score(id, name, department_code, kor, eng, math) VALUES(2,'서장대','c',95,95,95); 
INSERT INTO score(id, name, department_code, kor, eng, math) VALUES(3,'오승환','m',100,95,95); 
INSERT INTO score(id, name, department_code, kor, eng, math) VALUES(4,'남동우','c',85,95,100); 
INSERT INTO score(id, name, department_code, kor, eng, math) VALUES(5,'김의진','e',100,80,100); 

SELECT * FROM score;

--학번 , 이름 , 총점, 평균 , 학과코드 , 학과명 을 출력하세요
SELECT s.id, s.name, s.score_sum , s.score_avg , d.department_code, d.department_name
FROM score s JOIN department d
ON s.department_code = d.department_code;
