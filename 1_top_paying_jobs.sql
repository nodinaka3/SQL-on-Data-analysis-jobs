/*
Question: What are the top-paying business analyst jobs?
- Identify the top 10 highest-paying Business Analyst Roles that are available irrespective of location.
- Focuses on job postings with speciifed salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Business Analysts.
- This offers insights into one looking to pivot into Business Analysis and employer inisghts. 
*/

SELECT
    job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS employer_name
FROM
    job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short ILIKE '%Business Analyst%' AND
    salary_year_avg IS NOT NULL AND
    job_location IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10