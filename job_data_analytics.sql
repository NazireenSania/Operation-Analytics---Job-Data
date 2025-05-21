create database project;


create table `job_data` (
ds DATE ,
`job_id` INT,
`actor_id` INT,
`event`char (20),
`language` char(20),
`time_spent` INT,
org CHAR(2)
);


SHOW VARIABLES LIKE 'secure_file_priv';

set global local_infile =1; 

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\job_data.csv'
into table `job_data`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(`ds`,`job_id`,`actor_id`,`event`,`language`,`time_spent`,`org`);

select count(*) from job_data;




----------------------------------------------------------------------------------------------------------------------------------

# Calculate the number of jobs reviewed per hour for each day in November 2020#

SELECT 
    ds, 
    HOUR(TIMESTAMP(ds)) AS hour_of_day, 
    COUNT(job_id) AS jobs_reviewed
FROM job_data
WHERE ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY ds, hour_of_day
ORDER BY ds, hour_of_day;

-----------------------------------------------------------------------------------------------------------------------------------


#Calculate the 7-day rolling average of throughput (number of events per second).#

WITH daily_throughput AS (
    SELECT 
        ds, 
        SUM(time_spent) AS total_time_spent, 
        COUNT(*) AS total_events
    FROM job_data
    GROUP BY ds
)
SELECT 
    d1.ds,
    SUM(d2.total_events) / NULLIF(SUM(d2.total_time_spent), 0) AS rolling_avg_throughput
FROM daily_throughput d1
JOIN daily_throughput d2 
    ON d1.ds BETWEEN DATE_SUB(d2.ds, INTERVAL 6 DAY) AND d2.ds
GROUP BY d1.ds
ORDER BY d1.ds;

--------------------------------------------------------------------------------------------------


#Calculate the percentage share of each language in the last 30 days.#

WITH each_language AS (
    SELECT 
        `language`,
        COUNT(*) AS language_count
    FROM job_data
    GROUP BY `language`
)
SELECT 
    `language`,
    language_count,
    (language_count * 100.0 / SUM(language_count) OVER()) AS percentage_share
FROM each_language
ORDER BY percentage_share DESC;


-----------------------------------------------------------------------------------------------------------------------------


#(D) Identify duplicate rows in the data.#

SELECT 
    job_id, actor_id, event, language, time_spent, org, ds, 
    COUNT(*) AS duplicate_count
FROM job_data
GROUP BY job_id, actor_id, event, language, time_spent, org, ds
HAVING COUNT(*) > 1;
