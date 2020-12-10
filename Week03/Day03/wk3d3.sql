
/*1. Are there any pay_details records lacking both a local_account_no and iban number?*/

SELECT 
  local_account_no, 
  iban
FROM pay_details
WHERE local_account_no IS NULL AND iban IS NULL;


/*2. Get a table of employees first_name, last_name and country, 
 * ordered alphabetically first by country and then by last_name (put any NULLs last).*/

SELECT
first_name,
last_name,
country
FROM employees
ORDER BY country,
	last_name ASC NULLS LAST;

/* 3.Find the details of the top ten highest paid employees in the corporation. */
SELECT
first_name,
last_name,
salary
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10;


/*4. Find the first_name, last_name and salary of the lowest paid employee in Hungary. */
SELECT
first_name,
last_name,
salary
FROM employees
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST
LIMIT 1;

/*5. Find all the details of any employees with a ‘yahoo’ email address? */
SELECT
*
FROM employees
WHERE email ILIKE '%yahoo%';


/*6. Provide a breakdown of the numbers of employees enrolled, not enrolled, 
 * and with unknown enrollment status in the corporation pension scheme. */

SELECT
COUNT(id),
pension_enrol
FROM employees
GROUP BY pension_enrol;


/*7. What is the maximum salary among those employees in the ‘Engineering’ department 
 * who work 1.0 full-time equivalent hours (fte_hours)?*/

SELECT
first_name,
last_name,
salary
FROM employees
WHERE department = 'Engineering' AND fte_hours = '1'
ORDER BY salary DESC
LIMIT 1;

/* 8. Get a table of country, number of employees in that country, and the average salary 
 * of employees in that country for any countries in which more than 30 employees are based. 
 * Order the table by average salary descending.*/

SELECT
count(id) as employee_number,
country,
ROUND(AVG(salary)) AS average_salary
FROM employees
GROUP BY country
HAVING COUNT(id) > 30
ORDER BY ROUND(AVG(salary)) DESC NULLS LAST

/* 9. Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary, 
 * and a new column effective_yearly_salary which should contain fte_hours multiplied by salary. */

SELECT
first_name,
last_name,
fte_hours,
salary,
(fte_hours * salary) AS effective_yearly_salary
FROM employees
ORDER BY (effective_yearly_salary) DESC NULLS LAST


/*10. Find the first name and last name of all employees who lack a local_tax_code. */
SELECT
e.first_name,
e.last_name,
p.local_tax_code
FROM employees AS e INNER JOIN pay_details as p
ON e.pay_detail_id = p.id
WHERE p.local_tax_code IS NULL


/*
11. The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, 
where charge_cost depends upon the team to which the employee belongs. 
Get a table showing expected_profit for each employee.
*/

SELECT
e.first_name,
e.last_name,
ROUND((48 * 35 * (CAST(t.charge_cost AS INT)) - e.salary * e.fte_hours)) AS expected_profit
FROM employees AS e INNER JOIN teams as t
ON e.team_id = t.id
ORDER BY expected_profit DESC NULLS LAST


/* 12. [Bit Tougher] Return a table of those employee first_names shared by more than one employee, 
 * together with a count of the number of times each first_name occurs. 
 * Omit employees without a stored first_name from the table. Order the table descending by count, 
 * and then alphabetically by first_name.*/

SELECT
first_name,
COUNT(first_name)
FROM employees
WHERE first_name IS NOT NULL
GROUP BY first_name
HAVING COUNT(first_name) > 1
ORDER BY COUNT(first_name) DESC, first_name



/* EXTENSION QUESTIONS ---------------------------------------------------------   *
 * 
 * /


/* E.1 [Tough] Get a list of the id, first_name, last_name, salary and fte_hours 
 * of employees in the largest department. Add two extra columns showing the ratio of each employee’s 
 * salary to that department’s average salary, and each employee’s fte_hours to that department’s average fte_hours.*/
/* I DON'T GET THE RIGHT ANSWER THE CROSS JOIN RETURNS A VERY STRANGE RESULT*/

WITH largest_dept (no_of_employees, dep_average_salary, dep_average_fte) AS (
SELECT
department,
count(id),
AVG(salary) ,
AVG(fte_hours) 
FROM employees
GROUP BY department
ORDER BY count(id) DESC
)
 SELECT 
 id,
 first_name,
 last_name,
 salary,
 fte_hours,
 (salary/d.dep_average_salary) AS salary_ratio,
 (fte_hours/d.dep_average_fte) AS fte_ratio
 FROM largest_dept AS d CROSS JOIN employees AS e
 WHERE department = 'Legal';
 
/*E.2 Have a look again at your table for MVP question 6. 
 * It will likely contain a blank cell for the row relating to employees with ‘unknown’ pension enrollment status. 
 * This is ambiguous: it would be better if this cell contained ‘unknown’ or something similar. 
 * Can you find a way to do this, perhaps using a combination of COALESCE() and CAST(), or a CASE statement?*/

/*SADLY I COULDN'T GET THIS TO WORK, IT SEEMS TO WANT A BOOLEAN, HOWEVER I HAVE A VARCHAR */

SELECT
COUNT(id),
pension_enrol,
CASE
	WHEN (CAST(pension_enrol AS VARCHAR) IS NULL THEN 'not found'
	ELSE pension_enrol
END
FROM employees
GROUP BY pension_enrol;


/* E.3 Find the first name, last name, email address and start date of all the employees 
 * who are members of the ‘Equality and Diversity’ committee. 
 * Order the member employees by their length of service in the company, longest first.*/










