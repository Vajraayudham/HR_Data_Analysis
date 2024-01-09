# HR Data Analysis 
select * from hr;

-- To understand the most paid career?
select
	Department,
    max(Salary)
from hr
group by Position
order by sum(Salary) desc;
-- What is the average salary of each category?
select 
	Department ,
	avg(Salary) as Avgsalary 
from 
	hr 
group by Department 
order by Avgsalary desc;
-- How does gender affect the salary of an employee
SELECT 
	Department,
    Sex,
    AVG(Salary) AS avg_salary
FROM hr
GROUP BY Department, Sex
ORDER BY Department, RaceDesc;

-- How does race(white/black/Asian...) affect the salary of an employee
WITH CTE_tbl1 AS (SELECT 
	Department,
    RaceDesc,
    AVG(Salary) AS avg_salary
FROM hr
GROUP BY Department, RaceDesc)
SELECT
	*,
    ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Department, avg_salary DESC) AS position
FROM CTE_tbl1;

-- How does race(white/black/Asian...) affect employee position?
WITH cte_tbl AS (SELECT 
	Position,
    RaceDesc,
    COUNT(Position) AS cnt_pos
FROM hr
GROUP BY Position, RaceDesc)
SELECT 
	*,
    ROW_NUMBER() OVER(PARTITION BY Position ORDER BY cnt_pos DESC) AS rank_position
FROM cte_tbl;


-- What is the most common recruitement source and how does 
-- recruitement source affect salary and EmpSatisfaction?
SELECT
	RecruitmentSource,
    AVG(Salary) as avg_salary,
	COUNT(RecruitmentSource) AS count
FROM hr
GROUP BY RecruitmentSource
ORDER BY avg_salary DESC;


-- What is the categorization count for EmploymentStatus?
SELECT 
	*,
    ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Department DESC) AS status_rank
FROM(SELECT
	Department,
    EmploymentStatus,
    COUNT(EmploymentStatus) AS status
FROM hr
GROUP BY Department, EmploymentStatus
ORDER BY Department, status DESC) AS subquery;

-- What is the average salary based on department?
SELECT
	Department,
    AVG(Salary) AS avg_salary
FROM hr
GROUP BY Department
ORDER BY avg_salary DESC;

-- Which state has the most paid salary?
SELECT
	State,
    AVG(Salary) AS avg_salary
FROM hr
GROUP BY State
ORDER BY avg_salary DESC;


-- What is the most common reason for termination?
SELECT 
	TermReason,
    COUNT(TermReason) AS count
FROM hr
GROUP BY TermReason
ORDER BY count DESC;

-- What is the most common reason for termination by race?
SELECT
	RaceDesc,
	TermReason,
    COUNT(TermReason) AS count
FROM hr
GROUP BY TermReason, RaceDesc
ORDER BY RaceDesc, count DESC;

-- What is the most common EmploymentStatus?
SELECT
	EmploymentStatus,
    COUNT(EmploymentStatus) AS count
FROM hr
GROUP BY EmploymentStatus
ORDER BY count DESC;

-- Which recruitment source give employees with best performance score?
SELECT
	RecruitmentSource,
    PerformanceScore,
    COUNT(PerformanceScore) AS perf_cnt
FROM hr
GROUP BY RecruitmentSource, PerformanceScore
ORDER BY RecruitmentSource, PerformanceScore;


-- Which department has the most absenties?
SELECT
	Department,
    SUM(Absences) AS absence_cnt
FROM hr
GROUP BY Department
ORDER BY absence_cnt DESC;

-- Which race has the most absenties?
SELECT
	RaceDesc,
    SUM(Absences) AS absence_cnt,
    COUNT(RaceDesc) as race_cnt
FROM hr
GROUP BY RaceDesc
ORDER BY absence_cnt DESC;


-- Which department has the best employee satisfactions?
SELECT
	Department,
    ROUND(AVG(EmpSatisfaction), 2) AS avg_empl_satisfaction,
    AVG(Salary) AS avg_salary
FROM hr
GROUP BY Department
ORDER BY avg_empl_satisfaction DESC;


-- Which race has the most satisfied employees?
SELECT
	RaceDesc,
    ROUND(AVG(EmpSatisfaction), 2) AS avg_empl_satisfaction,
    AVG(Salary) AS avg_salary
FROM hr
GROUP BY RaceDesc
ORDER BY avg_empl_satisfaction DESC;

-- What is the employee satisfaction levels for married/single people?
SELECT
	MaritalDesc,
    ROUND(AVG(EmpSatisfaction), 2) AS avg_empl_satisfaction,
    AVG(Salary) AS avg_salary
FROM hr
GROUP BY MaritalDesc
ORDER BY avg_empl_satisfaction DESC;

-- Which state has the most satisfied employees?
SELECT
	State,
    ROUND(AVG(EmpSatisfaction), 2) AS avg_empl_satisfaction,
    AVG(Salary) AS avg_salary,
    COUNT(State) AS state_cnt
FROM hr
GROUP BY State
ORDER BY avg_empl_satisfaction DESC;

-- What is the average age of employees in each department?
SELECT
	Department,
    AVG(ROUND(DATEDIFF(NOW(), DOB) / 365, 1)) AS avg_age
FROM hr
GROUP BY Department;

-- Average age by each race?
SELECT
	RaceDesc,
    AVG(ROUND(DATEDIFF(NOW(), DOB) / 365, 1)) AS avg_age
FROM hr
GROUP BY RaceDesc
ORDER BY avg_age DESC;


-- What is the average age of each position?
SELECT
	Position,
    AVG(ROUND(DATEDIFF(NOW(), DOB) / 365, 1)) AS avg_age
FROM hr
GROUP BY Position
ORDER BY avg_age DESC;