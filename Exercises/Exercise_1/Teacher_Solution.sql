select team_name, COUNT(1) as no_of_matches_played, SUM(win_flag) as no_of_matches_won, (COUNT(1) - SUM(win_flag)) as no_of_losses
from (
select Team_1 as team_name, case when Team_1=Winner then 1 else 0 end as win_flag
from icc_world_cup
union all
select Team_2 as team_name, case when Team_2=Winner then 1 else 0 end as win_flag
from icc_world_cup
) A
group by team_name
order by no_of_matches_won desc