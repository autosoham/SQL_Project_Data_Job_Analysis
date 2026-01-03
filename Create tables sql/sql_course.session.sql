CREATE TABLE job_applied (            -- creating the table.
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN , 
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)                  -- setting the column names with their datatypes.
);

SELECT * 
FROM job_applied ;             -- querying the whole contents of the table.