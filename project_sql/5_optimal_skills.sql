/*
Question: Which skills are both in high demand and highly paid for remote Data Analyst roles?

- Uses remote Data Analyst jobs with salary data
- Combines skill frequency with average salary
- Ranks top skills with strong demand and pay

Goal: Highlight the most valuable skills for career growth in data analytics.
*/

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
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

/*
===============================================================================
Top Skills with High Demand and High Salary for Remote Data Analysts
===============================================================================

Skill           | Demand Count | Avg. Salary (USD)
----------------------------------------------------
Go              | 27           | $115,320
Confluence      | 11           | $114,210
Hadoop          | 22           | $113,193
Snowflake       | 37           | $112,948
Azure           | 34           | $111,225
BigQuery        | 13           | $109,654
AWS             | 32           | $108,317
Java            | 17           | $106,906
SSIS            | 12           | $106,683
Jira            | 20           | $104,918
Oracle          | 37           | $104,534
Looker          | 49           | $103,795
NoSQL           | 13           | $101,414
Python          | 236          | $101,397
R               | 148          | $100,499
Redshift        | 16           | $99,936
Qlik            | 13           | $99,631
Tableau         | 230          | $99,288
SSRS            | 14           | $99,171
Spark           | 13           | $99,077
C++             | 11           | $98,958
SAS             | 63           | $98,902
SQL Server      | 35           | $97,786
JavaScript      | 20           | $97,587

Insights:
- Programming & Cloud Platforms: Skills like Python, Go, AWS, and Azure 
  command high pay and strong demand, signaling value in technical proficiency.
- Business Intelligence & Databases: Tools like Tableau, Looker, Snowflake, 
  and Oracle highlight demand for strong visualization and data warehousing.
- Emerging & Niche Tools: Technologies such as BigQuery, Redshift, and 
  Hadoop offer lucrative opportunities despite smaller demand footprints.

These skills represent strategic areas for upskilling that combine employability 
with competitive compensation in remote data roles.

===============================================================================
*/
