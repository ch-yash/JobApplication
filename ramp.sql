/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021. */

WITH CTE AS
(
  SELECT EXTRACT(DAY FROM transaction_time) AS dy
  , SUM(transaction_amount) AS tot_transaction_amount 
  FROM transactions
  WHERE EXTRACT(YEAR FROM transaction_time) = 2021
      AND EXTRACT(MONTH FROM transaction_time) = 1
  GROUP BY 1
  ORDER BY 1
)
SELECT * 
, AVG(tot_transaction_amount) 
	  OVER(ORDER BY dy ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
    AS rolling_3d_avg 
FROM CTE
