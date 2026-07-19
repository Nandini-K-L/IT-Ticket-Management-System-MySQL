DROP DATABASE IF EXISTS it_ticket_db;
CREATE DATABASE it_ticket_db;
USE it_ticket_db;

CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE users (
    user_id     INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(150) NOT NULL,
    email       VARCHAR(200) NOT NULL UNIQUE,
    role        VARCHAR(20)  NOT NULL DEFAULT 'Employee',   -- 'Employee' or 'Agent'
    dept_id     INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE tickets (
    ticket_id     INT AUTO_INCREMENT PRIMARY KEY,
    title         VARCHAR(255) NOT NULL,
    category      VARCHAR(50)  NOT NULL,                    -- Hardware, Software, Network, Access, Email
    priority      VARCHAR(20)  NOT NULL DEFAULT 'Medium',    -- Low, Medium, High, Critical
    status        VARCHAR(20)  NOT NULL DEFAULT 'Open',      -- Open, In Progress, Resolved, Closed
    raised_by     INT NOT NULL,
    assigned_to   INT,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (raised_by) REFERENCES users(user_id),
    FOREIGN KEY (assigned_to) REFERENCES users(user_id)
);

INSERT INTO departments (dept_name) VALUES
('Network Team'),
('Hardware Support'),
('Software Support'),
('Human Resources'),
('Finance');

INSERT INTO users (full_name, email, role, dept_id) VALUES
('Riya Sharma',    'riya.sharma@company.com',    'Employee', 4),
('Arjun Mehta',    'arjun.mehta@company.com',    'Agent',    2),
('Priya Nair',     'priya.nair@company.com',     'Agent',    3),
('Karthik Iyer',   'karthik.iyer@company.com',   'Employee', 5),
('Sneha Reddy',    'sneha.reddy@company.com',    'Employee', 4),
('Rahul Verma',    'rahul.verma@company.com',    'Agent',    1),
('Ananya Das',     'ananya.das@company.com',     'Employee', 5),
('Vikram Singh',   'vikram.singh@company.com',   'Employee', 3),
('Meera Joshi',    'meera.joshi@company.com',    'Agent',    3),
('Suresh Kumar',   'suresh.kumar@company.com',   'Employee', 1),
('Deepa Nambiar',  'deepa.nambiar@company.com',  'Employee', 2),
('Rohan Kapoor',   'rohan.kapoor@company.com',   'Employee', 4);


INSERT INTO tickets (title, category, priority, status, raised_by, assigned_to, created_at) VALUES
('Laptop not turning on',               'Hardware', 'High',     'Resolved',    1, 2,    '2026-01-05 09:15:00'),
('Cannot access SharePoint',            'Access',   'Critical', 'Closed',      1, 3,    '2026-01-06 10:30:00'),
('Slow internet issue',                 'Network',  'Medium',   'Open',        1, 6,    '2026-01-10 11:00:00'),
('Excel crashing frequently',           'Software', 'Medium',   'In Progress', 4, 9,    '2026-01-12 14:20:00'),
('Unable to print documents',           'Hardware', 'Low',      'Resolved',    5, 2,    '2026-01-15 09:45:00'),
('VPN not connecting',                  'Network',  'High',     'Open',        7, 6,    '2026-01-18 16:10:00'),
('Outlook not syncing emails',          'Email',    'Medium',   'Closed',      8, 9,    '2026-01-20 08:50:00'),
('Wi-Fi keeps disconnecting',           'Network',  'Medium',   'Resolved',    10, 6,   '2026-02-01 10:05:00'),
('Monitor display flickering',          'Hardware', 'Low',      'Open',        11, 2,   '2026-02-03 13:40:00'),
('Password reset request',              'Access',   'Medium',   'Closed',      12, 3,   '2026-02-05 09:00:00'),
('New software installation request',   'Software', 'Low',      'Resolved',    1, 9,    '2026-02-10 15:30:00'),
('System running very slow',            'Hardware', 'High',     'In Progress', 4, 2,    '2026-02-14 11:20:00'),
('Email account locked',                'Email',    'Critical', 'Closed',      5, 9,    '2026-02-18 09:10:00'),
('Unable to access shared drive',       'Access',   'High',     'Open',        7, 3,    '2026-02-20 12:00:00'),
('Software license expired',            'Software', 'Medium',   'In Progress', 8, 9,    '2026-03-01 10:15:00'),
('Network printer not detected',        'Network',  'Low',      'Resolved',    10, 6,   '2026-03-05 14:00:00'),
('Laptop battery draining fast',        'Hardware', 'Medium',   'Open',        11, 2,   '2026-03-10 09:30:00'),
('Cannot connect to office VPN',        'Network',  'High',     'Closed',      12, 6,   '2026-03-15 16:45:00'),
('Request for additional software license', 'Software', 'Low', 'Open',        1, NULL, '2026-03-20 10:50:00'),
('Blue screen error on startup',        'Hardware', 'Critical', 'In Progress', 4, 2,    '2026-04-01 08:30:00'),
('Unable to reset password',            'Access',   'Medium',   'Resolved',    5, 3,    '2026-04-05 11:10:00'),
('Slow email loading',                  'Email',    'Low',      'Closed',      7, 9,    '2026-04-10 13:25:00'),
('Application crashing on launch',      'Software', 'High',     'Open',        8, NULL, '2026-04-15 09:40:00'),
('Internet connectivity issue',         'Network',  'Medium',   'In Progress', 10, 6,   '2026-05-01 10:00:00'),
('Hard disk making noise',              'Hardware', 'Critical', 'Open',        11, 2,   '2026-05-10 15:15:00'),
('Access denied to finance portal',     'Access',   'High',     'Resolved',    12, 3,   '2026-05-15 12:30:00');

UPDATE tickets
SET status = 'In Progress', assigned_to = 2
WHERE ticket_id = 19;

INSERT INTO tickets (title, category, priority, status, raised_by, assigned_to, created_at) VALUES
('Test ticket - to be removed', 'Software', 'Low', 'Open', 1, NULL, '2026-05-20 10:00:00');




SELECT *
FROM tickets
ORDER BY ticket_id;

SELECT DISTINCT category
FROM tickets;

SELECT status, COUNT(*) AS total_tickets
FROM tickets
GROUP BY status;

SELECT priority, COUNT(*) AS total_tickets
FROM tickets
GROUP BY priority;

SELECT category, COUNT(*) AS total_tickets
FROM tickets
GROUP BY category
ORDER BY total_tickets DESC;

SELECT u.full_name AS agent_name, COUNT(t.ticket_id) AS tickets_assigned
FROM tickets t
INNER JOIN users u ON t.assigned_to = u.user_id
GROUP BY u.full_name
ORDER BY tickets_assigned DESC;

SELECT ticket_id, title, priority, created_at
FROM tickets
WHERE status = 'Open'
ORDER BY created_at DESC;

SELECT ticket_id, title, priority, created_at
FROM tickets
WHERE status = 'Closed'
ORDER BY created_at DESC;

SELECT ticket_id, title, status, created_at
FROM tickets
WHERE priority = 'Critical'
ORDER BY created_at DESC;

SELECT d.dept_name, COUNT(t.ticket_id) AS total_tickets
FROM tickets t
INNER JOIN users u ON t.raised_by = u.user_id
INNER JOIN departments d ON u.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY total_tickets DESC;

SELECT ticket_id, title, status, created_at
FROM tickets
ORDER BY created_at DESC
LIMIT 5;

SELECT t.ticket_id, t.title, t.status, t.created_at
FROM tickets t
INNER JOIN users u ON t.raised_by = u.user_id
WHERE u.full_name = 'Riya Sharma';

SELECT ticket_id, title, category, status
FROM tickets
WHERE title LIKE '%password%';

SELECT u.full_name AS agent_name, COUNT(t.ticket_id) AS total_assigned
FROM tickets t
INNER JOIN users u ON t.assigned_to = u.user_id
GROUP BY u.full_name
ORDER BY total_assigned DESC
LIMIT 3;

SELECT ticket_id, title, priority,
    CASE
        WHEN priority = 'Critical' THEN 'Immediate Attention'
        WHEN priority = 'High' THEN 'Urgent'
        WHEN priority = 'Medium' THEN 'Normal'
        ELSE 'Low Priority'
    END AS priority_level
FROM tickets;

SELECT d.dept_name, COUNT(t.ticket_id) AS total_tickets
FROM tickets t
INNER JOIN users u ON t.raised_by = u.user_id
INNER JOIN departments d ON u.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING COUNT(t.ticket_id) > 5;

SELECT AVG(agent_ticket_counts.total_assigned) AS avg_tickets_per_agent
FROM (
    SELECT assigned_to, COUNT(*) AS total_assigned
    FROM tickets
    WHERE assigned_to IS NOT NULL
    GROUP BY assigned_to
) AS agent_ticket_counts;

SELECT ticket_id, title, status, priority
FROM tickets
WHERE status NOT IN ('Closed', 'Resolved');

SELECT ticket_id, title, status, priority
FROM tickets
WHERE status IN ('Closed', 'Resolved');

SELECT category, priority, COUNT(*) AS total_tickets
FROM tickets
GROUP BY category, priority
ORDER BY category, priority;

SELECT ticket_id, title, created_at
FROM tickets
WHERE created_at BETWEEN '2026-02-01 00:00:00' AND '2026-03-31 23:59:59'
ORDER BY created_at;

SELECT ticket_id, title, priority, status
FROM tickets
WHERE priority IN ('High', 'Critical');

SELECT ticket_id, title, priority, status
FROM tickets
WHERE priority NOT IN ('Low');

SELECT MIN(created_at) AS earliest_ticket,
       MAX(created_at) AS latest_ticket
FROM tickets;

SELECT u.full_name AS employee_name,
       COUNT(t.ticket_id) AS tickets_raised
FROM users u
LEFT JOIN tickets t
ON u.user_id = t.raised_by
WHERE u.role = 'Employee'
GROUP BY u.full_name
ORDER BY tickets_raised DESC;

SELECT t.ticket_id,
       t.title,
       u.full_name AS raised_by_name
FROM tickets t
JOIN users u
ON t.raised_by = u.user_id;

SELECT title, priority
FROM tickets
WHERE assigned_to IN (
    SELECT user_id
    FROM users
    WHERE role = 'Agent'
);

SELECT ticket_id, title, priority, status, created_at
FROM tickets
WHERE priority IN ('High', 'Critical')
ORDER BY created_at DESC
LIMIT 5;

