USE employee_hr_analytics;

DROP TABLE IF EXISTS salary_history;
DROP TABLE IF EXISTS performance;
DROP TABLE IF EXISTS leaves;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS job_roles;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    department_id   INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

CREATE TABLE job_roles (
    job_role_id  INT AUTO_INCREMENT PRIMARY KEY,
    job_role     VARCHAR(100) NOT NULL,
    job_level    VARCHAR(50)
);

CREATE TABLE employees (
    employee_id       INT AUTO_INCREMENT PRIMARY KEY,
    employee_name     VARCHAR(150),
    gender            VARCHAR(20),
    age               INT,
    city              VARCHAR(100),
    state             VARCHAR(100),
    department_id     INT,
    job_role_id       INT,
    joining_date      DATE,
    employment_status VARCHAR(50),
    salary            DECIMAL(12,2),
    CONSTRAINT fk_emp_department FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT fk_emp_jobrole FOREIGN KEY (job_role_id) REFERENCES job_roles(job_role_id)
);

CREATE TABLE attendance (
    attendance_id     INT AUTO_INCREMENT PRIMARY KEY,
    employee_id       INT,
    attendance_date   DATE,
    attendance_status VARCHAR(50),
    check_in_time     TIME,
    check_out_time    TIME,
    working_hours     DECIMAL(5,2),
    CONSTRAINT fk_att_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE leaves (
    leave_id     INT AUTO_INCREMENT PRIMARY KEY,
    employee_id  INT,
    leave_type   VARCHAR(50),
    start_date   DATE,
    end_date     DATE,
    leave_days   INT,
    leave_status VARCHAR(50),
    CONSTRAINT fk_leave_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE performance (
    performance_id     INT AUTO_INCREMENT PRIMARY KEY,
    employee_id        INT,
    review_date        DATE,
    performance_rating DECIMAL(3,1),
    productivity_score DECIMAL(5,2),
    quality_score       DECIMAL(5,2),
    manager_rating      DECIMAL(3,1),
    performance_status  VARCHAR(50),
    CONSTRAINT fk_perf_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE salary_history (
    salary_id               INT AUTO_INCREMENT PRIMARY KEY,
    employee_id             INT,
    salary                  DECIMAL(12,2),
    effective_date          DATE,
    salary_increment_percent DECIMAL(5,2),
    CONSTRAINT fk_sal_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

SELECT 'All 7 tables created successfully' AS status;