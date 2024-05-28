-- where clause
-- AND OR NOR -- Logical Operators
-- LIKE Statement
	-- %: anythng
	-- and:
	-- _: underscore, means a specific value
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name = 'Leslie';

# check if the table include NULL
# 出现这一行 NULL 的原因可能是因为结果集中包含了多余的空行或 SQL 客户端工具自动在结果集中添加了一行以便于用户输入新的数据。这个行为取决于你使用的 SQL 客户端工具。
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name IS NULL
   OR last_name IS NULL
   OR age IS NULL
   OR gender IS NULL
   OR birth_date IS NULL
   OR employee_id IS NULL;
   
-- AND OR NOR -- Logical Operators
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date >= '1977-03-27'
	AND NOT gender = 'female';

-- LIKE Statement
-- %: anythng
-- and:
-- _: underscore, means a specific value
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE 'a___%' ;# we can search some keywords not exactly specific
