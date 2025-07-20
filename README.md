# SQL Deep Analysis: Data Analyst Roles & Opportunities


<img width="1310" height="746" alt="image" src="https://github.com/user-attachments/assets/9e8dfead-3625-4cbe-bd14-ddbcd85cbafe" />




## Introduction

This project takes a closer look at **Data Analyst** careers using real job data and SQL queries.
It explores which companies offer the highest salaries, which skills are most in demand, and where strong hiring trends meet strong pay.
The goal is to highlight what sets top analyst roles apart and show where the best opportunities are in the data analytics field.

**Check out the SQL queries and deep insights here: [SQL Insights Queries](project_sql)**

---

### The following questions guided the SQL queries I created and shaped the direction of my analysis:

1. What are the top-paying data analyst jobs?  
2. What skills are required for these top-paying jobs?  
3. What skills are most in demand for data analysts?  
4. Which skills are associated with higher salaries?  
5. What are the most optimal skills to learn?  

---

### 🛠️ Skills & Tools Used

- **SQL** – The core language behind all my queries, enabling me to extract meaningful insights from the data.  
- **PostgreSQL** – A reliable and powerful database system I used to store and manage job posting data.  
- **Visual Studio Code** – My primary environment for writing and running SQL queries efficiently.  
- **Git & GitHub** – Used for version control and sharing my work, making it easy to track progress and collaborate if needed.

---

# The Analysis

**Each query in this project was designed to explore key aspects of the data analyst job market by answering specific questions or testing clear hypotheses. Here's how I approached each one:**

## 1️⃣ Top Paying Data Analyst Jobs
To find the highest-paying roles, I focused on remote data analyst jobs and filtered them by average yearly salary and location.
```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
