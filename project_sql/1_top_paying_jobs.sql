/*
Question: What are the highest-paying remote Data Analyst roles?

- Remote only (job_location = 'Anywhere')
- Salary data must be available
- Shows employer names

Goal: Find top-paying remote roles and salary trends.
*/


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
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

/*
===============================================================================
Insights from Query Results (2023)
===============================================================================

Salary Range:
Salaries for remote Data Analyst positions range from $184,000 to $650,000 annually,
indicating strong compensation potential in the field.

Employers:
Companies offering these roles include:
- Mantys
- Meta
- AT&T
- Pinterest
- SmartAsset

This reflects broad demand across various industries.

Role Diversity:
Job titles range from entry-level to senior positions, such as:
- Data Analyst
- Director of Analytics
- Associate Director – Data Insights
- Principal Data Analyst

This illustrates a wide range of experience levels and responsibilities.

===============================================================================
Sample Output (Truncated)
===============================================================================

job_id   | job_title                          | company_name                     | salary_year_avg
-----------------------------------------------------------------------------------------------
226942   | Data Analyst                       | Mantys                           | 650000
547382   | Director of Analytics              | Meta                             | 336500
552322   | Associate Director – Data Insights | AT&T                             | 255829.5
99305    | Data Analyst, Marketing            | Pinterest Job Advertisements     | 232423
1021647  | Data Analyst (Hybrid/Remote)       | Uclahealthcareers                | 217000
168310   | Principal Data Analyst (Remote)    | SmartAsset                       | 205000
731368   | Director, Data Analyst – HYBRID    | Inclusively                      | 189309
310660   | Principal Data Analyst, AV Perf.   | Motional                         | 189000
1749593  | Principal Data Analyst             | SmartAsset                       | 186000
387860   | ERM Data Analyst                   | Get It Recruit - IT              | 184000

===============================================================================
*/

