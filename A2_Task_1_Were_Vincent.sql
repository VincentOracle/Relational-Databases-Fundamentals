-- TASK 1: Based on the following physical data model (ERD), and using MySQL Workbench, you are required to
-- code all the necessary DDL statements to implement this model.

-- Author: [Your Firstname Lastname]
-- File: A2_Task_1_Firstname_Lastname.sql
-- Description: SQL script to create AGENT, PURCHASE_ORDER, and CUSTOMER tables based on the ERD

-- Drop tables if they already exist to avoid duplication
USE ICT128RELATIONALDB;

DROP TABLE IF EXISTS PURCHASE_ORDER;
DROP TABLE IF EXISTS AGENT;
DROP TABLE IF EXISTS CUSTOMERS;

-- 1. Creating AGENT Table
CREATE TABLE AGENT (
    agent_id VARCHAR(6) PRIMARY KEY,                -- Primary Key for AGENT
    agent_first_name VARCHAR(45) NOT NULL,          -- Agent's first name, cannot be null
    agent_last_name VARCHAR(45) NOT NULL,           -- Agent's last name, cannot be null
    agent_area VARCHAR(45) NOT NULL,                -- Agent's area of operation, cannot be null
    agent_comm_rate DECIMAL(4,2) NOT NULL,          -- Commission rate, cannot be null
    agent_phone VARCHAR(15) NOT NULL,               -- Agent's phone number, cannot be null
    agent_country_code VARCHAR(2) NOT NULL          -- Country code, cannot be null
);

-- 2. Creating CUSTOMER Table
CREATE TABLE CUSTOMERS (
    cust_id VARCHAR(6) PRIMARY KEY,                 -- Primary Key for CUSTOMER
    cust_name VARCHAR(45) NOT NULL,                 -- Customer's name, cannot be null
    cust_city VARCHAR(45) NOT NULL,                 -- City, cannot be null
    cust_area VARCHAR(45) NOT NULL,                 -- Area, cannot be null
    cust_country VARCHAR(45) NOT NULL,              -- Country, cannot be null
    cust_phone VARCHAR(15) NOT NULL,                -- Phone number, cannot be null
    cust_opening_amt DECIMAL(12,2) NOT NULL         -- Opening account amount, cannot be null
);

-- 3. Creating PURCHASE_ORDER Table
CREATE TABLE PURCHASE_ORDER (
    po_id INT PRIMARY KEY,                          -- Primary Key for PURCHASE_ORDER
    po_order_date DATE,                             -- Date of the purchase order
    po_order_amount DECIMAL(12,2),                  -- Total amount for the order
    fk_agent_id VARCHAR(6),                         -- Foreign Key referencing AGENT
    fk_cust_id VARCHAR(6),                          -- Foreign Key referencing CUSTOMER
    FOREIGN KEY (fk_agent_id) REFERENCES AGENT(agent_id) ON DELETE SET NULL, -- Ensures referential integrity
    FOREIGN KEY (fk_cust_id) REFERENCES CUSTOMERS(cust_id) ON DELETE SET NULL -- Ensures referential integrity
);

-- Optional: To view the tables after creation, you may run this command to verify
SHOW TABLES;

-- End of script
-- THE END OF TASK 1

