-- 0. Create a new database (if you don’t already have one)
CREATE DATABASE IF NOT EXISTS school_db;

-- 1. Select the database
USE school_db;

-- 2. Drop tables if they already exist (to avoid errors when re-running)
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;

-- 3. Create the students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

-- 4. Create the courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 5. Insert sample data into students
INSERT INTO students (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

-- 6. Insert sample data into courses
INSERT INTO courses (course_id, student_id, course_name) VALUES
(101, 1, 'Math'),
(102, 1, 'Science'),
(103, 2, 'History');

-- 7. LEFT JOIN query: get all students with their courses (if any)
SELECT 
    s.student_id,
    s.student_name,
    c.course_name
FROM students s
LEFT JOIN courses c
    ON s.student_id = c.student_id;
