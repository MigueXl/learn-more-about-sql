select 
e.emp_id,
e.emp_name,
e.salary,
s.emp_name as manager_name,
s.salary as manager_salary
from emp e
inner join emp s 
on e.manager_id = s.emp_id
where e.salary > s.salary 