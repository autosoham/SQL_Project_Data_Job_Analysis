ALTER TABLE job_applied                    -- altering the contents of the table.
ADD contact VARCHAR(50);                   -- adding a new column to the table.

SELECT * FROM job_applied ;

ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name ;     -- renaming the column name 'contact' to 'contact_name'

SELECT * FROM job_applied;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;         -- chnaging the datatype of a column

ALTER TABLE job_applied
DROP COLUMN contact_name;                    -- deleting a column .