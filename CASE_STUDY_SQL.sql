-- Create the database
CREATE DATABASE IF NOT EXISTS employee_management_system;
USE employee_management_system;

-- Create the employees table
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    job_title VARCHAR(255),
    department VARCHAR(255),
    salary DECIMAL(10, 2),
    manager_id INT,
    join_date DATE
);

-- Insert sample data
INSERT INTO employees VALUES
    (1, 'John Doe', 'Manager', 'HR', 70000.00, NULL, '2021-01-15'),
    (2, 'Jane Smith', 'Developer', 'IT', 60000.00, 1, '2022-03-20'),
    (3, 'Bob Johnson', 'Analyst', 'Finance', 55000.00, 1, '2022-05-10'),
    (4, 'Alice Williams', 'Designer', 'Marketing', 58000.00, 2, '2020-12-01'),
    (5, 'Charlie Brown', 'Intern', 'IT', 30000.00, 2, '2023-02-18');
-- 1. Retrieve all employees' names and their respective job titles.
SELECT employee_name, job_title
FROM employees;
-- 2. Find the total number of employees in the system.
SELECT COUNT(*) AS total_employees
FROM employees;
-- 3. List employees with a salary above $60,000 and in the "IT" department.
SELECT employee_name, salary
FROM employees
WHERE salary > 60000 AND department = 'IT';
-- 4. Calculate the average salary of all employees.
SELECT AVG(salary) AS average_salary
FROM employees;
-- 5. Display the unique department names in the organization.
SELECT DISTINCT department
FROM employees;
-- 6. Find the highest salary in the company.
SELECT MAX(salary) AS highest_salary
FROM employees;
-- 7. Retrieve the details of employees who joined after '2022-01-01'.
SELECT *
FROM employees
WHERE join_date > '2022-01-01';
-- 8. List employees sorted by their job titles in ascending order.
SELECT *
FROM employees
ORDER BY job_title ASC;
-- 9. Calculate the total salary expenditure for the company.
SELECT SUM(salary) AS total_salary_expenditure
FROM employees;
-- 10. Display the names of employees along with their managers.
SELECT e.employee_name, m.employee_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;
-- 11. Find the employees who do not have a manager assigned.
SELECT *
FROM employees
WHERE manager_id IS NULL;
-- 12. Retrieve the employees who are managers.
SELECT *
FROM employees
WHERE employee_id IN (SELECT DISTINCT manager_id FROM employees);
-- 13. List the employees who have a salary within the range of $40,000 to $50,000.
SELECT *
FROM employees
WHERE salary BETWEEN 40000 AND 50000;
-- 14. Count the number of employees in each department.
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;
-- 15. Display the employees with the second-highest salary.
SELECT *
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees WHERE salary < (SELECT MAX(salary) FROM employees));
-- 16. Find the employees whose names start with 'A'.
SELECT *
FROM employees
WHERE employee_name LIKE 'A%';
-- 17. Retrieve the top 5 highest-paid employees.
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 5;
-- 18. Calculate the average salary for each department.
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;
-- 19. Display employees hired in the last quarter.
SELECT *
FROM employees
WHERE join_date >= DATE_ADD(NOW(), INTERVAL -3 MONTH);
-- 20. Find employees with duplicate names.
SELECT employee_name, COUNT(*) AS name_count
FROM employees
GROUP BY employee_name
HAVING COUNT(*) > 1;
-- 21. Retrieve the employees with the lowest salary in each department.
SELECT *
FROM employees
WHERE (department, salary) IN (SELECT department, MIN(salary) FROM employees GROUP BY department);
-- 22. List employees with salaries above the average salary.
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
-- 23. Calculate the total salary for each job title.
SELECT job_title, SUM(salary) AS total_salary
FROM employees
GROUP BY job_title;
-- 24. Display the employees and their total sales if applicable. (Assuming there's a 'sales' table)
SELECT e.employee_name, COALESCE(SUM(s.sales_amount), 0) AS total_sales
FROM employees e
LEFT JOIN sales s ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.employee_name;
-- 25. Find the employees with the highest salary in each department.
SELECT *
FROM employees
WHERE (department, salary) IN (SELECT department, MAX(salary) FROM employees GROUP BY department);
-- 26. Retrieve employees who have been employed for more than 5 years.
SELECT *
FROM employees
WHERE DATEDIFF(NOW(), join_date) > 1825; -- Assuming 365 days in a year
-- 27. List employees and their corresponding manager's details.
SELECT e.employee_name, e.job_title, m.employee_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;
-- 28. Find the employees who have not made any sales. (Assuming there's a 'sales' table)
SELECT e.*
FROM employees e
LEFT JOIN sales s ON e.employee_id = s.employee_id
WHERE s.sales_amount IS NULL;
-- 29. Calculate the average tenure (in years) of employees in the organization.
SELECT AVG(DATEDIFF(NOW(), join_date) / 365) AS average_tenure_years
FROM employees;
-- 30. Retrieve the employees who earn more than their managers.
SELECT e.*
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;
