-- PART I: SCHOOL ANALYSIS
-- 1. View the schools and school details tables
select * from `major_league_baseball_project.schools`;
-- Player ID and School ID columns
select * from `major_league_baseball_project.school_details`;
-- School ID and location columns

-- 2. In each decade, how many schools were there that produced players?

WITH dec AS (select *,
floor(yearID/10)*10 as decade_start 
 from `major_league_baseball_project.schools`)
SELECT COUNT(DISTINCT schoolID) AS num_schools, dec.decade_start FROM dec
GROUP BY dec.decade_start
ORDER BY dec.decade_start ASC ;


-- 3. What are the names of the top 5 schools that produced the most players?
With top5 AS (select COUNT(playerID) as num_players, schoolID from `major_league_baseball_project.schools`
GROUP BY schoolID
ORDER BY num_players DESC
LIMIT 5)

SELECT top5.schoolID, university FROM top5
JOIN `major_league_baseball_project.school_details` sch
ON top5.schoolID = sch.schoolID;

-- 4. For each decade, what were the names of the top 3 schools that produced the most players?
-- This solution takes a lot of things in picture, it breaks down and creates different windows, then ranks univerisities by number of players, and finally filters them based on rank

WITH summary AS (WITH dec AS (select *,
CAST(floor(yearID/10)*10 as INT) AS decade_start
from `major_league_baseball_project.schools`)

select COUNT(playerID) AS num_players,schoolID,dec.decade_start,
ROW_NUMBER() OVER(PARTITION BY dec.decade_start ORDER BY COUNT(playerID) DESC) AS player_rank
FROM dec
GROUP BY schoolID, dec.decade_start)

SELECT summary.num_players, summary.schoolID, summary.decade_start,sch.university 
FROM summary
JOIN `major_league_baseball_project.school_details` sch
ON summary.schoolID = sch.schoolID
WHERE summary.player_rank <= 3
ORDER BY summary.decade_start, summary.num_players DESC;

