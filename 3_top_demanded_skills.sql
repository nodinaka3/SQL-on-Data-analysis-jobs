/*
Question: What are the most in-demand skills for Business Analyst?
- join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for a business analyst
- Focus on all job postings
- Why? Retrieves the top 10 skills with the highest demand in the job market,
    providing inisghts into the most valuable skills for job seekers.
*/


SELECT
    skills,
    COUNT(skills_dim.skill_id) AS skill_demand_count
FROM
    job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    LOWER(job_postings_fact.job_title) LIKE LOWER('%business analyst%')
GROUP BY
    skills
ORDER BY
    skill_demand_count DESC
LIMIT 10;