
select * from employees;
select * from departments;
select * from locations;

--1. 
--각 부서에서 부서별 평균 급여보다 급여가 적은 사원의 수, 부서id, 부서 name, 부서가 위치한 도시를 
--부서별 평균 급여보다 급여가 적은 사원의 수가 가장 많은 순서대로 
--출력하세요.
-- 1.1 
SELECT e.DEPARTMENT_ID , e.SALARY ,a.avg_sal
FROM EMPLOYEES e JOIN (SELECT department_id, avg(SALARY) AS avg_sal FROM employees GROUP BY department_id) a
ON e.DEPARTMENT_ID = a.department_id
WHERE e.SALARY < a.avg_sal;


-- 1.2 
SELECT e.DEPARTMENT_ID ,count(e.DEPARTMENT_ID)AS rnk
FROM EMPLOYEES e JOIN (SELECT department_id, avg(SALARY) AS avg_sal FROM employees GROUP BY department_id) a
ON e.DEPARTMENT_ID = a.department_id
WHERE e.SALARY < a.avg_sal
GROUP BY e.DEPARTMENT_ID
ORDER BY rnk desc;

SELECT d.DEPARTMENT_ID AS deptno, d.DEPARTMENT_NAME AS deptname,l.CITY 
FROM LOCATIONS l JOIN DEPARTMENTS d 
ON l.LOCATION_ID = d.LOCATION_ID;

--1.3(최종)
CREATE OR REPLACE VIEW VIEW_1
AS
SELECT e.DEPARTMENT_ID AS deptno,count(e.DEPARTMENT_ID)AS cnt
FROM EMPLOYEES e JOIN (SELECT department_id, avg(SALARY) AS avg_sal FROM employees GROUP BY department_id) a
ON e.DEPARTMENT_ID = a.department_id 
WHERE e.SALARY <= a.avg_sal
GROUP BY e.DEPARTMENT_ID
ORDER BY cnt desc;

SELECT v.cnt, dept_info.* FROM VIEW_1 v LEFT OUTER JOIN (SELECT d.DEPARTMENT_ID AS deptno, d.DEPARTMENT_NAME AS deptname,l.CITY 
FROM LOCATIONS l JOIN DEPARTMENTS d 
ON l.LOCATION_ID = d.LOCATION_ID) dept_info ON
v.deptno = dept_info.deptno;


/*
근무도시별 평균 봉급, 평균 근속년수, 사원수를 계산하여,'도시명', '평균봉급', '평균근속년수', '총사원수' column명으로 출력하되 도시별 평균 봉급의 내림차순으로 정렬하시오.
근속년수를 계산할 때, 현재날짜를 2010년 1월 1일로 가정하고 근속 12개월마다 근속년수가 1씩 늘어나는 것으로 계산하시오.
예) 입사일이 2009-09-03인 사원은 근속년수가 0년이다.
(단, 근무부서나 근무지역이 없는 사원은 제외하고, 평균은 반올림하여 소수점 1자리까지 출력하라)
*/

SELECT Hire_date
FROM EMPLOYEES e ;

