SELECT * FROM customer
-- 1- Who made the highest revenue according to gender?
SELECT 
	gender,
	SUM(purchase_amount) AS revenue
FROM customer
GROUP BY gender
-- 2- Which customers used a discount but still spent more than the average purchase amount? 
SELECT 
	customer_id,
	purchase_amount 
FROM customer 
WHERE discount_applied = 'Yes' 
	AND purchase_amount >= (SELECT AVG(purchase_amount) FROM customer)
-- 3- What are the top 5 products according to avr review rating?
SELECT 
	item_purchased,
	ROUND(AVG(review_rating::numeric),2) AS "Average Product Rating"
FROM customer
GROUP BY item_purchased
ORDER BY AVG(review_rating) DESC
LIMIT 5
-- 4- Which age group contribute the most according to revenue?
SELECT 
	age_group,
	SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY age_group
ORDER BY total_revenue desc;
-- 5- Which payment method was used the most, and how much total revenue did it generate?
SELECT 
    payment_method,
	COUNT(*) AS total_purchases,
	SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY payment_method
ORDER BY total_purchases DESC;
-- 6- How do different subscription statuses compare in terms of customer count, average spend, and total revenue?
SELECT subscription_status,
COUNT(customer_id) AS total_customers,
ROUND (AVG(purchase_amount),2) as avg_spend,
ROUND (SUM(purchase_amount),2) as total_revenue
FROM customer
GROUP BY subscription_status
ORDER BY total_revenue,avg_spend
-- 7- What Which items relied most on discounts to drive sales, and how many times were they purchased?"
SELECT 
    item_purchased,
    COUNT(*) AS total_purchases,
    ROUND(100.0 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC, total_purchases DESC
LIMIT 5;
-- 8- For each purchase frequency level, how many customers are there and how many discounts were applied?
SELECT 
    frequency_of_purchases,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) AS total_discounts
FROM customer
GROUP BY frequency_of_purchases
ORDER BY frequency_of_purchases DESC;
-- 9- Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
SELECT 
	subscription_status,
    COUNT(customer_id) AS repeat_buyers
FROM customer
WHERE previous_purchases > 5
GROUP BY subscription_status;

