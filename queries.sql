-- Create Database
CREATE DATABASE IF NOT EXISTS it_ticket_db;
USE it_ticket_db;

-- Create Departments Table
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

-- Create Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(200) NOT NULL,
    role VARCHAR(20) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Create Tickets Table
CREATE TABLE tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(50) NOT NULL,
    priority VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'Open',
    raised_by INT NOT NULL,
    assigned_to INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (raised_by) REFERENCES users(user_id),
    FOREIGN KEY (assigned_to) REFERENCES users(user_id)
);

-- Insert Department Data
INSERT INTO departments (dept_name) VALUES
('Network Team'),
('Hardware Support'),
('Software Support');

-- Insert User Data
INSERT INTO users (full_name, email, role, dept_id) VALUES
('Riya Sharma','riya@company.com','Employee',3),
('Arjun Mehta','arjun@company.com','Agent',2),
('Priya Nair','priya@company.com','Agent',3);

-- Insert Ticket Data
INSERT INTO tickets (title, category, priority, status, raised_by, assigned_to) VALUES
('Laptop not turning on','Hardware','High','Open',1,2),
('Cannot access SharePoint','Access','Critical','In Progress',1,3),
('Slow internet issue','Network','Medium','Open',1,2);

-- Retrieve All Tickets
SELECT * FROM tickets;

-- Aggregation Query
SELECT status, COUNT(*) AS total_tickets
FROM tickets
GROUP BY status;

-- Join Query
SELECT
    t.ticket_id,
    t.title,
    u.full_name AS raised_by_name
FROM tickets t
JOIN users u
ON t.raised_by = u.user_id;

-- Subquery Example
SELECT title, priority
FROM tickets
WHERE assigned_to IN (
    SELECT user_id
    FROM users
    WHERE role = 'Agent'
);
