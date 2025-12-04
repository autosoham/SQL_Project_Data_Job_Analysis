SELECT *
FROM( -- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs ; 
-- subquery ends here
-- *******************************************************************
WITH january_jobs AS( -- CTE definition starts here
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1
 )-- CTE definition ends here

SELECT * FROM january_jobs;
-- **************************************************************************
SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN(
SELECT 
     company_id
FROM
    job_postings_fact
WHERE
    job_no_degree_mention = true
);
-- *************************************************************
/*
Find the total number of companies that have the most job openings
- Get the total number of job postings per company id(job_posting_fact)
- Return the total number of jobs with the company name(company_dim)
*/
WITH company_job_count AS(
    SELECT
            company_id,
            COUNT(*) AS total_jobs
    FROM
            job_postings_fact           
    GROUP BY
            company_id             
)

SELECT 
    company_dim.name AS company_name ,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY company_job_count.total_jobs DESC
-- ********************************************************************************
--practice problem 7
/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill  
*/
