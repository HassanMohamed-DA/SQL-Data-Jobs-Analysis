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

- **SQL** – The core language behind my queries, helping extract insights from data.
- **PostgreSQL** – A reliable database system used to store and manage job data.
- **Visual Studio Code** – My main environment for writing and running SQL. 
- **Git & GitHub** – Used for version control and sharing work easily.
---

# The Analysis


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

A list of the top 10 highest-paying remote data analyst roles pulled from the query:
| job_id   | job_title                          | company_name                  | salary_year_avg |
|----------|------------------------------------|-------------------------------|-----------------|
| 226942   | Data Analyst                       | Mantys                        | 650000          |
| 547382   | Director of Analytics              | Meta                          | 336500          |
| 552322   | Associate Director – Data Insights | AT&T                          | 255829.5        |
| 99305    | Data Analyst, Marketing            | Pinterest Job Advertisements  | 232423          |
| 1021647  | Data Analyst (Hybrid/Remote)       | Uclahealthcareers             | 217000          |
| 168310   | Principal Data Analyst (Remote)    | SmartAsset                    | 205000          |
| 731368   | Director, Data Analyst – HYBRID    | Inclusively                   | 189309          |
| 310660   | Principal Data Analyst, AV Perf.   | Motional                      | 189000          |
| 1749593  | Principal Data Analyst             | SmartAsset                    | 186000          |
| 387860   | ERM Data Analyst                   | Get It Recruit - IT           | 184000          |


## 💡 Insights on Top Data Analyst Jobs

- **Salary Range:** Top 10 roles offer $184K–$650K, showing strong earning potential  
- **Employers:** Companies like Mantys, SmartAsset, Meta, and AT&T lead in top-paying analyst roles.
- **Job Titles:** From Data Analyst to Director of Analytics—wide role variety in the field

  ```


## 2️⃣ Skills for Top Paying Jobs
To find the most in-demand skills, I analyzed the top-paying remote data analyst jobs by linking salary data with required skills using SQL joins.

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

A count of how often each skill appeared among the top 10 highest-paying remote data analyst jobs:
| Skill       | Frequency |
|-------------|-----------|
| SQL         | 8         |
| Python      | 7         |
| Tableau     | 6         |
| Excel       | 4         |
| R           | 3         |
| Snowflake   | 2         |
| Power BI    | 2         |
| Looker      | 1         |
| Databricks  | 1         |
| Pandas      | 1         |

## 💡 Insights on In-Demand Skills

- **SQL**, **Python**, and **Tableau** are the most in-demand skills  
- **Excel**, **R**, and **Snowflake** also show up frequently  
- Other skills like **R**, **Snowflake**, **Pandas**, and **Power BI** show varying levels of demand across top-paying roles.
- Employers in top-paying roles prioritize strong skills in **data handling**, **analytics**, and **visualization tools**.

  ```



 ## 3️⃣ Most In-Demand Skills for Remote Data Analyst Roles

To find the top skills for **remote Data Analyst roles**, I filtered job postings by title and remote status, then ranked the **5 most mentioned skills**.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

 ```

A breakdown of The **top 5 most in-demand skills** for remote data analyst jobs:
| Skill     | Demand Count |
|-----------|--------------|
| SQL       | 7,291        |
| Excel     | 4,611        |
| Python    | 4,330        |
| Tableau   | 3,745        |
| Power BI  | 2,609        |

## 💡 Insights on In-Demand Skills for Remote Data Analyst Roles
- **SQL** and **Excel** are fundamental for remote data roles, especially in data querying and spreadsheet analysis.  
- **Python** and **Tableau** highlight the demand for programming and visualization capabilities.  
- Although **Tableau** is more in demand overall, **Power BI** reflects a growing interest in **Microsoft’s ecosystem** for business intelligence and reporting.

  ```


## 4️⃣ Skills Based on Salary

Exploring the average salaries associated with different skills revealed which ones are the highest paying for **remote Data Analyst roles**.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
 ```

Table of the average salary for the top 10 paying skills for data analysts
| Skills        | Average Salary ($) |
|---------------|-------------------:|
| PySpark       |            208,172 |
| Bitbucket     |            189,155 |
| Couchbase     |            160,515 |
| Watson        |            160,515 |
| DataRobot     |            155,486 |
| GitLab        |            154,500 |
| Swift         |            153,750 |
| Jupyter       |            152,777 |
| Pandas        |            151,821 |
| Elasticsearch |            145,000 |


## 💡 Insights on Top-Paying Skills

- **Big Data & ML**: Skills like **PySpark**, **Couchbase**, **DataRobot**, **Jupyter**, **Pandas**, and **NumPy** are highly valued for data processing and predictive modeling.  
- **Dev & Deployment**: Tools such as **GitLab**, **Kubernetes**, and **Airflow** offer a pay boost by bridging data and engineering workflows.  
- **Cloud Expertise**: Knowing **Elasticsearch**, **Databricks**, and **GCP** reflects the demand for cloud-based analytics and earns higher salaries.

  ```


## 5️⃣ Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and offer high average salaries — a strategic focus for upskilling.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
 ```
Table of the most optimal skills for data analysts sorted by salary*
| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |


## 💡 Insights on the most optimal skills for Data Analysts

- **Programming & Cloud Platforms:** Skills like Python, Go, AWS, and Azure are well-paid and widely used.
- **Business Intelligence & Databases:** Tools like Tableau, Looker, Snowflake, and Oracle highlight demand for strong visualization and data warehousing.
- **Emerging & Niche Tools:** Technologies such as BigQuery, Redshift, and Hadoop offer lucrative opportunities despite smaller demand footprints.

---

  ##  Conclusions

From the analysis, several key insights emerged:

- **Top-Paying Data Analyst Jobs**: Remote roles offer a wide salary range, with the highest reaching $650,000!  
- **Skills for Top-Paying Jobs**: High-paying roles often require advanced SQL, making it a critical skill to earn top salaries.  
- **Most In-Demand Skills**: SQL is also the most sought-after skill, making it essential for job seekers.  
- **Skills with Higher Salaries**: Niche tools like SVN and Solidity are tied to the highest average salaries, showing the value of specialized skills.  
- **Optimal Skills for Market Value**: SQL ranks high in both demand and salary, making it one of the best skills to boost a data analyst’s market value.  

---

### 📌This project helped improve my SQL skills and gave me useful insights into the data analyst job market. The results show which skills to focus on and how to approach job searching. By learning in-demand, high-paying skills, aspiring data analysts can stand out. It also shows how important it is to keep learning and stay updated with new trends in data analytics.
