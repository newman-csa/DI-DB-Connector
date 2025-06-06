SHOW PROCEDURE STATUS WHERE Db = 'logann24_db';

DELIMITER //
CREATE PROCEDURE student_schedule_by_student_id(id INTEGER)
BEGIN
SELECT * FROM student_schedules
WHERE student_id = id
ORDER BY period;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE teacher_schedule_by_teacher_id(id INTEGER)
BEGIN
SELECT * FROM teacher_schedules
WHERE teacher_id = id
ORDER BY period;
END //
DELIMITER ;


DELIMITER // 
   CREATE PROCEDURE class_grades_by_student_id (id INTEGER) 
    BEGIN
   SELECT course_name, period, course_type, total_grade FROM student_grades
    WHERE student_id = id
 ORDER BY period;
      END // 
DELIMITER ;


DELIMITER // 
   CREATE PROCEDURE average_grade_by_student_id (id INTEGER) BEGIN
   SELECT AVG(weighted_average) AS weighted_average
     FROM (
             SELECT CASE
                              WHEN course_type = 'AP' THEN total_grade * 1.1
                              WHEN course_type IN ('Regents', 'Elective') THEN total_grade
                    END AS weighted_average
               FROM student_grades
              WHERE student_id = id
          ) AS sub;
      END // 
DELIMITER ;


DELIMITER // 
   CREATE PROCEDURE grades_by_assignment_id (id INTEGER) BEGIN
   SELECT students.first_name, 
          students.last_name, 
          grade_book.assignment_grade   
     FROM course_offerings  
     LEFT JOIN assignments ON course_offerings.offering_id = assignments.offering_id  
     LEFT JOIN grade_book ON assignments.assignment_id = grade_book.assignment_id  
     LEFT JOIN students ON grade_book.student_id = students.student_id 
    WHERE assignments.assignment_id = id;
      END // 
DELIMITER ;

