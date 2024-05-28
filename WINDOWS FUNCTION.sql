-- Window Functions

SELECT gender, AVG(salary) AS avg_salary
FROM parks_and_recreation.employee_demographics as dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;

-- give us all individual rows
-- 
SELECT dem.first_name, dem.last_name,gender, salary ,SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_total
FROM parks_and_recreation.employee_demographics as dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;

-- ROW_NUMBER(): no duplicates
-- RANK(): duplicates are pocisible, after duplicate. the number is positionaly
-- DENSE_RANK(): after duplicate. the number is numerically
SELECT dem.employee_id, dem.first_name, dem.last_name,gender, salary ,
ROW_NUMBER() OVER(partition by gender order by salary desc) AS row_num,
RANK() OVER(partition by gender order by salary desc) AS rank_num,
DENSE_RANK() OVER(partition by gender order by salary desc) AS dense_rank_num
FROM parks_and_recreation.employee_demographics as dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;