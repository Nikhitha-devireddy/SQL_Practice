-- January
CREATE TABLE january_jobs AS 
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS 
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS 
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_posted_date
FROM march_jobs;

SELECT job_title_short,job_location, 
CASE
    WHEN job_location='Anywhere' THEN 'Remote'
    WHEN job_location='New York, NY' THEN 'Local'
    ELSE 'Onsite'
END AS location_category
FROM job_postings_fact;

SELECT
       quarter1_job_postings.job_title_short,
       quarter1_job_postings.job_location,
       quarter1_job_postings.job_via,
       quarter1_job_postings.job_posted_date::date,
       quarter1_job_postings.salary_year_avg
FROM
(
SELECT * FROM january_jobs
UNION ALL
SELECT * FROM february_jobs
UNION ALL
SELECT * FROM march_jobs
)AS quarter1_job_postings
WHERE quarter1_job_postings.salary_year_avg>70000 AND
quarter1_job_postings.job_title_short='Data Analyst'
ORDER BY salary_year_avg DESC;



