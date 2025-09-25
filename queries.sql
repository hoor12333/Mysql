-- ===============================
-- 1. Drop tables if they exist (for clean re-runs)
-- ===============================
CREATE DATABASE db_practice;
USE db_practice;

DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Departments;

-- ===============================
-- 2. Create Tables
-- ===============================
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    marks INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- ===============================
-- 3. Insert Sample Data
-- ===============================
INSERT INTO Departments (dept_id, dept_name) VALUES
(101, 'Computer Science'),
(102, 'Mathematics'),
(103, 'Physics');

INSERT INTO Students (student_id, name, dept_id, marks) VALUES
(1, 'Alice', 101, 85),
(2, 'Bob', 102, 76),
(3, 'Carol', 101, 92),
(4, 'David', 103, 65),
(5, 'Eve', 102, 88);

-- ===============================
-- 4. Practice Queries
-- ===============================

-- Query 1: INNER JOIN - Students with their Department
SELECT s.name, s.marks, d.dept_name
FROM Students s
INNER JOIN Departments d ON s.dept_id = d.dept_id;

-- Query 2: LEFT JOIN - Show all departments, even if no students
SELECT d.dept_name, s.name
FROM Departments d
LEFT JOIN Students s ON d.dept_id = s.dept_id;

-- Query 3: Subquery + JOIN - Students scoring above average in their department
SELECT s.name, s.marks, d.dept_name
FROM Students s
JOIN Departments d ON s.dept_id = d.dept_id
WHERE s.marks > (
    SELECT AVG(marks)
    FROM Students
    WHERE dept_id = s.dept_id
);

-- Query 4: Subquery with IN - Departments with students scoring 90+
SELECT dept_name
FROM Departments
WHERE dept_id IN (
    SELECT dept_id
    FROM Students
    WHERE marks >= 90
);

-- Query 5: Correlated Subquery + JOIN - Top scorer from each department
SELECT s.name, s.marks, d.dept_name
FROM Students s
JOIN Departments d ON s.dept_id = d.dept_id
WHERE s.marks = (
    SELECT MAX(marks)
    FROM Students
    WHERE dept_id = s.dept_id
);

-- Query 6: Aggregation with JOIN - Average marks per department
SELECT d.dept_name, AVG(s.marks) AS avg_marks
FROM Students s
JOIN Departments d ON s.dept_id = d.dept_id
GROUP BY d.dept_name;
