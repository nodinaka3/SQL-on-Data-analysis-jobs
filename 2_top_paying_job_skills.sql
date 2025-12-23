/*
Question: What skills are required for the top-paying Business Analyst jobs?
- Use the top 10 highest-paying Business Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills
    helping job seekers understand which skills to devlop that align with top salaries. 
*/


WITH top_paying_job AS (
    SELECT
        job_id,
        job_title_short,
        job_location,
        job_schedule_type,
        salary_year_avg,
        name AS employer_name
    FROM
        job_postings_fact
        LEFT JOIN
            company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short ILIKE '%Business_Analyst%' AND
        salary_year_avg IS NOT NULL AND
        job_location IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_job.*,
    skills
FROM
    top_paying_job
    INNER JOIN
        skills_job_dim ON top_paying_job.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_job.salary_year_avg DESC;

/*
Here's the breakdown of the most demand skills for business analyst in 2023, based on job postings:
SQL is leading by 6 mentions
followed by Python with 5 mentions
Other skills like tableau, Snowflake show varying degree of demand 
Its interesting that Excel was not among the top skills
*/