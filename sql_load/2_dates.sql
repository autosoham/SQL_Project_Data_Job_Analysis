SELECT job_posted_date 
FROM job_postings_fact
LIMIT 10;

SELECT 
    '2023-02-19'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL;

-- ***************************************************************************
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date   -- ::DATE gives only the date without the timestamp.
FROM    
    job_postings_fact;
-- ************************************************************************************
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,   -- Extracting the time zone of the timestamp and then getting the timezone we want to go to
    EXTRACT(MONTH FROM job_posted_date) AS date_month, --using the EXTRACT function to extract the month from the date
    EXTRACT(YEAR FROM job_posted_date) AS date_year  -- using th eEXTRACT function to extract the year from the date
FROM    
    job_postings_fact
LIMIT 5;    
-- ****************************************************************************
-- using EXTRACT() for advanced applications
SELECT
    COUNT(job_id) AS job_posted_count,     -- using an aggregation COUNT() to count the job_id
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'    -- Counting only the job_ids where job_title_short is data analyst
GROUP BY
    date_month               -- using the group by function to group all the job postings monthwise.
ORDER BY
job_posted_count;     -- ordeing the entire table contents according the no of jobs.
-- ****************************************************************************************************************
-- Practice problems
-- 1
-- 2
-- 3
