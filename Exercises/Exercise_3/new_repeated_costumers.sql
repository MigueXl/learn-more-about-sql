create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);


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
