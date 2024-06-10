CREATE DATABASE ShopeeTest;
use shopeetest;

-- 1. Write an SQL statement to find the first and latest order date of each buyer in each shop (5 marks)	
SELECT shopid, buyerid,
  MIN(order_time) AS first_order_date,
  MAX(order_time) AS latest_order_date
FROM shopeetest.order_tab
GROUP BY 1, 2
ORDER BY 1, 2;


-- 2. Write an SQL statement to find buyer that make more than 1 order in 1 month (10 marks)	
with buyer_order as (
  SELECT 
    buyerid, 
    COUNT(DISTINCT orderid)/COUNT(DISTINCT DATE_FORMAT(order_time, '%Y-%m-%d')) AS order_per_month
FROM order_tab
GROUP BY 1
)

SELECT * FROM buyer_order
WHERE buyer_order.order_per_month > 1
ORDER BY 2 DESC;





-- 3) Write an SQL statement to find the first buyer of each shop (10 marks)	
WITH shop_first_order AS (
  SELECT 
    shopid,
    MIN(orderid) AS min_order_id
  FROM order_tab
GROUP BY 1
ORDER BY 1)

SELECT 
  order_tab.shopid,
  buyerid
FROM shop_first_order as sfo
LEFT JOIN order_tab 
ON order_tab.shopid = sfo.shopid AND order_tab.orderid = sfo.min_order_id
ORDER BY 1;

-- 4) Write an SQL statement to find the TOP 10 Buyer by GMV in Country ID & SG (15 marks)	
WITH buyer_id AS(
SELECT 
  user_tab.country,
  user_tab.buyerid,
  SUM(order_tab.gmv) AS sum_gmv
  FROM order_tab
  LEFT JOIN user_tab
  ON order_tab.buyerid = user_tab.buyerid
  WHERE user_tab.country IN ('ID')
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10),
buyer_sg AS(
SELECT 
  user_tab.country,
  user_tab.buyerid,
  SUM(order_tab.gmv) AS sum_gmv
FROM order_tab
LEFT JOIN user_tab
ON order_tab.buyerid = user_tab.buyerid
WHERE user_tab.country IN ('SG')
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10)

SELECT * FROM buyer_id UNION ALL SELECT * FROM buyer_sg;



-- 5) Write an SQL statement to find number of buyer of each country that purchased item with even and odd itemid number (20 marks)	
SELECT 
  user_tab.country,
  CASE
    WHEN MOD(order_tab.itemid,2) = 0 THEN 'Even'
    ELSE 'Odd'
  END AS item_id_number
FROM order_tab
LEFT JOIN user_tab
ON order_tab.buyerid = user_tab.buyerid
GROUP BY 1, 2
ORDER BY 1, 2;


-- 6) Write an SQL statement to find the number of order/views & clicks/impressions of each shop (if possible make it in 1 query) (30 marks)	
SELECT 
  performance_tab.shopid,
  COUNT(DISTINCT order_tab.orderid)/ROUND(SUM(performance_tab.Item_views),2) AS order_per_views,
  SUM(performance_tab.total_clicks)/ROUND(SUM(performance_tab.impressions),2) AS clicks_per_Impression
FROM `belajar-big-query-419815.ShopeeSQL.performance_tab` performance_tab
LEFT JOIN `belajar-big-query-419815.ShopeeSQL.order_tab` order_tab ON performance_tab.shopid = order_tab.shopid
GROUP BY 1
ORDER BY 1;

