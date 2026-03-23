WITH RankedOrders AS (
  -- Rank the orders for each seller
  SELECT 
    o.seller_id,
    i.item_brand as sell_brand,
    RANK() OVER (PARTITION BY o.seller_id ORDER BY o.order_date ASC) as rnk
  FROM orders o
  INNER JOIN items i ON o.item_id = i.item_id 
)

SELECT 
  u.user_id AS seller_id,
  CASE 
    -- Check if the brand of their 2nd order matches their favorite brand
    WHEN ro.sell_brand = u.favorite_brand THEN 'Yes'
    ELSE 'No' 
  END AS item_fav_brand
FROM users u
-- Left join so we keep users who have 0 or 1 orders (they will get 'No')
LEFT JOIN RankedOrders ro 
  ON u.user_id = ro.seller_id AND ro.rnk = 2;