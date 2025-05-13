import mysql.connector
from termcolor import colored

# Set password
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


id = input(colored('Enter Student ID:', 'red', attrs=['bold']) + '\n> ')
records = query_connection(f"CALL student_schedule_by_student_id({id})")

for row in records:
  print(f'\nPeriod: {row[1]}')
  print(f'Course: {row[2]}')
  print(f'Room: {row[3]}')
  print(f'Teacher: {row[4]} {row[5]}')
