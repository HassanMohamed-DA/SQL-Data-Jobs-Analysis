/*
Question: What are the top-paying skills for remote Data Analyst roles?

- Uses remote Data Analyst jobs with salary data
- Calculates average salary per skill
- Ranks the top 25 skills by pay

Goal: Reveal which skills bring the highest earnings in remote analytics roles.
*/

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

/*
===============================================================================
Top 25 Highest-Paying Skills for Remote Data Analysts
===============================================================================

Skill           | Avg. Salary (USD)
-------------------------------------
pyspark         | $208,172
bitbucket       | $189,155
couchbase       | $160,515
watson          | $160,515
datarobot       | $155,486
gitlab          | $154,500
swift           | $153,750
jupyter         | $152,777
pandas          | $151,821
elasticsearch   | $145,000
golang          | $145,000
numpy           | $143,513
databricks      | $141,907
linux           | $136,508
kubernetes      | $132,500
atlassian       | $131,162
twilio          | $127,000
airflow         | $126,103
scikit-learn    | $125,781
jenkins         | $125,436
notion          | $125,000
scala           | $124,903
postgresql      | $123,879
gcp             | $122,500
microstrategy   | $121,619

Insights:
- Big Data & ML: Skills like PySpark, DataRobot, Pandas, and Jupyter are top 
  earners, reflecting high demand for data processing and predictive modeling.
- DevOps & Deployment: Tools like GitLab, Kubernetes, and Airflow signal 
  that engineering and automation skills boost compensation.
- Cloud Platforms: Proficiency in Elasticsearch, GCP, and Databricks shows 
  that cloud-native skills are highly valued in today’s analytics roles.

These findings can guide upskilling decisions by highlighting the most 
financially rewarding areas in the data analytics field.

===============================================================================
*/
