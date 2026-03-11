WITH client_unbanned as (
  select 
  t.*
  from trips t
  LEFT JOIN users u
  ON t.client_id = u.users_id
  WHERE u.banned = 'No'
), everyone_unbanned as (
  select 
  t.*
  from client_unbanned t
  LEFT JOIN users u
  ON t.driver_id  = u.users_id
  WHERE u.banned = 'No'
), count_user as (
  select 
  request_at,
  COUNT(1) as total_trips
  from everyone_unbanned
  GROUP BY request_at 
), cancelled as (
  select 
  request_at,
  COUNT(1) as cancelled_trip_count
  from everyone_unbanned
  WHERE status != 'completed'
  GROUP BY request_at 
), final_table as (
  select 
  c.request_at,
  COALESCE(u.cancelled_trip_count, 0) as cancelled_trip_count,
  c.total_trips,
  (COALESCE(u.cancelled_trip_count, 0) * 1.0 /c.total_trips)*100 as cancelled_percent
  from count_user c
  LEFT JOIN cancelled u
  ON c.request_at = u.request_at 
)


select * from final_table;