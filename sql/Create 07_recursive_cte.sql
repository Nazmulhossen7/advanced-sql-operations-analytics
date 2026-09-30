CREATE TABLE IF NOT EXISTS operations_team (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT
);
INSERT IGNORE INTO operations_team VALUES
(1, 'Operations Director', NULL),
(2, 'Team Manager A', 1),
(3, 'Team Manager B', 1),
(4, 'Senior Analyst A', 2),
(5, 'Analyst A', 4),
(6, 'Analyst B', 4),
(7, 'Senior Analyst B', 3),
(8, 'Analyst C', 7);