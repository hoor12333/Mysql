CREATE DATABASE IF NOT EXISTS SchoolDB;

-- 2. Select the database
USE SchoolDB;


DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50),
Marks INT 
);


INSERT INTO Students(StudentID,StudentName,Marks)  VALUES 
(1,'Alice',85),
(2,'BOB',90),
(3,'Charlie',75),
(4,'David',80);

DROP PROCEDURE IF EXISTS CalculateAverageMarks;

DELIMITER $$
CREATE PROCEDURE CalculateAverageMarks()
BEGIN
  DECLARE avgMarks DECIMAL(5,2);
  SELECT AVG(Marks) INTO avgMarks FROM Students;
  
  SELECT CONCAT('Average marks of students:',avgMarks) AS Result;
  END $$
  
 DELIMITER ;
  
  CALL CalculateAverageMarks();