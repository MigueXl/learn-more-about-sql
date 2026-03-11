select 
manager_id,
AVG(salary) as avg_salary
from emp
WHERE salary > 5000
GROUP BY manager_id
HAVING AVG(salary) > 10000;