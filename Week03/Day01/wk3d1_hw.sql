
/* 1. Find all the employees who work in the ‘Human Resources’ department. */

SELECT *
FROM employees
WHERE department = 'Human Resources';



/* Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department. */

SELECT first_name, last_name, country
FROM employees
WHERE department = 'Legal';

/* 3. Count the number of employees based in Portugal. */

SELECT
COUNT(*)
FROM employees
WHERE country = 'Portugal';

/* 4. Count the number of employees based in either Portugal or Spain. */
SELECT
COUNT(*)
FROM employees
WHERE country = 'Portugal' OR country = 'Spain';

/* 5. Count the number of pay_details records lacking a local_account_no. */
SELECT
COUNT(*) As local_account_no_missing
FROM pay_details
WHERE local_account_no IS NULL;


/* 6. Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).*/
SELECT first_name, last_name
FROM employees
ORDER BY last_name ASC NULLS LAST;


/*7. How many employees have a first_name beginning with ‘F’*/
SELECT 
COUNT(*) AS number_of_employees
FROM employees
WHERE first_name LIKE 'F%';


/*8. Count the number of pension enrolled employees not based in either France or Germany.*/

SELECT 
COUNT(*) AS pension_enrolled
FROM employees
WHERE country NOT IN ('France','Germany') AND pension_enrol = 'TRUE';


/* 9. Obtain a count by department of the employees who started work with the corporation in 2003. */


SELECT 
COUNT (*) AS employment_commenced_2003
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31';


/* 10. Obtain a table showing department, fte_hours and the number of employees in each department who work each fte_hours pattern. 
 * Order the table alphabetically by department, and then in ascending order of fte_hours. */


SELECT department, fte_hours, COUNT (id) AS employee_count
FROM employees
GROUP BY department, fte_hours
ORDER BY department, fte_hours


/* 11. Obtain a table showing any departments in which there are two or more employees lacking a stored first name. 
 Order the table in descending order of the number of employees lacking a first name, and then in alphabetical order by department. */

 

SELECT department, COUNT (id) AS employee_count
FROM employees
WHERE first_name is NULL
GROUP BY department, first_name
HAVING COUNT (id) >= 2
ORDER BY employee_count DESC, department


/* 12. [Tough!] Find the proportion of employees in each department who are grade 1.*/



/* Employees from all departments*/
SELECT department, COUNT (id) AS employee_count_all
FROM employees
GROUP BY department


/* Employees from all departments where grade = 1 */
SELECT department, COUNT (id) AS employee_count_grade1
FROM employees
WHERE grade = 1
GROUP BY department



SELECT employee_count_grade1/employee_count_all
FROM (
		SELECT department, COUNT(id)
		FROM (
			SELECT department, COUNT (id) AS employee_count_all
			FROM employees
			GROUP BY department
		)AS employee_count_grade1
		WHERE grade = 1
		GROUP BY department
) AS ratio
GROUP BY department