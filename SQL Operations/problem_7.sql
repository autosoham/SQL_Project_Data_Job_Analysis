--practice problem 7
/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill  
*/
WITH remote_job_skills AS (
SELECT 
    skill_id,
    COUNT(*) as skills_count
FROM    
    skills_job_dim AS skills_to_job    
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
-- LEFT JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id
WHERE
   job_postings.job_work_from_home  = TRUE AND job_postings.job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)
SELECT 
    remote_job_skills.skill_id,
    skills AS skill_name,
    remote_job_skills.skills_count 
FROM skills_dim
INNER JOIN remote_job_skills ON remote_job_skills.skill_id = skills_dim.skill_id  
ORDER BY 
    skills_count DESC
LIMIT 5 ;              