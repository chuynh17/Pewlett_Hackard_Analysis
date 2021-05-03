-- Creating tables for PH-EmployeesDB
create table Departments (
	DEPT_NO VARCHAR(4) NOT NULL,
	DEPT_NAME VARCHAR(40) NOT NULL,
FOREIGN KEY (DEPT_NO) REFERENCES Dept_Manager (DEPT_NO),
FOREIGN KEY (DEPT_NO) REFERENCES Dept_Employee (DEPT_NO),
	PRIMARY Key (DEPT_NO),
	UNIQUE (DEPT_NAME)
);

create table Employees (
	EMP_NO INT NOT NULL,
	BIRTH_DATE DATE NOT NULL,
	FIRST_NAME VARCHAR NOT NULL,
	LAST_NAME VARCHAR NOT NULL,
	GENDER VARCHAR NOT NULL,
	HIRE_DATE DATE NOT NULL,
FOREIGN KEY (EMP_NO) REFERENCES Dept_Manager (EMP_NO),
FOREIGN KEY (EMP_NO) REFERENCES Dept_Employee (EMP_NO),
FOREIGN KEY (EMP_NO) REFERENCES Titles (EMP_NO),
FOREIGN KEY (EMP_NO) REFERENCES Salaries (EMP_NO),
	PRIMARY Key (EMP_NO)
);

CREATE TABLE Managers (
	DEPT_NO VARCHAR(4) NOT NULL,
    EMP_NO INT NOT NULL,
    FROM_DATE DATE NOT NULL,
    TO_DATE DATE NOT NULL,
FOREIGN KEY (DEPT_NO) REFERENCES Departments (DEPT_NO),
FOREIGN KEY (EMP_NO) REFERENCES Employees (EMP_NO),
    PRIMARY KEY (DEPT_NO, EMP_NO)
);

CREATE TABLE Salaries (
	EMP_NO INT NOT NULL,
	SALARY INT NOT NULL,
	FROM_DATE DATE NOT NULL,
	TO_DATE DATE NOT NULL,
FOREIGN KEY (EMP_NO) REFERENCES Employees (EMP_NO),
FOREIGN KEY (EMP_NO) REFERENCES Dept_Employee (EMP_NO),
FOREIGN KEY (EMP_NO) REFERENCES Titles (TITLE),
	PRIMARY KEY (EMP_NO)
);

CREATE TABLE Dept_Employees (
	EMP_NO INT NOT NULL,
	DEPT_NO VARCHAR(4) NOT NULL,
    FROM_DATE DATE NOT NULL,
    TO_DATE DATE NOT NULL,
FOREIGN KEY (EMP_NO) REFERENCES Employees (EMP_NO),
FOREIGN KEY (DEPT_NO) REFERENCES Departments (DEPT_NO),
FOREIGN KEY (EMP_NO) REFERENCES Salaries (EMP_NO),
    PRIMARY KEY (EMP_NO, DEPT_NO)
);

CREATE TABLE Titles (
	EMP_NO INT NOT NULL,
	TITLE VARCHAR(40) NOT NULL,
    FROM_DATE DATE NOT NULL,
    TO_DATE DATE NOT NULL,
FOREIGN KEY (EMP_NO) REFERENCES Salaries (EMP_NO),
FOREIGN KEY (EMP_NO) REFERENCES Employees (EMP_NO),
    PRIMARY KEY (EMP_NO, TITLE, FROM_DATE)
);

--RETIREMENT ELIGIBILTY
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE (BIRTH_DATE BETWEEN '1952-01-01' AND '1955-12-31')
AND (HIRE_DATE BETWEEN '1985-01-01' AND '1988-12-31');

SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE BIRTH_DATE BETWEEN '1953-01-01' AND '1955-12-31';

SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE BIRTH_DATE BETWEEN '1954-01-01' AND '1955-12-31';

SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE BIRTH_DATE BETWEEN '1955-01-01' AND '1955-12-31';

SELECT COUNT(FIRST_NAME)
FROM EMPLOYEES
WHERE (BIRTH_DATE BETWEEN '1952-01-01' AND '1955-12-31')
AND (HIRE_DATE BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     managers.emp_no,
     managers.from_date,
     managers.to_date
FROM departments
INNER JOIN managers
ON departments.dept_no = managers.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_employees.to_date
FROM retirement_info
LEFT JOIN dept_employees
ON retirement_info.emp_no = dept_employees.emp_no;

--Rewrite a join with aliases
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no;
 
 --rewrite a join with aliases part two
SELECT D.DEPT_NAME,
	DM.EMP_NO,
	DM.FROM_DATE,
	DM.TO_DATE
FROM DEPARTMENTS AS D
INNER JOIN MANAGERS AS DM
ON D.DEPT_NO = DM.DEPT_NO;

--------------------------------------
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO DE_EMP_RETIREMENT_COUNT
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;;

-----------------------------------------
SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
inner join Salaries as S
on (e.emp_no = s.emp_no)
inner join dept_employees as de
on (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

---------------------------------------
-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM managers AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
SELECT * from Manager_info

--------------------------------------
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

--------------------------------------
SELECT e.EMP_NO,
	e.FIRST_NAME,
	e.LAST_NAME,
	d.DEPT_NAME
FROM Employees as e
JOIN dept_employees on
e.emp_no = Dept_Employees.emp_no
INNER JOIN Departments as d on
Dept_employees.dept_no = d.dept_no
Where dept_name = 'Sales' or
		dept_name = 'Development';
