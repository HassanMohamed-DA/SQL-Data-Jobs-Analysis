/*
Question: What are the most in-demand skills for remote Data Analyst roles?

- Analyzes all remote Data Analyst postings
- Counts and ranks the top 5 required skills

Goal: Identify key skills employers seek to boost job market alignment.
*/

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

/*
===============================================================================
Top 5 Most In-Demand Skills for Remote Data Analysts
===============================================================================

Skill       | Demand Count
----------------------------
SQL         | 7,291
Excel       | 4,611
Python      | 4,330
Tableau     | 3,745
Power BI    | 2,609

Insights:
- SQL and Excel are fundamental for remote data roles, especially in data 
  querying and spreadsheet analysis.
- Python and Tableau highlight the demand for programming and visualization 
  capabilities.
- Power BI reflects growing interest in Microsoft’s ecosystem for business 
  intelligence and reporting.

These insights can help guide professionals in skill development and focus 
their learning path to match industry needs.

===============================================================================
*/
