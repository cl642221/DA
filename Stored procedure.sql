-- Stored procedure

SELECT *
FROM employee_salary
WHERE salary >= 50000;


CREATE PROCEDURE large_salary()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salary();

DELIMITER $$
CREATE PROCEDURE large_salary3()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000; -- create a procedure
	SELECT * -- random query
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salary3();

DELIMITER $$
CREATE PROCEDURE large_salary6(para_employee_id INT)
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id = para_employee_id; -- create a procedure
	
END $$
DELIMITER ;

CALL large_salary6(1)