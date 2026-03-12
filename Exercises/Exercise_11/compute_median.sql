WITH ordered_salaries AS (
  SELECT 
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary) AS rn,
    COUNT(*) OVER (PARTITION BY department_id) AS cnt
  FROM emp
)
SELECT 
    department_id,
    AVG(salary) AS median_salary
FROM ordered_salaries
WHERE rn IN ( (cnt + 1) / 2, (cnt + 2) / 2 )   -- handles odd/even counts
GROUP BY department_id;