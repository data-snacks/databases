-- Running totals for customers by date,
SELECT
  customer_id,
  amount,
  payment_date::timestamp::date AS payment_date,
  SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total
FROM
  payment
ORDER BY
  customer_id, payment_date;
-- 2 - Ranking customers y spendings
-- 3 - Finding the previous Row's Value
-- 4 - Finding the Previous Row's Value (LAG)
-- 5 - Calculating moving averages