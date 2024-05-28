-- Limit & Aliasing
-- LIMIT: how many rows you want in your output 
-- Aliasing: change the name of the column, always use in joints

-- Limit
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2,1; # start 2.row, want to get the row after 2.row

-- Aliasing
SELECT gender, AVG(age) AS avg_age
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40;