-- PART III: PLAYER CAREER ANALYSIS
-- 1. View the players table and find the number of players in the table
SELECT * FROM `major_league_baseball_project.players`
LIMIT 10;

SELECT DISTINCT COUNT(playerID) FROM `major_league_baseball_project.players`;
-- THERE are 18589 players in total, each player ID is unique

-- 2. For each player, calculate their age at their first game, their last game, and their career length (all in years). Sort from longest career to shortest career. {needs knowledge of date time functions - need to build this again}

-- Need to clean the date since date in debut is messed up in terms of format

-- TO calculate the age of a player at first game, we need to know the DOB. SINCE DOB is split in 3 fields we need to create a field that will have the date cast as a date function.
-- Now our debut and final game fields are also strings. we will need to cast them as dates and then perform rest of the calculations using date functions.

WITH dates AS(SELECT playerID, nameGiven, 
CAST(CONCAT(p.birthYear,"-",p.birthMonth,"-",p.birthDay) AS date) AS player_birthday,
CAST(debut AS date) AS debut_date,
CAST(finalGame AS date) AS last_game FROM `major_league_baseball_project.players` p)

SELECT playerID, nameGiven,
DATE_DIFF(d.debut_date,d.player_birthday,YEAR) AS age_first_game,
DATE_DIFF(d.last_game,d.player_birthday,YEAR) AS age_last_game,
DATE_DIFF(d.last_game,d.debut_date,YEAR) AS career_length,
FROM dates d
WHERE d.player_birthday IS NOT NULL AND d.debut_date IS NOT NULL AND d.last_game IS NOT NULL
ORDER BY DATE_DIFF(d.last_game,d.debut_date,YEAR) DESC;

-- IN BQ DATEDIFF AUTOMATICALLY ACCOUNTS FOR YEARS BETWEEN TWO DATES


-- 3. What team did each player play on for their starting and ending years?
-- Since we are approaching this from a player perspective player table has to be our basic table 

SELECT p.playerID, p.nameGiven,
EXTRACT(YEAR FROM DATE(p.debut)) AS debut_year, s.teamID AS debut_team, EXTRACT(YEAR FROM DATE(p.finalGame)) AS last_year, e.teamID AS retirement_team
FROM `major_league_baseball_project.players` p
JOIN `major_league_baseball_project.salaries` s
ON p.playerID = s.playerID AND EXTRACT(YEAR FROM DATE(p.debut)) = s.yearID
JOIN `major_league_baseball_project.salaries` e
ON p.playerID = e.playerID AND EXTRACT(YEAR FROM DATE(p.finalGame)) = e.yearID
WHERE s.teamID IS NOT NULL OR e.teamID IS NOT NULL;



-- 4. How many players started and ended on the same team and also played for over a decade?

WITH career_summary AS (SELECT p.playerID, p.nameGiven,
EXTRACT(YEAR FROM DATE(p.debut)) AS debut_year, s.teamID AS debut_team, EXTRACT(YEAR FROM DATE(p.finalGame)) AS last_year, e.teamID AS retirement_team
FROM `major_league_baseball_project.players` p
JOIN `major_league_baseball_project.salaries` s
ON p.playerID = s.playerID AND EXTRACT(YEAR FROM DATE(p.debut)) = s.yearID
JOIN `major_league_baseball_project.salaries` e
ON p.playerID = e.playerID AND EXTRACT(YEAR FROM DATE(p.finalGame)) = e.yearID
WHERE s.teamID IS NOT NULL OR e.teamID IS NOT NULL)

SELECT *,(cs.last_year - cs.debut_year) AS career_length
FROM career_summary cs 
WHERE cs.debut_team = cs.retirement_team
AND (cs.last_year - cs.debut_year) >= 10;
