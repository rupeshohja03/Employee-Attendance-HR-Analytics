Employee Attendance, Performance & HR Analytics

Project Overview

Employee Attendance, Performance & HR Analytics is an end-to-end data analytics project built using MySQL, SQL, Power BI, and DAX.

The project analyzes employee attendance, leave patterns, performance, salaries, departments, job roles, employee tenure, and other HR-related metrics.

The goal of the project is to transform structured HR data into meaningful business insights through SQL analysis and an interactive Power BI dashboard.

---

Business Problem

HR teams need to monitor workforce information such as employee attendance, leave usage, performance, salary, job roles, and employee tenure.

Analyzing these metrics separately can make it difficult to identify workforce patterns and compare departments or employees.

This project provides a centralized analytical solution that allows HR-related data to be explored through SQL queries and interactive Power BI dashboards.

---

Project Objectives

- Analyze employee demographics and workforce distribution.
- Analyze employee attendance and absence patterns.
- Analyze leave usage and leave trends.
- Analyze employee performance metrics.
- Analyze salaries and salary increments.
- Analyze employee tenure and employment status.
- Compare HR metrics across departments and job roles.
- Explore relationships between attendance, working hours, leave, salary, and performance.
- Build an interactive Power BI dashboard for HR analytics.

---

Tools & Technologies

Tool| Purpose
MySQL Workbench| Database creation, data management and SQL analysis
SQL| Data cleaning, validation and analytics
Power BI Desktop| Data modeling and dashboard development
DAX| KPI and analytical measures

---

Dataset

The project uses a structured HR dataset containing employee-related information.

The database includes:

- Employee information
- Department information
- Job roles
- Attendance records
- Leave records
- Performance records
- Salary history

The dataset contains realistic employee information and selected data-quality issues to demonstrate practical data profiling and cleaning.

Examples of data-quality issues include:

- NULL values
- Missing values
- Duplicate records
- Inconsistent text formatting
- Inconsistent department/job-role names
- Unusual working-hour values
- Unusual salary values
- Inconsistent attendance statuses
- Invalid or unusual records

---

Database Structure

The MySQL database is named:

employee_hr_analytics

Tables

departments
     ↓
employees
     ↓
 ┌───┼───────────────┬──────────────┐
 ↓   ↓               ↓              ↓
attendance   leaves   performance   salary_history

job_roles
     ↓
employees

Main Tables

"employees"

Contains employee demographic, organizational and employment information.

"departments"

Contains department details.

"job_roles"

Contains job role and job-level information.

"attendance"

Contains employee attendance, check-in, check-out and working-hour information.

"leaves"

Contains employee leave type, duration and status.

"performance"

Contains performance rating, productivity, quality and manager rating.

"salary_history"

Contains salary information and salary increment history.

---

Data Cleaning

The raw data was kept separate from the cleaned analytical data.

The cleaning process included:

- Duplicate detection and handling
- NULL and missing-value handling
- Text standardization
- Department name standardization
- Job-role standardization
- Date validation
- Attendance data cleaning
- Leave data cleaning
- Performance data validation
- Salary data validation
- Employee relationship validation
- Creation of analytical columns where required

The original raw data was not overwritten.

---

SQL Analysis

SQL was used to perform analysis across multiple HR categories.

Employee Analysis

- Total employees
- Active employees
- Employees by department
- Employees by job role
- Employees by city
- Employees by state
- Gender distribution
- Age distribution
- Employee tenure

Attendance Analysis

- Attendance percentage
- Absence percentage
- Work-from-home percentage
- Late attendance
- Average working hours
- Monthly attendance
- Department-wise attendance
- Employee-wise attendance
- Employees with high absence levels

Leave Analysis

- Total leave days
- Leave by type
- Leave by department
- Leave by employee
- Monthly leave trends
- Employees with high leave usage

Performance Analysis

- Average performance rating
- Department performance
- Employee performance
- Productivity score
- Quality score
- Manager rating
- High-performing employees
- Low-performing employees

Salary Analysis

- Average salary
- Salary by department
- Salary by job role
- Salary by experience
- Salary increment analysis
- Salary distribution

Combined Analysis

The project also analyzes relationships between:

- Attendance and performance
- Working hours and performance
- Leave and performance
- Salary and performance
- Department and performance

---

Power BI Dashboard

The final Power BI report contains four dashboard pages.

1. HR Executive Overview

Includes:

- Total Employees
- Active Employees
- Attendance %
- Average Performance Rating
- Average Salary
- Average Working Hours
- Employee Count by Department
- Monthly Attendance Trend
- Employee Distribution by City
- Gender Distribution

2. Attendance & Leave Analysis

Includes:

- Monthly Attendance Trend
- Attendance by Department
- Attendance Status
- Present vs Absent
- Work From Home
- Late Attendance
- Average Working Hours
- Leave by Type
- Leave by Department
- Monthly Leave Trend
- Employees with Highest Absences

3. Employee Performance

Includes:

- Average Performance Rating
- Department Performance
- Employee Performance
- Productivity Score
- Quality Score
- Manager Rating
- Top Performing Employees
- Low Performing Employees
- Performance by Job Role
- Performance vs Working Hours

4. Salary & HR Analysis

Includes:

- Average Salary
- Salary by Department
- Salary by Job Role
- Salary by Experience
- Salary Distribution
- Salary Increment Analysis
- Employee Tenure
- Employee Status
- High Performer vs Salary
- Attendance vs Performance

---

DAX Measures

DAX was used to create reusable Power BI measures for important HR KPIs.

Examples include:

- Total Employees
- Active Employees
- Total Attendance
- Present Days
- Absent Days
- Attendance %
- Absence %
- Total Leave Days
- Average Working Hours
- Average Performance Rating
- Average Productivity Score
- Average Quality Score
- Average Salary
- Total Salary
- Average Employee Tenure
- High Performers
- Low Performers
- Monthly Attendance
- Monthly Leave
- Monthly Performance
- Department Performance

---

Dashboard Screenshots

HR Executive Overview

"HR Executive Overview" (<img width="1165" height="650" alt="01_HR_Overview png" src="https://github.com/user-attachments/assets/49bccfce-4c22-4310-afbf-4acdb026c37e" />
)

Attendance & Leave Analysis

"Attendance & Leave Analysis" (<img width="1156" height="706" alt="Attendance   Leave png" src="https://github.com/user-attachments/assets/bcab3475-3179-468a-86c4-d2a3cfc2d910" />
)

Employee Performance

"Employee Performance" (<img width="1157" height="697" alt="03_Performance png" src="https://github.com/user-attachments/assets/d4bbb59c-d4c4-4360-b299-55eb298bdbeb" />
)

Salary & HR Analysis

"Salary & HR Analysis" (<img width="1156" height="706" alt="Attendance   Leave png" src="https://github.com/user-attachments/assets/e53695e3-e836-4282-ba32-7afe4502d188" />
)

---

Key Insights

The dashboard was created to identify patterns across workforce, attendance, leave, performance and salary data.

Key areas analyzed include:

- Department workforce distribution
- Employee attendance patterns
- Absence trends
- Leave utilization
- Working-hour patterns
- Employee performance
- Salary distribution
- Salary differences by department and job role
- Employee tenure
- Attendance vs performance
- Working hours vs performance
- Salary vs performance

«Specific numerical insights are based on the data contained in the completed Power BI report.»

---

How to Run the Project

1. Clone or Download the Repository

Download the project repository to your computer.

2. Open MySQL Workbench

Open MySQL Workbench and connect to your local MySQL Server.

3. Create the Database

Run:

SQL/01_database_setup.sql

4. Create the Tables

Run:

SQL/02_create_tables.sql

5. Insert the Data

Run:

SQL/03_insert_raw_data.sql

6. Profile the Data

Run:

SQL/04_data_profiling.sql

7. Clean the Data

Run:

SQL/05_data_cleaning.sql

The raw data is kept unchanged during the cleaning process.

8. Run the Analytics

Run:

SQL/06_analytics.sql

9. Open Power BI

Open:

PowerBI/Employee_Attendance_HR_Analytics.pbix

10. Refresh the Report

After connecting the report to the MySQL database, refresh the Power BI data when the source data is updated.

---

Project Structure

Employee-Attendance-HR-Analytics/
│
├── SQL/
│   ├── 01_database_setup.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_raw_data.sql
│   ├── 04_data_profiling.sql
│   ├── 05_data_cleaning.sql
│   └── 06_analytics.sql
│
├── PowerBI/
│   └── Employee_Attendance_HR_Analytics.pbix
│
├── Screenshots/
│   ├── dashboard_overview.png
│   ├── attendance_analysis.png
│   ├── employee_performance.png
│   └── salary_hr_analysis.png
│
├── Documentation/
│   ├── Project_Documentation.md
│   ├── Data_Dictionary.md
│   └── Business_Questions.md
│
└── README.md

---

Project Workflow

Raw HR Data
     ↓
MySQL Database
     ↓
Data Profiling
     ↓
Data Cleaning
     ↓
Clean Analytical Data
     ↓
SQL Analysis
     ↓
Power BI
     ↓
Data Modeling
     ↓
DAX Measures
     ↓
Interactive HR Dashboard

---

Skills Demonstrated

SQL

- SELECT
- WHERE
- GROUP BY
- HAVING
- JOINs
- CASE WHEN
- Aggregations
- Date functions
- Duplicate detection
- NULL handling
- Data cleaning
- Analytical queries

MySQL

- Database creation
- Table creation
- Primary keys
- Foreign keys
- Relational data modeling
- Data validation
- Data profiling
- Data transformation

Power BI

- MySQL connection
- Data modeling
- Relationships
- KPI cards
- Charts
- Tables
- Slicers
- Interactive dashboards
- Dashboard formatting

DAX

- Measures
- Aggregations
- KPI calculations
- Percentage calculations
- Attendance metrics
- Performance metrics
- HR metrics

---

Future Improvements

Potential future improvements include:

- Adding a dedicated date/calendar dimension
- Adding employee attrition analysis
- Adding recruitment analytics
- Adding employee satisfaction metrics
- Adding training and development analysis
- Adding overtime analysis
- Adding additional HR KPIs
- Expanding the historical dataset
- Adding more advanced DAX calculations
- Adding additional dashboard pages

---

Limitations

This is a portfolio analytics project using a prepared dataset.

The dataset does not represent confidential information from a real organization.

The analysis is intended to demonstrate practical data analytics skills and should not be interpreted as actual statistics from a real company.

Relationships between HR metrics should be interpreted carefully. A relationship between two variables does not automatically establish causation.

---

Conclusion

The Employee Attendance, Performance & HR Analytics project demonstrates an end-to-end data analytics workflow using MySQL, SQL, Power BI, and DAX.

The project covers the complete process from database creation and data profiling to data cleaning, SQL analysis, Power BI data modeling, DAX calculations and interactive dashboard development.

It demonstrates how structured HR data can be transformed into an interactive analytical solution for exploring employee attendance, leave, performance, salary and workforce-related metrics.

---

Author

Rupesh Ojha

B.Tech Computer Science & Engineering

Project Technologies

"MySQL" "SQL" "Power BI" "DAX" "Data Analytics" "HR Analytics"
