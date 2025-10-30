-- PART II: SALARY ANALYSIS
-- 1. View the salaries table
SELECT * FROM `major_league_baseball_project.salaries`
LIMIT 10;

-- 2. Return the top 20% of teams in terms of average annual spending
WITH average_spend AS (SELECT teamID, AVG(SALARY) AS average_salary,
NTILE(5) OVER(ORDER BY AVG(SALARY) DESC) AS top5
FROM `major_league_baseball_project.salaries`
GROUP BY teamID)

SELECT * FROM average_spend
WHERE average_spend.top5 = 1;

-- 3. For each team, show the cumulative sum of spending over the years
SELECT s.teamID, SUM(s.salary) AS cum_spend
FROM `major_league_baseball_project.salaries` s
GROUP BY s.teamID;

-- 4. Return the first year that each team's cumulative spending surpassed 1 billion. 
--QUERY exaplanation table by table

-- creating a base table aggregated spend over an year for team
SELECT s.teamID, s.yearID, SUM(s.salary) AS cum_spend
FROM `major_league_baseball_project.salaries` s
GROUP BY s.yearID, s.teamID;

-- creating a rolling sum broken down by years per team using window functions
WITH agg AS(SELECT s.teamID, s.yearID, SUM(s.salary) AS cum_spend
FROM `major_league_baseball_project.salaries` s
GROUP BY s.yearID, s.teamID)

SELECT *,
SUM(agg.cum_spend) OVER(PARTITION BY agg.teamID ORDER BY agg.yearID) AS cum_over_the_years,
FROM agg;

-- Now we need to add a where clause that will rank cumulative over the years spend when > 1 billion
WITH ranked_cumulative AS (WITH over_years AS(WITH agg AS(SELECT s.teamID, s.yearID, SUM(s.salary) AS cum_spend
FROM `major_league_baseball_project.salaries` s
GROUP BY s.yearID, s.teamID)

SELECT *,
SUM(agg.cum_spend) OVER(PARTITION BY agg.teamID ORDER BY agg.yearID) AS cum_over_the_years,
FROM agg)

SELECT over_years.teamID, over_years.yearID, over_years.cum_over_the_years,
ROW_NUMBER() OVER(PARTITION BY over_years.teamID ORDER BY over_years.yearID) AS rank_spend
FROM over_years
WHERE over_years.cum_over_the_years > 1000000000)

SELECT ranked_cumulative.teamID, ranked_cumulative.yearID,ranked_cumulative.cum_over_the_years 
FROM ranked_cumulative
WHERE ranked_cumulative.rank_spend = 1;

