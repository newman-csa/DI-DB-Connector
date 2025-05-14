import mysql.connector
from termcolor import cprint, colored

# pip install mysql-connector-python
# pip install termcolor
# pip install tabulate

#! Set password
def open_connection():
    connection = mysql.connector.connect(user='logann24',
                                        password='',
                                        host='10.8.37.226',
                                        database='logann24_db')
    
    return connection


def query_connection(query):
   connection = open_connection()
   cursor = connection.cursor()
   cursor.execute(query)
   data = cursor.fetchall()
   cursor.close()
   connection.close()
   return data


def print_teacher_schedule(id):
    records = query_connection(f"CALL teacher_schedule_by_teacher_id({id})")

    for row in records:
        print(f'\nPeriod: {row[1]}')
        print(f'Course: {row[2]}')
        print(f'Room: {row[3]}')


def print_student_schedule(id):
    records = query_connection(f"CALL student_schedule_by_student_id({id})")

    for row in records:
        print(f'\nPeriod: {row[1]}')
        print(f'Course: {row[2]}')
        print(f'Room: {row[3]}')
        print(f'Teacher: {row[4]} {row[5]}')

cprint('(T)eacher or (S)tudent', 'red', attrs=['bold'])
student_or_teacher = input('> ').lower()

cprint('\nEnter ID:', 'red', attrs=['bold'])
id = input('> ')

if student_or_teacher == 's':
    print_student_schedule(id)
elif student_or_teacher == 't':
    print_teacher_schedule(id)

