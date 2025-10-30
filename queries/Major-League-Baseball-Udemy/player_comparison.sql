-- PART IV: PLAYER COMPARISON ANALYSIS
-- 1. View the players table

SELECT * FROM `major_league_baseball_project.players`
LIMIT 5;

-- 2. Which players have the same birthday?

WITH birthdays AS (SELECT p.nameGiven, p.birthYear, p.birthMonth, p.birthDay, CAST(concat(p.birthYear,"-", p.birthMonth,"-", p.birthDay) AS DATE)AS bday FROM `major_league_baseball_project.players` p)

SELECT birthdays.bday, STRING_AGG(birthdays.nameGiven) AS common_bdays FROM birthdays
WHERE bday is NOT NULL
GROUP BY birthdays.bday;

-- 3. Create a summary table that shows for each team, what percent of players bat right, left and both
with final AS (with pvt AS (with batters AS (SELECT s.teamID, p.playerID, p.bats 
FROM `major_league_baseball_project.players` p
JOIN `major_league_baseball_project.salaries` s
ON p.playerID = s.playerID
WHERE p.bats is not null)

SELECT COUNT(b.playerID) as cnt, b.bats,b.teamID,
FROM batters b
GROUP BY b.teamID, b.bats
ORDER BY b.teamID)

SELECT *,
CASE WHEN pvt.bats = "L" THEN pvt.cnt ELSE 0 END AS pvt_left,
CASE WHEN pvt.bats = "R" THEN pvt.cnt ELSE 0 END AS pvt_right,
CASE WHEN pvt.bats = "B" THEN pvt.cnt ELSE 0 END AS pvt_both
FROM pvt)

SELECT teamID, ROUND(SUM(pvt_left)/(SUM(pvt_left)+SUM(pvt_right)+SUM(pvt_both))*100) as left_batter,
ROUND(SUM(pvt_right)/(SUM(pvt_left)+SUM(pvt_right)+SUM(pvt_both))*100) as right_batter, 
ROUND(SUM(pvt_both)/(SUM(pvt_left)+SUM(pvt_right)+SUM(pvt_both))*100) as both_batter FROM final
GROUP BY teamID;


--- THIS SOLUTION IS DEFINITELY A LONGER ROUTE. When you can pivot things earlier and agrreagte them it will save a lot of processing time so do it.



-- 4. How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference?
-- Trend analysis of average height and weight.
-- Need to create average height across years
-- First thing is to extract year from debut as debut year (might need to cast as date and then extract)
-- Next find average across decades using average and group by
-- Then find the decade over decade difference. Lag function will be used.

WITH dec AS
(WITH year AS (SELECT *, EXTRACT(YEAR FROM CAST(p.debut AS date)) AS debut_year,
from `major_league_baseball_project.players` p)
SELECT *,(FLOOR(year.debut_year / 10)) * 10 AS decade,
FROM year
WHERE year.debut_year IS NOT NULL)
SELECT dec.decade,
ROUND(AVG(height),2) - LAG(ROUND(AVG(height),2)) OVER(ORDER BY dec.decade ASC) AS height_diff,
ROUND(AVG(weight),2) - LAG(ROUND(AVG(weight),2)) OVER(ORDER BY dec.decade ASC) AS weight_diff,
FROM dec
GROUP BY dec.decade 
ORDER BY dec.decade ASC;
