SELECT '2023-02-19'::DATE,
'123'::INTEGER,
'TRUE'::BOOLEAN,
'3.14'::REAL;

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year 
FROM 
    job_postings_fact
LIMIT 5;

SELECT COUNT(job_id) AS count_of_job_id,
EXTRACT(MONTH FROM job_posted_date) AS month
FROM
job_postings_fact
WHERE job_title_short='Data Analyst'
GROUP BY    
month    
ORDER BY count_of_job_id;


