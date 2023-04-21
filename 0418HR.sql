SELECT * FROM EMPLOYEES e ;

SELECT 
	LAST_NAME || FIRST_NAME AS fullname,
	TO_CHAR(HIRE_DATE ,'YYYY-MM-DD') AS 입사일,
	SALARY * 12 AS "연봉",
	to_char((SALARY * 12) * 1.1,'$999,999') AS "연봉 10퍼"
FROM EMPLOYEES e
WHERE TO_CHAR(HIRE_DATE,'YYYY') >= 2005
ORDER BY 연봉 DESC;


SELECT EMPLOYEE_ID ,LAST_NAME ,SALARY ,DEPARTMENT_ID , DECODE(DEPARTMENT_ID ,'20' ,DECODE(LAST_NAME,'Smith','Hello','world') ,'etc')AS result
FROM EMPLOYEES e ;

/* 
조건식이 필요하다면
CASE WHEN 조건 비교식 THEN 
	WHEN 조건 비교식 THEN  
	ELES
END
*/

SELECT SALARY 
,CASE WHEN SALARY > 4000 THEN '특급'
	WHEN SALARY > 3000 THEN '1급'  
	WHEN SALARY > 2000 THEN '2급'  
	WHEN SALARY > 1000 THEN '3급'  
	ELSE '4급'
END 사원급여
FROM EMPLOYEES e ;


--SELECT SALARY 
--,CASE WHEN SALARY > 4000 THEN '특급'
--	WHEN SALARY <= 4000 AND SALARY > 3000 THEN '1급'  
--	WHEN SALARY <= 3000 AND SALARY > 2000 THEN '2급'  
--	WHEN SALARY <= 2000 AND SALARY > 1000 THEN '3급'  
--	ELSE '4급'
--END 사원급여
--FROM EMPLOYEES e ;
--
--SELECT SALARY 
--,CASE WHEN SALARY > 4000 THEN '특급'
--	WHEN SALARY BETWEEN 3000 AND 4000 THEN '1급'  .
--	WHEN SALARY BETWEEN 2000 AND 3000 THEN '2급'  
--	WHEN SALARY BETWEEN 1000 AND 2000 THEN '3급'  
--	ELSE '4급'
--END 사원급여
--FROM EMPLOYEES e ;

/*
HR 계정으로 이동하세요

1. EMPLOYEES 테이블을 이용하여 다음 조건에 만족하는 행을 검색하세요. 
2005년이후에 입사한 사원 중에 부서번호가 있고, 급여가 5000~10000 사이인 사원을 검색합니다. 
가) 테이블 : employees 
나) 검색 : employee_id, last_name, hire_date, job_id, salary, department_id 
다) 조건
    ① 2005년 1월 1일 이후 입사한 사원
    ② 부서번호가 NULL이 아닌 사원 
    ③ 급여가 5,000보다 크거나 같고, 10,000 보다 작거나 같은 사원 
    ④ 위의 조건을 모두 만족하는 행을 검색 
라) 정렬: department_id 오름차순, salary 내림차순

*/

SELECT EMPLOYEE_ID ,LAST_NAME ,HIRE_DATE ,JOB_ID , SALARY ,DEPARTMENT_ID 
FROM EMPLOYEES e
WHERE (SALARY BETWEEN 5000 AND 10000) 
	AND TO_CHAR(HIRE_DATE,'YYYY') >= 2005 
	AND DEPARTMENT_ID IS NOT NULL
ORDER BY DEPARTMENT_ID ASC, SALARY desc;


/*
2. EMPLOYEES 테이블을 이용하여 다음 조건에 만족하는 행을 검색하세요. 
부서번호가 있고, 부서별 근무 인원수가 2명 이상인 행을 검색하여 부서별 최대 급여와 최소 급여를 계산하
고 그 차이를 검색합니다. 
가) 테이블 : employees 
나) 검색 : department_id, MAX(salary), MIN(salary), difference 
        - MAX(salary) 와 MIN(salary)의 차이를 DIFFERENCE로 검색 
다) 조건
    ① 부서번호가 NULL이 아닌 사원 
    ② 부서별 근무 인원수가 2명 이상인 집합 
라) 그룹 : 부서번호가 같은 행
마) 정렬 : department_id 
*/

SELECT DEPARTMENT_ID , max(SALARY), min(SALARY),max(SALARY)- min(SALARY) AS difference
FROM EMPLOYEES e 
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)> 2  
ORDER BY DEPARTMENT_ID;
