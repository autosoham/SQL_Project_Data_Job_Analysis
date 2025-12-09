# Introduction
📊 Explore the landscape of data careers with this SQL project.
We dig into data analyst roles to uncover 💼 the best opportunities, 💰 the highest paying positions, 🔧 the most valued skills and 📈 the sweet spot where strong demand aligns with strong salaries.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)
# Background
🔍 This project grew out of a need to understand the data analyst job market with more clarity.
The goal is to identify the highest paying roles, the most sought-after skills and help others quickly spot the best opportunities without digging through endless listings.

### The questions I wanted to answer through my SQL queries were:

1. What are the top paying data analyst jobs?
2. What skills are required for these top paying jobs?
3. What skills are in most demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I Used
For this deep dive into the data analyst job market, I worked with a set of reliable tools:

🔹 **SQL** :
The core of my analysis. It helped me query the data and pull out meaningful insights.

🔹 **PostgreSQL** :
My database engine of choice, well suited for managing and exploring job posting data.

🔹 **Visual Studio Code** :
Used for writing and running SQL queries, as well as managing the database workflow.

🔹 **Git and GitHub** :
Handled version control, sharing my scripts and keeping the project organized for easy tracking and collaboration.
# The Analysis
📝 **How I Approached Each Query**

Each SQL query in this project was designed to explore a specific part of the data analyst job market.
Here’s how I broke down and investigated every question to uncover clear, actionable insights.

### 1. Top paying Data Analyst Jobs
To spot the top earning opportunities, I filtered data analyst positions by average yearly salary and location, with a focus on remote roles.
This query brings forward the positions that offer the strongest compensation in the field.

```sql
SELECT
    job_id,
    company_dim.name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM    
    job_postings_fact  
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id          
WHERE
    job_title_short = 'Data Analyst'  AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
💡 **Key Insights**

- **Broad salary range**: Salaries stretch from $184,000 to $650,000, showing how pay scales sharply with experience, leadership and niche expertise.
- **Diverse employers**: High-paying roles appear across tech, finance, telecom and healthcare. Companies like Meta, SmartAsset, AT&T and Mantys all offer competitive packages.
- **Role variety**: The list includes everything from Data Analyst positions to Principal and Director-level roles, reflecting the wide scope within the analytics career path.

![Top Paying Roles](project_sql\assets\1_top_paying_roles.png)
*Bar chart illustrating the top 10 highest salaries for Data Analyst roles, generated from my SQL query results using ChatGPT.*

### 2. Skills for Top Paying Jobs
To identify the skills behind the highest-paying roles, I joined the job postings with the skills dataset. This helped reveal which technical abilities employers consistently prioritize when offering top-tier salaries.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        company_dim.name AS company_name,
        job_title,
        salary_year_avg
    FROM    
        job_postings_fact  
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id 
    WHERE
        job_title_short = 'Data Analyst'  AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10 
) 
SELECT 
    top_paying_jobs.*,
    skills 
    FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC
```
📌 **Refined Breakdown**: Most In-Demand Skills for Top-Paying Data Analyst Roles (2023)

Analyzing the skills associated with the highest-paying data analyst positions shows a clear pattern in what employers are prioritizing:

- **SQL** stands out as the most essential skill, appearing 8 times, making it the backbone of top-tier analytics roles.

- **Python** follows closely with 7 mentions, showing its importance in automation, statistical work and advanced analytics.

- **Tableau** appears 6 times, making it the leading visualization tool for high-paying roles.

- Other notable skills — including R, Snowflake, Pandas and Excel — appear consistently, showing that employers value a mix of programming, cloud data tools and analytical proficiency.

This mix confirms that high-earning analyst roles favor candidates who can manage data end-to-end: from querying and transforming to modeling and presenting insights.
![Top Paying Roles](project_sql\assets\2_top_paying_roles_skills.png)
*Bar chart showing the frequency of skills required for the top 10 highest-paying data analyst roles, generated from my SQL query results using ChatGPT.*

### 3. In-demand skills for Data Analysts
This query highlighted the skills most commonly requested in job postings, helping pinpoint the areas with the highest demand.
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id 
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE    --or job_location = 'Anywhere' 
GROUP BY 
    skills
ORDER BY demand_count DESC    
LIMIT 5;
```
**📚Here's the breakdown of the most demanded skills for data analysts in 2023**
- SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| **Skill** | **Demand Count** |
|----------|------------------|
| SQL      | 7,291            |
| Excel    | 4,611            |
| Python   | 4,330            |
| Tableau  | 3,745            |
| Power BI | 2,609            |



*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Analyzing the average salaries tied to each skill revealed which ones command the highest pay.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id 
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = true
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25;
```
**💸Breakdown of the top-paying skills for Data Analysts:**

- Strong demand for Big Data and ML capabilities: The highest salaries align with skills in big data platforms (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter) and Python libraries such as Pandas and NumPy, showing how valuable advanced data processing and modeling have become.

- Value of development and deployment skills: Expertise in tools like GitLab, Kubernetes and Airflow indicates that roles blending analytics with engineering workflows earn a premium, especially where automation and scalable data pipelines matter.

- Growing importance of cloud expertise: Skills in cloud and data engineering technologies (Elasticsearch, Databricks, GCP) point to the rising influence of cloud-based analytics, with cloud proficiency contributing significantly to higher compensation.

| **Skill**       | **Average Salary ($)** |
|-----------------|------------------------|
| PySpark         | 208,172                |
| Bitbucket       | 189,155                |
| Watson          | 160,515                |
| Couchbase       | 160,515                |
| DataRobot       | 155,486                |
| GitLab          | 154,500                |
| Swift           | 153,750                |
| Jupyter         | 152,777                |
| Pandas         | 151,821                |
| Elasticsearch   | 145,000                |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn
By merging demand and salary data, this query identified skills that are both widely sought after and highly paid, helping highlight the most strategic areas to focus on for skill development.
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg),0) AS average_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id  
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = true
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25; 
```
**⬆️Breakdown of the most optimal skills for Data Analysts in 2023:**

- **High-demand programming languages**: Python and R lead in demand with counts of 236 and 148. Their average salaries—about $101,397 for Python and $100,499 for R—show that these skills are essential, though widely held across the industry.

- **Cloud tools and technologies**: Strong demand and above-average salaries for Snowflake, Azure, AWS and BigQuery reflect the rising importance of cloud platforms and big data infrastructure in modern analytics.

- **Business intelligence and visualization**: Tableau and Looker, with demand counts of 230 and 49 and salaries near $99,288 and $103,795, underline the growing need for effective visualization and insight delivery.

- **Database technologies**: Continued demand for Oracle, SQL Server and NoSQL systems, with salaries between $97,786 and $104,534, highlights the ongoing value of database management and data engineering fundamentals.

| **Skill ID** | **Skill**    | **Demand Count** | **Average Salary ($)** |
|--------------|--------------|------------------|-------------------------|
| 8            | go           | 27               | 115,320                 |
| 234          | confluence   | 11               | 114,210                 |
| 97           | hadoop       | 22               | 113,193                 |
| 80           | snowflake    | 37               | 112,948                 |
| 74           | azure        | 34               | 111,225                 |
| 77           | bigquery     | 13               | 109,654                 |
| 76           | aws          | 32               | 108,317                 |
| 4            | java         | 17               | 106,906                 |
| 194          | ssis         | 12               | 106,683                 |
| 233          | jira         | 20               | 104,918                 |

*Table of the most optimal skills for data analyst sorted by salary*
# What I Learned
Throughout this project, I strengthened my SQL skills with a solid set of enhancements:

- 🧩 **Advanced Query Building**: Learned to handle complex joins, structure queries efficiently and use WITH clauses to create temporary result sets with precision.
- 📊 **Data Aggregation**: Became proficient with GROUP BY and used functions like COUNT() and AVG() to generate clear, meaningful summaries.
- 💡 **Analytical Insight**: Improved my ability to break down real-world problems and translate them into focused, effective SQL queries.
# Conclusions
### Insights

From the analysis, several key observations stood out:

- 💼 Top-Paying Data Analyst Roles: Remote-friendly positions show a wide salary range, with the highest reaching an impressive $650,000.
- 🧠 Skills Behind High Salaries: Advanced SQL proficiency is a common requirement in top-paying roles, reinforcing its importance for analysts aiming for higher compensation.
- 📈 Most In-Demand Skills: SQL leads the market in demand, making it a must-have skill for anyone entering the field.
- 💸 Skills Linked to Higher Salaries: Niche technologies like SVN and Solidity command higher averages, showing that specialized expertise often brings a salary premium.
- 🎯 Optimal Skills for Market Value: SQL delivers both high demand and strong earning potential, making it one of the most strategic skills to master.

### Closing Thoughts

This project sharpened my SQL capabilities and offered a clearer understanding of the data analyst job landscape. The insights gained help prioritize which skills matter most for career growth and job search success. By focusing on high-demand, high-paying skills, aspiring analysts can position themselves more competitively. This analysis underscores the value of ongoing learning and staying aligned with evolving trends in data analytics.