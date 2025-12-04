CREATE TABLE january_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;   -- January

CREATE TABLE february_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;   -- February

CREATE TABLE march_jobs AS 
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;   -- March
-- *****************************************************************
/* 
label new column as follows:
 - 'Anywhere' jobs as 'remote'
 - 'New York, NY' jobs as 'local'    
 - otherwise 'onsite'
 */
SELECT 
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM    
    job_postings_fact    


 -- *************************************************************************
 -- suppose we want to count the number of jobs 
 -- each in online , remote and local
SELECT 
    COUNT(job_id) as number_of_jobs ,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM    
    job_postings_fact   
GROUP BY
    location_category;  
--**********************************************************
-- suppose we want the number of data analyst jobs.
-- in remote , onsite or local category.
SELECT 
    COUNT(job_id) as number_of_jobs ,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM    
    job_postings_fact   
WHERE
    job_title_short = 'Data Analyst'    
GROUP BY
    location_category;
-- *******************************************************

