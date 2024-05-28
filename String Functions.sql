-- String Functions
-- length
SELECT LENGTH('skyfall'); # can be used in data cleansing 

SELECT first_name, LENGTH(first_name)
FROM parks_and_recreation.employee_demographics
ORDER BY LENGTH(first_name);

-- upper and lower : practical to correct the simple standardization issues
SELECT UPPER('abcd') AS upper_case; # turn the letters to the upper case
SELECT LOWER('SKYNNNNNN') AS lower_case; # turn the letters to the lower case

SELECT first_name, LENGTH(first_name), UPPER(first_name)
FROM parks_and_recreation.employee_demographics
ORDER BY LENGTH(first_name);

-- trim, get rif of white space (all, left, right white space)

SELECT TRIM('        sky      ') AS sky;

SELECT LTRIM('        sky      ') AS sky;

SELECT RTRIM('        sky      ') AS sky;

-- LEFT & RIGHT & SUBSTRING
-- how many characters do you select from left right, or from any position you want to select
SELECT first_name, 
LEFT(first_name, 4), 
RIGHT(first_name, 4),
SUBSTRING(first_name, 3, 2), # SUBSTRING(items, start position, Nr.characters you want to selected)
birth_date,
SUBSTRING(birth_date, 6,2) AS Birth_Month
FROM parks_and_recreation.employee_demographics;

-- replace
SELECT first_name, REPLACE(first_name, 'a','z')
FROM parks_and_recreation.employee_demographics;

-- locate
SELECT locate('x', 'Alex');

SELECT first_name, LOCATE('An', first_name)
FROM parks_and_recreation.employee_demographics;

-- concatination of multiple columns, super usefull
SELECT first_name, last_name, 
CONCAT(first_name, ' ', last_name) AS full_name
FROM parks_and_recreation.employee_demographics;