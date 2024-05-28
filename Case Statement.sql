-- Case Statement

SELECT first_name,
last_name,
CASE 
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'old'
    WHEN age >= 50 THEN "On Death's Door"
END AS Label
FROM parks_and_recreation.employee_demographics;

-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finace = 10% bonus
SELECT first_name, 
last_name,
salary,
dept_id,
CASE
	WHEN salary < 50000 THEN salary+salary*0.05
    WHEN salary > 50000 THEN salary+salary*0.07
END AS New_Salary,

CASE
	WHEN dept_id = 6 THEN salary*0.1
END AS Bonus
FROM employee_salary;