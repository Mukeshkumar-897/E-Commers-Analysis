use projectdb;

select * from olist_orders_dataset;
select * from olist_orders_dataset1;
select * from olist_order_payments_dataset;

#############################################################################################################################

# KPI - 1 : Weekday vs Weekend Payments stats

SELECT 
  CASE 
    WHEN WEEKDAY(order_purchase_timestamp)= (0 or 6) THEN 'Weekend' 
    ELSE 'Weekday' 
  END AS day_type, 
  round(COUNT(*)) AS total_orders, 
  round(SUM(b.payment_value)) AS total_payments, 
  round(avg(b.payment_value)) AS avg_payment
FROM olist_orders_dataset1 a join olist_order_payments_dataset b on a.order_id = b.order_id
GROUP BY day_type;

select * from olist_order_reviews_dataset;

############################################################################################################

# KPI - 2: Number of Orders with review score 5 and payment type as credit card.​

SELECT COUNT(o.order_id) AS order_count
FROM olist_order_payments_dataset o
INNER JOIN olist_order_reviews_dataset r ON o.order_id = r.order_id
WHERE r.review_score = 5
AND o.payment_type = 'credit_card';

################################################################################################################################

select * from products_dataset; 
select * from olist_products_dataset;

-- SELECT t1.column1, t2.column2, t3.column3 FROM table1 t1 JOIN table2 t2 ON t1.column = t2.column JOIN table3 t3 ON t2.column = t3.column;

# KPI - 3: Avg. No of Shipping Days for Pet Shop

SELECT
  t3.product_category_name, avg(DATEDIFF(t1.order_delivered_customer_date, t1.order_purchase_timestamp)) AS avg_delivery_days
FROM
  olist_orders_dataset1 t1 
  JOIN olist_order_items_dataset t2 ON t1.ï»¿order_id = t2.ï»¿order_id 
  JOIN olist_products_dataset t3 ON t2.product_id = t3.ï»¿product_id
WHERE
  t3.product_category_name = 'pet_shop';
  
 ###################################################################################################################################
 
 
# KPI - 4: Average price and payment values from customers of sao paulo city​

select A.customer_city, round(AVG(D.price),2) AS avg_price, round(avg(C.payment_value),2) AS Avg_payment_value from
olist_customers_dataset A 
join olist_orders_dataset B on A.customer_id = B.customer_id 
join olist_order_payments_dataset C on B.order_id = C.order_id 
join order_items_dataset D on B.order_id = D.order_id
WHERE A.customer_city='sao paulo';

######################################################################################################################################

# KPI - 5: : Relationship between No. of shipping days vs Review Score

SELECT
  t2.review_score, avg(DATEDIFF(t1.order_delivered_customer_date, t1.order_purchase_timestamp )) AS avg_delivery_days
FROM olist_orders_dataset1 t1
JOIN olist_order_reviews_dataset t2 ON t1.ï»¿order_id = t2.order_id
WHERE
t2.review_score = '5';