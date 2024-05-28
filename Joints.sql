-- JOINT
-- allow you to combine two tables more together if they have common column
-- column name may not same, but there is similar data you can use
-- TYPES
-- inner-joints;return same column in both tables
-- outer-joints; left joint: 左边table所有信息，右边table选取匹配左边table的信息, 然后将结果合在一起/ 
			  -- right joint: 和left反过来
-- self-joints: joint the table to itself, 需要对应不同信息时
-- Joining multiple table together
SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT  *
FROM parks_and_recreation.employee_salary;

-- Inner Joints
SELECT *
FROM parks_and_recreation.employee_demographics AS dem
INNER JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
    # 只将满足on之后条件的所有列合在一起
    ;
		-- select specific column
SELECT dem.employee_id, age, salary
FROM parks_and_recreation.employee_demographics AS dem
INNER JOIN parks_and_recreation.employee_salary AS sa
	ON dem.employee_id = sa.employee_id
   
    ;
    
    
-- Outer Joint: left joint / right joint    

SELECT *
FROM parks_and_recreation.employee_demographics AS dem 
RIGHT JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
    # 只将满足on之后条件的列所包含的所有信息合在一起
    ;


-- Self Joint
SELECT emp1.employee_id AS emp_santa, 
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name, 
emp2.first_name AS first_name,
emp2.last_name AS last_name
FROM parks_and_recreation.employee_salary AS emp1
JOIN parks_and_recreation.employee_salary AS emp2
	ON emp1.employee_id + 1  = emp2.employee_id
    ;


-- Joining multiple table together

SELECT *
FROM parks_and_recreation.employee_demographics AS dem
INNER JOIN parks_and_recreation.employee_salary AS sa
	ON dem.employee_id = sa.employee_id
INNER JOIN parks_departments AS pd # parks_departments : this table is a reference, no repeating in it
	ON sa.dept_id = pd.department_id
   
    ;
