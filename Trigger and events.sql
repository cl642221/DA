-- Triggers and Events

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    -- BEFORE INSERT ON employee_salary data is deleted in the salary_table
	-- you do something
    FOR EACH ROW -- this trigger will activate several times(how many rows you insterted in)
    BEGIN
		INSERT INTO employee_demographics (employee_id, first_name, last_name)
        VALUES (NEW.employee_id, NEW.first_name, NEW.last_name); -- new meas after the trigger, the data be inserted
    END $$
    DELIMITER ;
INSERT INTO employee_salary(employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13, 'CHEN', 'LU', 'entertaiment 720 CEO', '10000000', NULL);

-- EVENTS
-- take place when its scheduled
-- scheduled automator rather than a trigger that happens when an 
-- event take place 

SELECT *
FROM employee_demographics;
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 second
DO 
BEGIN
	DELETE 
	FROM employee_demographics
    WHERE age>=60;
END $$
DELIMITER ;

SHOW VARIABLES LIKE 'event%' ; -- sometimes the event scheduler may be off, you
-- need to make it on
-- ohter problem: no permission to deleted things

