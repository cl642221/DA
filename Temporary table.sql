-- Temporary Tables
-- first way to have a table
 CREATE TEMPORARY TABLE temp_table
( first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES('Alex', 'Freberg', 'Lord of the rings: the two towers'); 

SELECT *
FROM temp_table;
-- second way to have a table

SELECT *
FROM parks_and_recreation.employee_salary;

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k; 
