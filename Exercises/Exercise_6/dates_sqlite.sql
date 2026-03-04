SELECT DATE(

           today_date,

           CASE

               WHEN strftime('%w', today_date) = '0'

                   THEN (7 * 1)  -- today is Sunday → skip to next Sunday (7 days later)

               ELSE (7 - strftime('%w', today_date))  -- move to coming Sunday

           END || ' days',

           ((n - 1) * 7) || ' days'

       ) AS sunday_3

FROM input_date;