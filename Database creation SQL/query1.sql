DELIMITER $$
CREATE PROCEDURE schedule_for_course (IN pk_code CHAR(3), IN start_date DATE)
BEGIN
-- ToDo : declaring variable(s) !
DECLARE complete BOOLEAN DEFAULT FALSE;

-- cursor declaration+
DECLARE cur_coursecode CURSOR FOR
SELECT 'code' FROM module WHERE course_code = pk_code;
DECLARE CONTINUE HANDLER FOR NOT FOUND
SET complete = TRUE;

-- ToDo : checking course exists !
IF (pk_code) IS NULL THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = ' COURSE DOES NOT EXIST';
END IF;

-- ToDo : checking course start date !
IF (start_date,CURRENT_DATE() < 31) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = ' MINIMUM START DATE NEEDS TO BE A MONTH AHEAD';
END IF;

OPEN cur_coursecode; -- CURSOR;
loopy_doopy_do : LOOP -- name loop
FETCH NEXT FROM cur_coursecode INTO pk_code; -- put cursor into here

-- ToDo : when cursor runs out, each module has been processed !
IF complete THEN
LEAVE loopy_doopy_do;
END IF;

-- ToDo : checking for & skipping saturday & sunday !
IF DAYOFWEEK(start_date) = 1 THEN
SET start_date = DATE_ADD(start_date, INTERVAL 1 DAY);
ELSEIF DAYOFWEEK(start_date) = 7 THEN
SET start_date = DATE_ADD(start_date,INTERVAL 2 DAY);
END IF;

INSERT INTO `session`
(`code`, `date`, room)
VALUES
(pk_code, start_date,NULL);
SET start_date= DATE_ADD(start_date, INTERVAL 1 DAY);
END LOOP;
CLOSE cur_coursecode;
END $$

CALL schedule_for_course()
