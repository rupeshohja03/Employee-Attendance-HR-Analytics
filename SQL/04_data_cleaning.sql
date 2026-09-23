USE employee_hr_analytics;

DROP TABLE IF EXISTS clean_departments;
DROP TABLE IF EXISTS clean_job_roles;
DROP TABLE IF EXISTS clean_employees;
DROP TABLE IF EXISTS clean_attendance;
DROP TABLE IF EXISTS clean_leaves;
DROP TABLE IF EXISTS clean_performance;
DROP TABLE IF EXISTS clean_salary_history;

-- 1. CLEAN DEPARTMENTS
CREATE TABLE clean_departments AS
SELECT
    department_id,
    CASE
        WHEN TRIM(UPPER(department_name)) IN ('HR','HUMAN RESOURCES') THEN 'Human Resources'
        WHEN TRIM(UPPER(department_name)) IN ('IT','INFORMATION TECHNOLOGY') THEN 'Information Technology'
        WHEN TRIM(UPPER(department_name)) = 'SALES' THEN 'Sales'
        ELSE TRIM(department_name)
    END AS department_name_clean
FROM departments;

-- 2. CLEAN JOB ROLES
CREATE TABLE clean_job_roles AS
SELECT
    job_role_id,
    TRIM(
        CONCAT(UCASE(LEFT(job_role,1)), LCASE(SUBSTRING(job_role,2)))
    ) AS job_role_clean,
    COALESCE(job_level, 'Not Specified') AS job_level_clean
FROM job_roles;

-- 3. CLEAN EMPLOYEES
CREATE TABLE clean_employees AS
SELECT
    e.employee_id,
    e.employee_name,
    CASE
        WHEN UPPER(e.gender) IN ('MALE','M') THEN 'Male'
        WHEN UPPER(e.gender) IN ('FEMALE','F') THEN 'Female'
        ELSE 'Not Specified'
    END AS gender_clean,
    CASE
        WHEN e.age IS NULL OR e.age < 18 OR e.age > 65 THEN NULL
        ELSE e.age
    END AS age_clean,
    e.city,
    e.state,
    e.department_id,
    e.job_role_id,
    CASE
        WHEN e.joining_date > CURDATE() THEN NULL
        ELSE e.joining_date
    END AS joining_date_clean,
    CASE
        WHEN UPPER(TRIM(e.employment_status)) = 'ACTIVE' THEN 'Active'
        WHEN UPPER(TRIM(e.employment_status)) = 'INACTIVE' THEN 'Inactive'
        WHEN UPPER(TRIM(e.employment_status)) = 'ON LEAVE' THEN 'On Leave'
        ELSE 'Not Specified'
    END AS employment_status_clean,
    CASE
        WHEN e.salary IS NULL OR e.salary <= 0 THEN NULL
        ELSE e.salary
    END AS salary_clean,
    CASE
        WHEN e.joining_date IS NULL OR e.joining_date > CURDATE() THEN NULL
        ELSE ROUND(DATEDIFF(CURDATE(), e.joining_date) / 365.25, 1)
    END AS tenure_years
FROM (
    SELECT e1.*
    FROM employees e1
    INNER JOIN (
        SELECT MIN(employee_id) AS keep_id
        FROM employees
        GROUP BY employee_name, department_id, job_role_id, joining_date
    ) keep_rows ON e1.employee_id = keep_rows.keep_id
) e;

-- 4. CLEAN ATTENDANCE
CREATE TABLE clean_attendance AS
SELECT
    a.attendance_id,
    a.employee_id,
    a.attendance_date,
    CASE
        WHEN UPPER(TRIM(a.attendance_status)) IN ('PRESENT','P') THEN 'Present'
        WHEN UPPER(TRIM(a.attendance_status)) IN ('ABSENT','A') THEN 'Absent'
        WHEN UPPER(TRIM(a.attendance_status)) IN ('WORK FROM HOME','WFH') THEN 'Work From Home'
        WHEN UPPER(TRIM(a.attendance_status)) = 'ON LEAVE' THEN 'On Leave'
        ELSE 'Not Specified'
    END AS attendance_status_clean,
    a.check_in_time,
    a.check_out_time,
    CASE
        WHEN a.check_in_time IS NOT NULL AND a.check_out_time IS NOT NULL
             AND (a.working_hours IS NULL OR a.working_hours < 0 OR a.working_hours > 24)
        THEN ROUND(TIME_TO_SEC(TIMEDIFF(a.check_out_time, a.check_in_time)) / 3600.0, 2)
        WHEN a.working_hours < 0 OR a.working_hours > 24 THEN NULL
        ELSE a.working_hours
    END AS working_hours_clean
FROM attendance a;

-- 5. CLEAN LEAVES
CREATE TABLE clean_leaves AS
SELECT
    l.leave_id,
    l.employee_id,
    CASE
        WHEN UPPER(TRIM(l.leave_type)) = 'SICK LEAVE' THEN 'Sick Leave'
        WHEN UPPER(TRIM(l.leave_type)) = 'CASUAL LEAVE' THEN 'Casual Leave'
        WHEN UPPER(TRIM(l.leave_type)) = 'EARNED LEAVE' THEN 'Earned Leave'
        ELSE 'Not Specified'
    END AS leave_type_clean,
    l.start_date,
    l.end_date,
    CASE
        WHEN l.leave_days < 0 THEN ABS(l.leave_days)
        WHEN l.leave_days IS NULL THEN DATEDIFF(l.end_date, l.start_date) + 1
        ELSE l.leave_days
    END AS leave_days_clean,
    CASE
        WHEN UPPER(TRIM(l.leave_status)) = 'APPROVED' THEN 'Approved'
        WHEN UPPER(TRIM(l.leave_status)) = 'PENDING' THEN 'Pending'
        WHEN UPPER(TRIM(l.leave_status)) = 'REJECTED' THEN 'Rejected'
        ELSE 'Not Specified'
    END AS leave_status_clean
FROM leaves l
WHERE l.end_date >= l.start_date OR l.end_date IS NULL;

-- 6. CLEAN PERFORMANCE
CREATE TABLE clean_performance AS
SELECT
    p.performance_id,
    p.employee_id,
    p.review_date,
    CASE
        WHEN p.performance_rating < 1 OR p.performance_rating > 5 THEN NULL
        ELSE p.performance_rating
    END AS performance_rating_clean,
    COALESCE(p.productivity_score, (SELECT AVG(productivity_score) FROM performance WHERE productivity_score IS NOT NULL)) AS productivity_score_clean,
    COALESCE(p.quality_score, (SELECT AVG(quality_score) FROM performance WHERE quality_score IS NOT NULL)) AS quality_score_clean,
    p.manager_rating,
    p.performance_status
FROM performance p;

-- 7. CLEAN SALARY HISTORY
CREATE TABLE clean_salary_history AS
SELECT
    s.salary_id,
    s.employee_id,
    s.salary,
    s.effective_date,
    CASE
        WHEN s.salary_increment_percent < 0 THEN NULL
        ELSE s.salary_increment_percent
    END AS salary_increment_percent_clean
FROM salary_history s;

-- VERIFY ALL 7 CLEAN TABLES AT ONCE
SELECT
    (SELECT COUNT(*) FROM clean_departments)   AS clean_departments,
    (SELECT COUNT(*) FROM clean_job_roles)     AS clean_job_roles,
    (SELECT COUNT(*) FROM clean_employees)     AS clean_employees,
    (SELECT COUNT(*) FROM clean_attendance)    AS clean_attendance,
    (SELECT COUNT(*) FROM clean_leaves)        AS clean_leaves,
    (SELECT COUNT(*) FROM clean_performance)   AS clean_performance,
    (SELECT COUNT(*) FROM clean_salary_history) AS clean_salary_history;