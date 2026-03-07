Create table friend (pid int, fid int);
insert into friend (pid , fid ) values ('1','2');
insert into friend (pid , fid ) values ('1','3');
insert into friend (pid , fid ) values ('2','1');
insert into friend (pid , fid ) values ('2','3');
insert into friend (pid , fid ) values ('3','5');
insert into friend (pid , fid ) values ('4','2');
insert into friend (pid , fid ) values ('4','3');
insert into friend (pid , fid ) values ('4','5');

create table person (PersonID int,	Name varchar(50),	Score int);
insert into person(PersonID,Name ,Score) values('1','Alice','88');
insert into person(PersonID,Name ,Score) values('2','Bob','11');
insert into person(PersonID,Name ,Score) values('3','Devis','27');
insert into person(PersonID,Name ,Score) values('4','Tara','45');
insert into person(PersonID,Name ,Score) values('5','John','63');

WITH friends_score AS (
  SELECT
    f.pid,
    f.fid,
    p.score
  FROM friend f
  INNER JOIN person p ON f.fid = p.PersonID 
), 
pid_name AS (
  SELECT
    p.PersonID,
    p.Name -- Removed trailing comma here
  FROM person p
) -- Added missing comma here
SELECT
  f.pid AS pid,
  SUM(f.score) AS total_friend_score,
  COUNT(f.fid) AS no_of_friends, -- Changed to fid to count actual friends
  n.Name AS person_name
  
FROM friends_score f
INNER JOIN pid_name n ON f.pid = n.PersonID -- Join happens BEFORE Group By
GROUP BY f.pid, n.Name
HAVING SUM(f.score) > 100;