SELECT courses.course_name, course_offerings.period FROM course_offerings
LEFT JOIN courses ON courses.course_id = course_offerings.course_id
WHERE teacher_id = 1;

SELECT assignments.assignement_name
