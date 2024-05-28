-- Unions
-- allows you to combine rows together 
-- join: allows you to combine column together
SELECT first_name, last_name
FROM parks_and_recreation.employee_demographics
# UNION DISTINCT # only take teh unique values, UNION: default UNION DEFAULT, remove all the duplicates
UNION ALL # show all the data, instead of removing some same data
SELECT first_name, last_name
FROM parks_and_recreation.employee_salary
;

-- Case study
-- the department want to find out the old emplyees and also highly paid emplyees to push them out or reduce there salary
-- in order to reduce the company budgets
SELECT first_name, last_name, 'Old MAN' AS Label # old: label: used to identify the specific data
FROM parks_and_recreation.employee_demographics
WHERE age > 40 AND gender = 'male'
UNION 
SELECT first_name, last_name, 'Old Lady' AS Label # old: label: used to identify the specific data
FROM parks_and_recreation.employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION 
SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM parks_and_recreation.employee_salary
WHERE salary>70000
ORDER BY first_name, last_name
;