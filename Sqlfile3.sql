-- Step 1: Create the database (safe mode)
CREATE DATABASE IF NOT EXISTS bank_db;

-- Step 2: Use the database
USE bank_db;

-- Step 3: Drop table if it already exists (so you can rerun this script)
DROP TABLE IF EXISTS accounts;

-- Step 4: Create the accounts table
CREATE TABLE accounts (
    account_no INT PRIMARY KEY,
    name VARCHAR(50),
    balance DECIMAL(10,2)
);

-- Step 5: Insert sample data
INSERT INTO accounts (account_no, name, balance) VALUES
(101, 'Alice', 1000.00),
(102, 'Bob', 500.00);

-- Step 6: View the data
SELECT * FROM accounts;
-- Start transaction
-- Start transaction
START TRANSACTION;

-- Deduct 300 from Bob’s account
UPDATE accounts
SET balance = balance - 300
WHERE account_no = 102;

-- Suppose an error occurs here (e.g., wrong account number)
UPDATE accounts
SET balance = balance + 300
WHERE account_no = 999;   -- invalid account, fails

-- Roll back all changes (undo transaction)
ROLLBACK;
