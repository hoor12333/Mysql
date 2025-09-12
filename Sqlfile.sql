-- 0. Create a new database (if you don’t already have one)
CREATE DATABASE school_db;

-- 1. Select the database to use
USE school_db;

-- 2. Create the students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

-- 3. Create the courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 4. Insert sample data into students
INSERT INTO students (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

-- 5. Insert sample data into courses
INSERT INTO courses (course_id, student_id, course_name) VALUES
(101, 1, 'Math'),
(102, 1, 'Science'),
(103, 2, 'History');

-- 6. LEFT JOIN: Get all students with their courses (if any)
SELECT 
    s.student_id,
    s.student_name,
    c.course_name
FROM students s
LEFT JOIN courses c
    ON s.student_id = c.student_id;
    -- FULL OUTER JOIN in MySQL (simulated using UNION)

-- 0. Make sure you’re in the right databas

-- 1. LEFT JOIN: Get all students with their courses (if any)
SELECT 
    s.student_id,
    s.student_name,
    c.course_name
FROM students s
LEFT JOIN courses c
    ON s.student_id = c.student_id;
