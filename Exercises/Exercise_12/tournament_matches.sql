
create table players
(
player_id int,
group_id int
);

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int
);

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);


WITH player_score AS (
    SELECT 
        player_id, 
        SUM(score) AS total_score
    FROM (
        SELECT first_player AS player_id, first_score AS score FROM matches
        UNION ALL
        SELECT second_player AS player_id, second_score AS score FROM matches
    ) AS subquery
    GROUP BY player_id
), 
rank_players AS (
    SELECT 
        group_id,
        player_id,
        total_score as score
    FROM (
        SELECT 
            p.group_id,
            p.player_id,
            COALESCE(s.total_score, 0) AS total_score,
            RANK() OVER (
                PARTITION BY p.group_id 
                ORDER BY COALESCE(s.total_score, 0) DESC, p.player_id ASC
            ) AS players_ranking
        FROM players p
        LEFT JOIN player_score s ON p.player_id = s.player_id
    ) AS subquery
    WHERE players_ranking = 1
)

SELECT * FROM rank_players;
