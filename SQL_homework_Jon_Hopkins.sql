CREATE TABLE Employees (
	emp_no INT PRIMARY KEY,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE
	);

CREATE TABLE Departments (
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
	);

CREATE TABLE Salaries (
	emp_no INT,
	salary INT,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
	);

CREATE TABLE Titles (
	emp_no INT,
	title VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
	);

CREATE TABLE Dept_Emp (
	emp_no INT,
	dept_no VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
	);

CREATE TABLE Dept_Manager (
	dept_no VARCHAR,
	emp_no INT,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)	
	);

-- 1. List the following details of each employee: 
-- employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM Employees as e
JOIN Salaries as s
	ON e.emp_no = s.emp_no;

-- 2. List employees who were hired in 1986.
SELECT * 
FROM Employees
WHERE hire_date  >= '1986-01-01'
	AND hire_date <= '1986-12-31'
ORDER BY hire_date;

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, 
-- last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.first_name, e.last_name, de.from_date, de.to_date
FROM Employees AS e
	JOIN Dept_Manager AS dm 
		ON dm.emp_no = e.emp_no
	JOIN Dept_Emp AS de 
		ON de.emp_no = e.emp_no
	JOIN Departments AS d 
		ON d.dept_no = de.dept_no
WHERE dm.to_date = '9999-01-01';
	
-- 4. List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees AS e
	JOIN Dept_Emp as de
		ON de.emp_no = e.emp_no
	JOIN Departments as d
		ON d.dept_no = de.dept_no
ORDER BY e.last_name, e.first_name;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * 
FROM Employees
WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%'
ORDER BY last_name;

-- 6. List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees AS e
	JOIN Dept_Emp AS de
		ON de.emp_no = e.emp_no
	JOIN Departments AS d
		ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Employees AS e
	JOIN Dept_Emp AS de
		ON de.emp_no = e.emp_no
	JOIN Departments AS d
		ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY d.dept_name, e.last_name, e.first_name;

-- 8. In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
SELECT last_name, count(last_name)
FROM Employees
GROUP BY last_name
ORDER BY count(last_name) DESC;