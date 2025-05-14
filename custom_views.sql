CREATE VIEW student_schedules
AS
SELECT rosters.student_id, course_offerings.period, courses.course_name, rooms.room_name, teachers.first_name, teachers.last_name 
FROM rosters  
LEFT JOIN course_offerings ON rosters.offering_id = course_offerings.offering_id  
LEFT JOIN courses ON course_offerings.course_id = courses.course_id  
LEFT JOIN rooms ON  course_offerings.room_id = rooms.room_id  
LEFT JOIN teachers ON  course_offerings.teacher_id = teachers.teacher_id;


CREATE VIEW teacher_schedules 
AS
SELECT course_offerings.teacher_id, course_offerings.period, courses.course_name, rooms.room_name 
FROM course_offerings
LEFT JOIN courses ON course_offerings.course_id = courses.course_id  
LEFT JOIN rooms ON  course_offerings.room_id = rooms.room_id;
