/*
Question: What are the most in-demand skills for Business Analyst based on salary?
- Look at the average salary associated with each skill
- Focuses on roles with specified salaries, regardless of location
- Why? Provides a clear picture of the skills that are most valued in the job market,
    helping job seekers to prioritize their skill development.
*/


SELECT
    skills,
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
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
-Top salaries cluster around big data and cloud tools like Scala, Databricks, Hadoop, GCP
- Modelling and statistical depth also command higher compensation in skills like PyTorch, TensorFlow, MATLAB
- Knowledge of data governance and enterprise environment like GDPR, Unix, and Shell is rewarded
    because roles influence compliance, scalabiliy and decision making at organizational level.
*/