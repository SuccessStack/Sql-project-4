# 🎌 Anime Data Analysis | MS-SQL Project

Welcome to the **Anime Data Analysis** project! This project uses SQL to explore an anime dataset with the goal of uncovering key trends in popularity, scoring, release timelines, and viewer engagement. It provides actionable insights for anime producers, fans, and data professionals interested in entertainment analytics.

---

## 🎯 Project Objective

The goal of this project is to extract insights from anime metadata to understand factors that influence anime popularity and ratings. Key questions addressed include:

- What are the highest-rated and most popular anime titles?
- When are the most animes released (monthly/yearly)?
- How does audience engagement relate to anime scores?
- Which animes have the most members and longest runtimes?

---

## 📁 Dataset Overview

The dataset contains detailed information on anime titles, including their release types, scores, popularity (member count), and duration.

| Column       | Description                                | Data Type      |
|--------------|--------------------------------------------|----------------|
| `anime_name` | Title of the anime                         | VARCHAR(255)   |
| `episodes`   | Type of anime (TV, Movie, etc.)            | VARCHAR(50)    |
| `duration`   | Release time/date or episode duration      | VARCHAR(50)    |
| `members`    | Number of users who rated/watched the anime| VARCHAR(50)    |
| `score`      | Average user score                         | FLOAT          |

---

## 🧠 Methodology

1. **Data Import**
   - Imported CSV dataset into a relational database (SQL Server/MySQL).

2. **Data Cleaning**
   - Converted `members` and `duration` into usable numeric or date formats.
   - Removed null or invalid score entries.

3. **Query Development**
   - Created a two-tier analysis: basic and advanced queries to explore different facets of the dataset.

4. **Interpretation**
   - Highlighted top performers, averages, distributions, and monthly trends.

---

## 🔎 SQL Analysis List

### ✅ Basic Queries

1. List all anime names and their scores  
2. Count the total number of animes  
3. List anime names and members for top 10 most popular animes  
4. Find the average score of all animes  
5. Get the anime with the highest score  
6. List animes released in a specific year (e.g., 2020)  
7. Find the total number of members  
8. List anime names and scores above a specific rating (e.g., 8.5)  
9. List anime names and their duration  
10. List the top 10 animes with the least number of members  

---

### 🚀 Advanced Queries

1. Average score of animes by months  
2. Number of animes released each month  
3. Animes with more than 1 million members  
4. Top 5 longest running animes (by number of episodes)  
5. Top 10 most recently released animes  
6. Average number of members per anime  
7. Count of animes scored above and below 8.0  

---

## 🛠 Tools & Technologies

- **SQL** (MSSQL)
- **CSV Dataset** – Source data file  
- **DB Tools** – e.g.,SQL Server Management Studio (SSMS)

---
