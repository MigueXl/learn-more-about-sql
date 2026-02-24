WITH costumer_min_date AS (
  SELECT 
  customer_id, 
  MIN(order_date) as first_date
  FROM customer_orders
  GROUP BY customer_id
),
count_costumers AS (
  SELECT 
  first_date,
  COUNT(customer_id) as new_costumers 
  FROM costumer_min_date
  GROUP BY first_date
),
every_day_table AS (
  SELECT
    order_date,
    COUNT(customer_id) AS every_customers
  FROM customer_orders 
  GROUP BY 
    order_date
),
final_table AS(
  SELECT
  e.order_date,
  c.new_costumers,
  (e.every_customers - c.new_costumers) as repeated_costumers
  FROM every_day_table e
  LEFT JOIN count_costumers c
  ON e.order_date = c.first_date
)


select * from final_table;
