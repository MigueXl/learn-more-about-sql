
WITH RECURSIVE r_cte(dates, max_date) AS (

    SELECT MIN(period_start) AS dates, MAX(period_end) AS max_date

    FROM sales



    UNION ALL



    SELECT DATE(dates, '+1 day'), max_date

    FROM r_cte

    WHERE dates < max_date

)



SELECT

    s.product_id,

    STRFTIME('%Y', r.dates) AS report_year,

    SUM(s.average_daily_sales) AS total_amount

FROM r_cte r

JOIN sales s

    ON r.dates BETWEEN s.period_start AND s.period_end

GROUP BY s.product_id, STRFTIME('%Y', r.dates)

ORDER BY s.product_id, STRFTIME('%Y', r.dates);