CREATE DATABASE IF NOT EXISTS college;
USE college;
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
StudentID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT ,
Grade VARCHAR (5)
);
INSERT INTO Student (StudentID , Name , Age , Grade) VALUES 
(1, 'Alice', 20, 'A'),
(2, 'Bob', 21, 'B'),
(3, 'Charlie', 22, 'A'),
(4, 'David', 20, 'C'),
(5, 'Eva', 21, 'B');

CREATE INDEX idx_name ON Student(Name);
SELECT * FROM Student WHERE Name = 'Alice';
EXPLAIN SELECT * FROM Student WHERE Name = 'Alice';
SHOW INDEXES FROM Student; 

