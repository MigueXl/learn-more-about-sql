with product_sales_table as (
    select 
    product_id,
    sum(sales) as product_sales
    from orders
    group by product_id
    order by product_sales desc
), 
cumsum_table as (
    select 
    *,
    SUM(product_sales) OVER (ORDER BY product_sales desc) AS running_sales,
    0.8*SUM(product_sales) OVER() as total_sales
    from product_sales_table
)


select * 
from cumsum_table 
where running_sales <= total_sales;