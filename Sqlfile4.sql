-- Use an existing database
SHOW 
USE company;

-- 1. Create Department table
CREATE TABLE IF NOT EXISTS Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Create Employee table
CREATE TABLE IF NOT EXISTS Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 18),
    Salary DECIMAL(10,2) CHECK (Salary >= 0),
    DeptID INT,
    CONSTRAINT FK_Dept FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Insert valid rows into Department
INSERT INTO Department (DeptID, DeptName) VALUES (1, 'HR');
INSERT INTO Department (DeptID, DeptName) VALUES (2, 'Finance');

-- 4. Insert valid rows into Employee
INSERT INTO Employee (EmpID, EmpName, Age, Salary, DeptID)
VALUES (101, 'Alice', 25, 5000.00, 1);

INSERT INTO Employee (EmpID, EmpName, Age, Salary, DeptID)
VALUES (102, 'Bob', 30, 6000.00, 2);

-- 5. Attempt invalid inserts to test constraints

-- Duplicate primary key
INSERT INTO Employee (EmpID, EmpName, Age, Salary, DeptID) 
VALUES (101, 'Charlie', 28, 5500.00, 1);

-- Foreign key violation (DeptID does not exist)
INSERT INTO Employee (EmpID, EmpName, Age, Salary, DeptID) 
VALUES (103, 'David', 26, 4000.00, 5);

-- NOT NULL violation
INSERT INTO Employee (EmpID, EmpName, Age, Salary, DeptID) 
VALUES (104, NULL, 22, 3500.00, 1);

-- CHECK violation (Age < 18)
INSERT INTO Employee (EmpID, EmpName, Age, Salary, DeptID) 
VALUES (105, 'Eve', 16, 3000.00, 1);

-- UNIQUE violation (duplicate DeptName)
INSERT INTO Department (DeptID, DeptName) VALUES (3, 'HR');

-- 6. View tables
SELECT * FROM Department;
SELECT * FROM Employee;
