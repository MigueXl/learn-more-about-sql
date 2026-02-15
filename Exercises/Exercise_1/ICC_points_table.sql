create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

-- UNION TEAM_1 AND TEAM 2 TO CREATE A ROW OF TEAMS
WITH combined_teams AS (
    SELECT Team_1 AS Team_Name FROM icc_world_cup
    UNION ALL
    SELECT Team_2 FROM icc_world_cup
), -- COUNT TEAMS (MATCHES PLAYED)
teams_matches AS (
  SELECT Team_Name, COUNT(Team_Name) AS Matches_played
  FROM combined_teams
  GROUP BY Team_Name
), -- COUNT WINS
wins AS (
  SELECT Winner, COUNT(Winner) AS no_of_wins
  FROM icc_world_cup
  GROUP BY Winner
), -- JOIN MATCHES PLAYED AND WINS BY TEAM
joined_table AS (
  SELECT 
    t.Team_Name, 
    t.Matches_played, 
    -- REPLACE NULL BY THE VALUE INTRODUCED
    COALESCE(w.no_of_wins, 0) AS no_of_wins,
    (t.Matches_played -  COALESCE(w.no_of_wins, 0)) AS no_of_losses
  FROM teams_matches t
  LEFT JOIN wins w ON w.Winner = t.Team_Name
)


SELECT * FROM joined_table; -- You must end with a SELECT to see the data!