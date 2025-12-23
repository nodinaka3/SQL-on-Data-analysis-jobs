/*
Question: What are the optimal skills to learn (aka it's in high demand and a high-paying skills)?
- Identify skills in high demand and associated with high average salaries for Business Analyst roles
- Concentrate on all jobs irrespective of location positions with specified salaries
- Why? Targets skills that maximize both employability and earning potential,
    offering strategic insights for career development in Business Analysis
*/

    WITH High_Demand_Skills AS (
        SELECT
            skills_dim.skill_id,
            skills_dim.skills,
            COUNT(skills_job_dim.skill_id) AS skill_demand_count
        FROM
            job_postings_fact
            INNER JOIN
                skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
            INNER JOIN
                skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE
            LOWER(job_postings_fact.job_title) LIKE LOWER('%business analyst%')
            AND salary_year_avg IS NOT NULL 
        GROUP BY
            skills_dim.skill_id
),
    High_Paying_Skills AS (
        SELECT
            skills_job_dim.skill_id,
            ROUND(AVG(salary_year_avg), 0) AS avg_salary
        FROM
            job_postings_fact
            INNER JOIN
                skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
            INNER JOIN
                skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE
            LOWER(job_postings_fact.job_title) LIKE LOWER('%business analyst%')
            AND salary_year_avg IS NOT NULL    
        GROUP BY
            skills_job_dim.skill_id
)

SELECT
    High_Demand_Skills.skills,
    High_Demand_Skills.skill_demand_count,
    High_Paying_Skills.avg_salary
FROM
    High_Demand_Skills
    INNER JOIN
        High_Paying_Skills ON High_Demand_Skills.skill_id = High_Paying_Skills.skill_id
ORDER BY
    High_Demand_Skills.skill_demand_count DESC,
    High_Paying_Skills.avg_salary DESC
LIMIT 25;


-- Rewriting this same query more concisely without CTEs
SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    LOWER(job_postings_fact.job_title) LIKE LOWER('%business analyst%')
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25;