CREATE DATABASE anime;

USE anime;


select * from Anime_lists;

-- -------------------------------------------------------------------
-- ---------------------------Basic Queries---------------------------
-- -------------------------------------------------------------------

-- List all Anime Names and their Scores:
SELECT Anime_name, Score
FROM Anime_lists;

-- Count the Total Number of Animes:
SELECT COUNT(*) AS total_animes
FROM Anime_lists;

-- List Anime Names and Members for Top 10 Most Popular Animes:
WITH RankedAnime AS (
    SELECT 
        Anime_name,
        CAST(REPLACE(REPLACE(members, ' members', ''), ',', '') AS BIGINT) AS members_cleaned,
        ROW_NUMBER() OVER (PARTITION BY Anime_name ORDER BY CAST(REPLACE(REPLACE(members, ' members', ''), ',', '') AS BIGINT) DESC) AS rn
    FROM 
        Anime_lists
)
SELECT 
    Anime_name,
    members_cleaned AS members
FROM 
    RankedAnime
WHERE 
    rn = 1
ORDER BY 
    members_cleaned DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- Find the Average Score of All Animes:
SELECT AVG(Score) AS avg_score
FROM Anime_lists;

-- Get the Anime with the Highest Score:
SELECT Anime_name, Score
FROM Anime_lists
ORDER BY Score DESC;

-- List Animes Released in a Specific Year (e.g., 2020):
SELECT Anime_name, duration
FROM Anime_lists
WHERE duration LIKE '%2020%';

-- Find the Total Number of Members:
SELECT SUM(CAST(REPLACE(REPLACE(members, ' members', ''), ',', '') AS BIGINT)) AS total_members
FROM Anime_lists;

-- List Anime Names and Scores Above a Specific Rating (e.g., 8.5):
SELECT Anime_name, Score
FROM Anime_lists
WHERE Score > 8.5;

-- List Anime Names and Their Duration:
SELECT Anime_name, duration
FROM Anime_lists;

-- List the Top 10 Animes with the Least Number of Members:
WITH RankedAnime AS (
    SELECT 
        Anime_name,
        CAST(REPLACE(REPLACE(members, ' members', ''), ',', '') AS BIGINT) AS members_cleaned,
        ROW_NUMBER() OVER (PARTITION BY Anime_name ORDER BY CAST(REPLACE(REPLACE(members, ' members', ''), ',', '') AS BIGINT) ASC) AS rn
    FROM 
        Anime_lists
)
SELECT 
    Anime_name,
    members_cleaned AS members
FROM 
    RankedAnime
WHERE 
    rn = 1
ORDER BY 
    members_cleaned ASC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


-- ----------------------------------------------------
-- -----------------Advanced Queries-------------------
-- ----------------------------------------------------

-- Average Score of Animes Months:
SELECT LEFT(duration, 3) + '0s' AS Months, AVG(Score) AS avg_score
FROM Anime_lists
GROUP BY LEFT(duration, 3)
ORDER BY LEFT(duration, 3);

-- Number of Animes Released Each Month:
SELECT LEFT(duration, 4) AS release_Month, COUNT(*) AS num_animes
FROM Anime_lists
GROUP BY LEFT(duration, 4)
ORDER BY release_Month;

-- Animes with More than 1 Million Members:
WITH RankedAnimes AS (
    SELECT 
        Anime_name,
        CAST(REPLACE(REPLACE(REPLACE(members, ' members', ''), ',', ''), ' ', '') AS INT) AS CleanedMembers,
        Score,
        ROW_NUMBER() OVER (PARTITION BY Anime_name ORDER BY CAST(REPLACE(REPLACE(REPLACE(members, ' members', ''), ',', ''), ' ', '') AS INT) DESC) AS rn
    FROM Anime_lists
    WHERE CAST(REPLACE(REPLACE(REPLACE(members, ' members', ''), ',', ''), ' ', '') AS INT) > 1000000
)
SELECT 
    Anime_name,
    CleanedMembers AS members,
    Score
FROM 
    RankedAnimes
WHERE 
    rn = 1;

-- Top 5 Longest Running Animes (by number of episodes):
WITH RankedAnimes AS (
    SELECT 
        Anime_name,
        TRY_CAST(REPLACE(
            SUBSTRING(
                episode, 
                CHARINDEX('(', episode) + 1, 
                CHARINDEX(' eps', episode) - CHARINDEX('(', episode) - 1
            ), 
            ' eps', ''
        ) AS INT) AS num_episodes,
        ROW_NUMBER() OVER (PARTITION BY Anime_name ORDER BY TRY_CAST(REPLACE(
            SUBSTRING(
                episode, 
                CHARINDEX('(', episode) + 1, 
                CHARINDEX(' eps', episode) - CHARINDEX('(', episode) - 1
            ), 
            ' eps', ''
        ) AS INT) DESC) AS rn
    FROM Anime_lists
    WHERE 
        TRY_CAST(REPLACE(
            SUBSTRING(
                episode, 
                CHARINDEX('(', episode) + 1, 
                CHARINDEX(' eps', episode) - CHARINDEX('(', episode) - 1
            ), 
            ' eps', ''
        ) AS INT) IS NOT NULL
)
SELECT TOP 5
    Anime_name, 
    num_episodes
FROM 
    RankedAnimes
WHERE 
    rn = 1
ORDER BY 
    num_episodes DESC;

-- Top 10 Most Recently Released Animes:
WITH RankedAnimes AS (
    SELECT 
        Anime_name, 
        duration,
        ROW_NUMBER() OVER (PARTITION BY Anime_name ORDER BY duration DESC) AS rn
    FROM Anime_lists
)
SELECT TOP 10
    Anime_name, 
    duration
FROM RankedAnimes
WHERE rn = 1
ORDER BY duration DESC;

-- Average Number of Members per Anime:
SELECT AVG(CAST(REPLACE(REPLACE(ISNULL(members, '0'), ' members', ''), ',', '') AS DECIMAL(18, 2))) AS avg_members
FROM Anime_lists;

-- Count of Animes Scored Above and Below 8.0:
SELECT 
  COUNT(CASE WHEN Score > 8.0 THEN 1 END) AS above_8,
  COUNT(CASE WHEN Score <= 8.0 THEN 1 END) AS below_8
FROM Anime_lists;

-- Total Number of Episodes for Animes with Scores Above 9.0:
SELECT SUM(CAST(REPLACE(SUBSTRING(episode, CHARINDEX('(', episode) + 1, CHARINDEX(' eps', episode) - CHARINDEX('(', episode) - 1), ' eps', '') AS INTEGER)) AS total_episodes
FROM Anime_lists
WHERE Score > 9.0;











