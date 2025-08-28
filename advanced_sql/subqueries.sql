SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date)=1
) AS january_jobs;

WITH nikki AS (
SELECT company_id,COUNT(*) AS job_count
FROM job_postings_fact
GROUP BY company_id
)

SELECT name AS company_name, job_count FROM company_dim 
LEFT JOIN nikki ON nikki.company_id=company_dim.company_id
ORDER BY job_count DESC;

WITH remote_job_skills AS(
SELECT COUNT(*) AS skill_count, skill_id
FROM skills_job_dim
INNER JOIN job_postings_fact ON skills_job_dim.job_id=job_postings_fact.job_id
WHERE job_postings_fact.job_work_from_home=true
GROUP BY skill_id)

SELECT skills_dim.skill_id,skill_count, skills FROM remote_job_skills
INNER JOIN skills_dim ON remote_job_skills.skill_id=skills_dim.skill_id
ORDER BY skill_count DESC
LIMIT 5;

SELECT COUNT(*) AS skill_count, skills_dim.skill_id, skills_dim.skills
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE job_postings_fact.job_work_from_home=true
GROUP BY skills_dim.skill_id
ORDER BY skill_count DESC
LIMIT 5;