create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries;

with ranked_floor as (
  select 
  name, 
  floor, 
  count(1) as number_visits_floor,
  rank() over (partition by name order by count(1) desc) as rnk
  from entries
  group by name, floor
), count_visits as (
  select
  name,
  COUNT(1) as total_visits,
  group_concat(distinct(resources)) as resources_used
  from entries
  group by name
),
final_table as (
  select 
  cv.name,
  cv.total_visits,
  r.floor as most_visited_floor,
  cv.resources_used
  from count_visits cv
  INNER JOIN ranked_floor r
  ON cv.name = r.name
  WHERE r.rnk = 1
)


select * from final_table;