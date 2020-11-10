-- Schema Human Resources(HR)

--1.Where are our employees located across our company?
--Number of employees by Country
SELECT
    c.country_name AS Country,
    count(*) AS Employees
FROM hr.employees e
LEFT JOIN hr.departments d
    ON coalesce(e.department_id, 80) = d.department_id --coealesce function replaces null value with sales department id (80)
LEFT JOIN hr.locations l
    ON d.location_id = l.location_id
JOIN hr.countries c
    ON l.country_id = c.country_id
GROUP BY c.country_name
Order By Employees DESC --sort by number of employees in descending order
;

--2.Which area (city/department) are team members distributed?
--Number of employees by City and Department

SELECT
    l.city,
    l.country_id AS Country,
    d.department_name,
    count(distinct(employee_id)) AS Employees
FROM hr.employees e
LEFT JOIN hr.departments d
    ON coalesce(e.department_id, 80) = d.department_id --coealesce function replaces null value with sales department id (80)
LEFT JOIN hr.locations l
    ON d.location_id = l.location_id
JOIN hr.countries c
    ON l.country_id = c.country_id
GROUP BY l.city, l.country_id, d.department_name
Order By Employees DESC --sort by number of employees in descending order
;

--3.What is the average salary per role in the company?
--Average employee salary by job
SELECT
    j.job_title,
    e.job_id,
    ROUND(AVG(e.salary)) AS Average_Salary --round employee salary average to whole number
FROM hr.employees e
LEFT JOIN hr.departments d
    ON e.department_id = d.department_id
JOIN hr.jobs j
    ON e.job_id = j.job_id
GROUP BY j.job_title,e.job_id
ORDER BY Average_Salary DESC --sort by salaries in descending order
;

--4.What is the cost of salary expense per department?
-- Sum of Department Salaries highest - lowest
SELECT
    d.department_name,
    SUM(e.salary) AS SALARY_EXPENSE
FROM hr.employees e
INNER JOIN hr.departments d
    ON coalesce(e.department_id, 80) = d.department_id --coealesce function replaces null value with sales department id (80)
FULL OUTER JOIN hr.jobs j
    ON e.job_id = j.job_id
GROUP BY d.department_name
ORDER BY SUM(e.salary) DESC --sort by employee salaries in descending order
;

