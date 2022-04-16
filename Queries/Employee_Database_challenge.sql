--Retrieve the columns from the Employees table.
--SELECT emp_no, first_name, last_name FROM employees limit 10;
--Retrieve the columns from the Titles table
--SELECT title, from_date, to_date FROM titles limit 10;

-- Deliverable 1-1: The Number of Retiring Employees by Title
SELECT DISTINCT ON (e.emp_no, tt.title) e.emp_no,
	e.first_name,
	e.last_name ,
	tt.title,
    tt.from_date,
    tt.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, tt.title DESC;
--SELECT 133774

--Deliverable 1-2
-- Exclude those employees that have already left the company from 1-1
SELECT DISTINCT ON (e.emp_no, tt.title) e.emp_no,
	e.first_name,
	e.last_name ,
	tt.title
INTO unique_titles
FROM employees as e
INNER JOIN titles as tt
ON (e.emp_no = tt.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND to_date = '9999-01-01'
ORDER BY e.emp_no, tt.title DESC;
--SELECT 72458

-- Deliverable 1-3
-- Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT(*) AS number_of_titles, title 
INTO retiring_titles
FROM unique_titles 
GROUP BY title
ORDER BY number_of_titles DESC;
--SELECT 7

-- Deliverable 2-1
SELECT DISTINCT ON (emp.emp_no) emp.emp_no, emp.first_name, emp.last_name, emp.birth_date, 
	   dep.from_date, dep.to_date, ttl.title
INTO mentorship_eligibilty
FROM employees emp, dept_emp dep, titles ttl 
WHERE emp.emp_no = dep.emp_no 
AND  emp.emp_no = ttl.emp_no 
AND dep.to_date = '9999-01-01'
AND (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp.emp_no;
--SELECT 1549


