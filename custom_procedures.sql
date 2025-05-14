SHOW PROCEDURE STATUS WHERE Db = 'logann24_db';

DELIMITER //
CREATE PROCEDURE student_schedule_by_student_id(id INTEGER)
BEGIN
SELECT * FROM student_schedules
WHERE student_id = id
ORDER BY period;
END//
DELIMITER ;//


DELIMITER //
CREATE PROCEDURE teacher_schedule_by_teacher_id(id INTEGER)
BEGIN
SELECT * FROM teacher_schedules
WHERE teacher_id = id
ORDER BY period;
END//
DELIMITER ;//


