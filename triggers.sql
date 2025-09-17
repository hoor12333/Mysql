-- Step 1: Create a new database
CREATE DATABASE IF NOT EXISTS StudentDB;

-- Step 2: Switch to the database
USE StudentDB;

-- Step 3: Create Student table
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50),
    Marks INT
);

-- Step 4: Create Trigger
DELIMITER $$

CREATE TRIGGER check_marks_before_insert
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN
    IF NEW.Marks < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '❌ Error: Marks cannot be negative';
    END IF;
END$$

DELIMITER ;

-- Step 5: Test the trigger

-- ✅ Valid insert (this will succeed)
INSERT INTO Student VALUES (101, 'Alice', 85);

-- ❌ Invalid insert (this will fail with error)

INSERT INTO Student VALUES (103, 'Charlie', 78);
INSERT INTO Student VALUES (104, 'David', 92);

SELECT * FROM Student;

-- Step 6: View current data in Student table
SELECT * FROM Student;
