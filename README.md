# MLB-player-career-analysis

Title :  ⚾ Major League Baseball Player Career Analytics Project

### 🎯 Objective
Analyze MLB player career stats, salaries, origins, and trends using **BigQuery** and visualize insights in **Tableau**.

---

### Description
This project leverages **SQL** within the **Google BigQuery environment** and **Tableau** for visualization to analyze MLB player career data, salaries, and origins. The analysis focuses on identifying which schools have consistently produced professional players over the decades, examining how team spending patterns relate to player types, performance, and career longevity. Using advanced SQL queries, the project explores key trends in player development, salary distributions, and team composition. The findings are then visualized through interactive Tableau dashboards, enabling intuitive exploration and data-driven storytelling for deeper insights into the dynamics of Major League Baseball. 

---

### 🧩 Tech Stack
- **Data Source:** MLB Players dataset (Udemy)
- **Data Storage Environment:** Google Cloud Storage
- **Database:** Google BigQuery
- **Language:** SQL
- **Visualization:** Tableau Public
- **Documentation:** Notion

---

### 🧠 Key Analytical Goals
1. Demonstrate analytical capabilities of Google Cloud Platform to store, connect and analyze data. 
2. Clean and structure player data from multiple sources and analyze to find key insights.

-- PART I: SCHOOL ANALYSIS
1. In each decade, how many schools were there that produced players?
2. What are the names of the top 5 schools that produced the most players?
3. For each decade, what were the names of the top 3 schools that produced the most players?

-- PART II: SALARY ANALYSIS
1. Find the top 20% of teams in terms of average annual spending
2. For each team, show the cumulative sum of spending over the years
3. Return the first year that each team's cumulative spending surpassed 1 billion.

-- PART III: PLAYER CAREER ANALYSIS
1. For each player, calculate their age at their first game, their last game, and their career length (all in years). Sort from longest career to shortest career.
2. What team did each player play on for their starting and ending years?
3. How many players started and ended on the same team and also played for over a decade?

-- PART IV: PLAYER COMPARISON ANALYSIS
1. Which players have the same birthday?
2. Create a summary table that shows for each team, what percent of players bat right, left and both
3. How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference?

---

### 📊 Dashboards
<img width="1830" height="1412" alt="image" src="https://github.com/user-attachments/assets/503cec6e-6225-440b-a77b-9be6ab493dbe" />

Team Expenditure and Player Career Analysis

<img width="1280" height="908" alt="image" src="https://github.com/user-attachments/assets/1e23f1ed-f8fa-47e4-999c-358595313b88" />

---

### 📁 Project Structure
| Folder | Description |
|---------|-------------|
| `queries/` | All BigQuery SQL scripts used for data cleaning and analysis |
| `results.md/` | Tableau dashboard images|
| `schema/` | Data dictionary or schema overview |

---

### 🔍 Key Insights 
- Number of schools producing players has gone up signficantly over the years  
- Schools like University of Southern California, Arizona State University, and Stanford University have consistently produced the most players across the years
- Top 20%ile teams have an minimum average annual spend of $2.5M with the maximum spend crossing $5M
- Average debut age for a player is 24 years, average retriement age is 29 years, and average career length is ~5 years
- Only 26 out of 18,589 players started and ended their careers on the same team and played for over a decade
- Over 50% of the batters on most teams prefer to bat right handed
- Players heights and weights have consistently gone up over the years with the biggest jump in the decades of 1930 & 1940

---

### 🧭 Navigation
For storytelling and detailed breakdown, visit the **Notion project page:**  
👉 [View on Notion](https://your-notion-link)

---

### 🧑‍💻 Author
**Nigam Wadhwa**  
📧 nigam.wadhwa@gatech.edu  
🔗 [LinkedIn](https://linkedin.com/in/nigam-wadhwa)
