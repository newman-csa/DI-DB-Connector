   CREATE VIEW student_schedules AS
   SELECT rosters.student_id,
          course_offerings.period,
          courses.course_name,
          rooms.room_name,
          teachers.first_name,
          teachers.last_name
     FROM rosters
LEFT JOIN course_offerings ON rosters.offering_id = course_offerings.offering_id
LEFT JOIN courses ON course_offerings.course_id = courses.course_id
LEFT JOIN rooms ON course_offerings.room_id = rooms.room_id
LEFT JOIN teachers ON course_offerings.teacher_id = teachers.teacher_id;


   CREATE VIEW teacher_schedules AS
   SELECT course_offerings.teacher_id,
          course_offerings.period,
          courses.course_name,
          rooms.room_name
     FROM course_offerings
LEFT JOIN courses ON course_offerings.course_id = courses.course_id
LEFT JOIN rooms ON course_offerings.room_id = rooms.room_id;


   CREATE VIEW student_grades AS
     WITH student_assignment_grades AS (
             SELECT grade_book.student_id,
                    course_offerings.course_id,
                    assignments.assignment_type,
                    grade_book.assignment_grade,
                    course_offerings.period
               FROM grade_book
          LEFT JOIN assignments ON grade_book.assignment_id = assignments.assignment_id
          LEFT JOIN course_offerings ON assignments.offering_id = course_offerings.offering_id
          ),
          uhhh AS (
             SELECT student_assignment_grades.student_id,
                    courses.course_name,
                    student_assignment_grades.period,
                    student_assignment_grades.assignment_type,
                    student_assignment_grades.assignment_grade,
                    courses.course_type
               FROM student_assignment_grades
          LEFT JOIN courses ON student_assignment_grades.course_id = courses.course_id
           GROUP BY student_assignment_grades.period,
                    courses.course_name,
                    student_assignment_grades.student_id,
                    student_assignment_grades.assignment_type,
                    student_assignment_grades.assignment_grade,
                    courses.course_type
          )
   SELECT student_id,
          course_name,
          period,
          course_type,
          (
          COALESCE(AVG(
          CASE
                    WHEN assignment_type = 'Major' THEN assignment_grade
          END
          ) * 0.3, 0) + COALESCE(AVG(
          CASE
                    WHEN assignment_type = 'Minor' THEN assignment_grade
          END
          ) * 0.7, 0)
          ) AS total_grade
     FROM uhhh
 GROUP BY student_id,
          course_name,
          period,
          course_type;
