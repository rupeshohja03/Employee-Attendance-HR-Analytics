USE employee_hr_analytics;

SET SESSION cte_max_recursion_depth = 2000;

INSERT INTO employees
(employee_name, gender, age, city, state, department_id, job_role_id, joining_date, employment_status, salary)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 550
),
src AS (
    SELECT
        n,
        FLOOR(1 + RAND()*60) AS name_id,
        FLOOR(1 + RAND()*15) AS loc_id,
        FLOOR(1 + RAND()*13) AS dept_id,
        FLOOR(1 + RAND()*14) AS role_id,
        FLOOR(1 + RAND()*6)  AS gender_code,
        RAND() AS age_rand,
        RAND() AS salary_rand,
        RAND() AS date_rand,
        FLOOR(1 + RAND()*5)  AS status_code
    FROM seq
)
SELECT
    np.full_name,
    CASE gender_code
        WHEN 1 THEN 'Male' WHEN 2 THEN 'Female' WHEN 3 THEN 'M'
        WHEN 4 THEN 'F' WHEN 5 THEN 'male' ELSE 'FEMALE'
    END,
    CASE
        WHEN age_rand < 0.03 THEN NULL
        WHEN age_rand < 0.05 THEN 17
        WHEN age_rand < 0.06 THEN 95
        ELSE FLOOR(21 + age_rand*40)
    END,
    cp.city,
    cp.state,
    dept_id,
    role_id,
    CASE
        WHEN date_rand < 0.02 THEN DATE_ADD('2026-09-22', INTERVAL FLOOR(date_rand*300) DAY)
        ELSE DATE_ADD('2015-01-01', INTERVAL FLOOR(date_rand*4200) DAY)
    END,
    CASE status_code
        WHEN 1 THEN 'Active' WHEN 2 THEN 'Inactive' WHEN 3 THEN 'active'
        WHEN 4 THEN 'On Leave' ELSE 'ACTIVE'
    END,
    CASE
        WHEN salary_rand < 0.02 THEN NULL
        WHEN salary_rand < 0.04 THEN 0
        ELSE ROUND(25000 + salary_rand*225000, -2)
    END
FROM src
JOIN name_pool np ON np.pool_id = src.name_id
JOIN city_pool cp ON cp.pool_id = src.loc_id;

-- Intentional duplicate rows
INSERT INTO employees
(employee_name, gender, age, city, state, department_id, job_role_id, joining_date, employment_status, salary)
SELECT employee_name, gender, age, city, state, department_id, job_role_id, joining_date, employment_status, salary
FROM employees
ORDER BY RAND()
LIMIT 15;

-- VERIFY PART B
SELECT COUNT(*) AS employees_count FROM employees;

USE employee_hr_analytics;

SET SESSION cte_max_recursion_depth = 2000;

INSERT INTO attendance (employee_id, attendance_date, attendance_status, check_in_time, check_out_time, working_hours)
WITH RECURSIVE days AS (
    SELECT 1 AS d
    UNION ALL
    SELECT d + 1 FROM days WHERE d < 20
),
base AS (
    SELECT
        e.employee_id,
        DATE_SUB('2026-09-22', INTERVAL d.d DAY) AS att_date,
        RAND() AS status_rand,
        FLOOR(8 + RAND()*3) AS in_hour,
        FLOOR(RAND()*60) AS in_min,
        FLOOR(16 + RAND()*4) AS out_hour,
        FLOOR(RAND()*60) AS out_min,
        RAND() AS anomaly_rand
    FROM employees e
    CROSS JOIN days d
)
SELECT
    employee_id,
    att_date,
    CASE
        WHEN status_rand < 0.75 THEN
            CASE FLOOR(1+RAND()*4) WHEN 1 THEN 'Present' WHEN 2 THEN 'present' WHEN 3 THEN 'P' ELSE 'PRESENT' END
        WHEN status_rand < 0.85 THEN
            CASE FLOOR(1+RAND()*3) WHEN 1 THEN 'Absent' WHEN 2 THEN 'absent' ELSE 'A' END
        WHEN status_rand < 0.95 THEN
            CASE FLOOR(1+RAND()*2) WHEN 1 THEN 'Work From Home' ELSE 'WFH' END
        ELSE 'On Leave'
    END,
    CASE
        WHEN status_rand >= 0.75 AND status_rand < 0.85 THEN NULL
        WHEN anomaly_rand < 0.03 THEN NULL
        ELSE MAKETIME(in_hour, in_min, 0)
    END,
    CASE
        WHEN status_rand >= 0.75 AND status_rand < 0.85 THEN NULL
        WHEN anomaly_rand < 0.03 THEN NULL
        ELSE MAKETIME(out_hour, out_min, 0)
    END,
    CASE
        WHEN status_rand >= 0.75 AND status_rand < 0.85 THEN NULL
        WHEN anomaly_rand < 0.02 THEN -2.5
        WHEN anomaly_rand < 0.04 THEN 26
        ELSE ROUND((out_hour + out_min/60.0) - (in_hour + in_min/60.0), 2)
    END
FROM base;

-- VERIFY PART C
SELECT COUNT(*) AS attendance_count FROM attendance;

USE employee_hr_analytics;

INSERT INTO leaves (employee_id, leave_type, start_date, end_date, leave_days, leave_status)
WITH RECURSIVE lseq AS (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3
)
SELECT
    e.employee_id,
    CASE FLOOR(1+RAND()*5)
        WHEN 1 THEN 'Sick Leave' WHEN 2 THEN 'Casual Leave' WHEN 3 THEN 'Earned Leave'
        WHEN 4 THEN 'sick leave' ELSE 'Casual leave'
    END,
    DATE_ADD('2025-01-01', INTERVAL FLOOR(RAND()*600) DAY) AS sd,
    DATE_ADD('2025-01-01', INTERVAL (FLOOR(RAND()*600) + FLOOR(RAND()*5)) DAY),
    CASE WHEN RAND() < 0.03 THEN -1 ELSE FLOOR(1+RAND()*5) END,
    CASE FLOOR(1+RAND()*4)
        WHEN 1 THEN 'Approved' WHEN 2 THEN 'approved' WHEN 3 THEN 'Pending' ELSE 'Rejected'
    END
FROM employees e
CROSS JOIN lseq l
WHERE RAND() < 0.5;

-- VERIFY PART D
SELECT COUNT(*) AS leaves_count FROM leaves;

USE employee_hr_analytics;

INSERT INTO performance (employee_id, review_date, performance_rating, productivity_score, quality_score, manager_rating, performance_status)
WITH RECURSIVE pseq AS (
    SELECT 1 AS n UNION ALL SELECT 2
)
SELECT
    e.employee_id,
    DATE_ADD('2025-01-01', INTERVAL FLOOR(RAND()*600) DAY),
    CASE WHEN RAND() < 0.02 THEN 7.5 ELSE ROUND(1 + RAND()*4, 1) END,
    CASE WHEN RAND() < 0.03 THEN NULL ELSE ROUND(40 + RAND()*60, 2) END,
    CASE WHEN RAND() < 0.03 THEN NULL ELSE ROUND(40 + RAND()*60, 2) END,
    ROUND(1 + RAND()*4, 1),
    CASE FLOOR(1+RAND()*4)
        WHEN 1 THEN 'Excellent' WHEN 2 THEN 'Good' WHEN 3 THEN 'Average' ELSE 'Needs Improvement'
    END
FROM employees e
CROSS JOIN pseq p
WHERE RAND() < 0.7;

-- VERIFY PART E
SELECT COUNT(*) AS performance_count FROM performance;

USE employee_hr_analytics;

INSERT INTO salary_history (employee_id, salary, effective_date, salary_increment_percent)
WITH RECURSIVE sseq AS (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3
)
SELECT
    e.employee_id,
    ROUND(25000 + RAND()*225000, -2),
    DATE_ADD('2015-01-01', INTERVAL FLOOR(RAND()*4200) DAY),
    CASE WHEN RAND() < 0.02 THEN -15.0 ELSE ROUND(RAND()*25, 1) END
FROM employees e
CROSS JOIN sseq s
WHERE RAND() < 0.55;

-- VERIFY PART F
SELECT COUNT(*) AS salary_history_count FROM salary_history;

USE employee_hr_analytics;

DROP TABLE IF EXISTS name_pool;
DROP TABLE IF EXISTS city_pool;

-- Final confirmation of all 7 raw tables together
SELECT
    (SELECT COUNT(*) FROM departments) AS departments,
    (SELECT COUNT(*) FROM job_roles) AS job_roles,
    (SELECT COUNT(*) FROM employees) AS employees,
    (SELECT COUNT(*) FROM attendance) AS attendance,
    (SELECT COUNT(*) FROM leaves) AS leaves,
    (SELECT COUNT(*) FROM performance) AS performance,
    (SELECT COUNT(*) FROM salary_history) AS salary_history;