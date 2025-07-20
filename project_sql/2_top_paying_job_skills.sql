/*
Question: What skills are most needed in top-paying remote Data Analyst jobs?

- Uses high-paying remote roles with salary info
- Joins skill data to link jobs with required skills

Goal: Reveal top-valued technical skills in high-paying analyst roles.
*/


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

/*
===============================================================================
Skills Breakdown (Most Frequently Required)
===============================================================================

A count of how often each skill appears among the top-paying remote roles:

Skill         | Frequency
--------------------------
SQL           | 8
Python        | 7
Tableau       | 6
Excel         | 4
R             | 3
Snowflake     | 2
Power BI      | 2
Looker        | 1
Databricks    | 1
Pandas        | 1

These results indicate that SQL, Python, and Tableau are key tools expected 
by employers offering high-paying remote Data Analyst roles. Cloud-based 
platforms and BI tools are also featured, suggesting increasing demand for 
data pipeline and dashboarding skills.

===============================================================================
Example Output (Truncated)
===============================================================================

job_id   | job_title               | company_name   | salary_year_avg | skills
-------------------------------------------------------------------------------
226942   | Data Analyst            | Mantys         | 650000          | Tableau
226942   | Data Analyst            | Mantys         | 650000          | SQL
547382   | Director of Analytics   | Meta           | 336500          | Python
547382   | Director of Analytics   | Meta           | 336500          | R
552322   | Assoc. Director         | AT&T           | 255829.5        | Snowflake
99305    | Data Analyst            | Pinterest      | 232423          | SQL
...
===============================================================================
*/
