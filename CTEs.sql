-- CTEs
-- Common Table expression, allow you to define a subquery block
-- that you can reference in main query
-- you can only use CTE you needed it after you create it
-- purpose 1: make more advanced calculations whhich is not easy do in one query
-- puepose 2: readability
WITH CTE_Example AS -- with: keyword to define the cte
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example

;

SELECT AVG(avg_sal)
FROM (
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
) example_subquery


;

WITH CTE_Example AS -- with: keyword to define the cte
(
SELECT employee_id, gender, birth_date
FROM employee_demographics
WHERE birth_date > '1985-01-01'

),
CTE_example2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_example2
	ON CTE_Example.employee_id = CTE_example2.employee_id

;
-- default column name (gender, AVGsal, MAXsal, MINsal, COUNTsal)
WITH CTE_Example(gender, AVGsal, MAXsal, MINsal, COUNTsal) AS -- with: keyword to define the cte
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example

;