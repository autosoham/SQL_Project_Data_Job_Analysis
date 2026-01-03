UPDATE job_applied              -- update the table contents.
SET contact='Erlich Bachman'    -- setting the value of entry of contact column 
WHERE job_id=1;                 -- specifying where the chnage needs to be done.

UPDATE job_applied
SET contact='Dinesh Chugtai'
WHERE job_id=2;

UPDATE job_applied
SET contact='Bertam Gilfoyle'
WHERE job_id=3;

UPDATE job_applied
SET contact='Jian Yang'
WHERE job_id=4;

UPDATE job_applied
SET contact='Big Head'
WHERE job_id=5;

SELECT * FROM job_applied