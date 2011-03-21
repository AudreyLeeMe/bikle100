--
-- fx_past_week
--

-- Usage: @fx_past_week.sql 2011-01-30

-- I use this script to get 1 week's worth of fx-prediction data.

-- Start by showing summarized data for each pair:

SELECT
pair
,ROUND(SUM(g4),4)   sum_g4
,ROUND(AVG(g4),4)   avg_g4
,ROUND(AVG(g4) / STDDEV(g4),2) sharpe_ratio
,ROUND(MIN(g4),4)   min_g4
,ROUND(MAX(g4),4)   max_g4
,COUNT(g4) position_count
FROM fxpst12
WHERE rnng_crr1 > 0.1
AND score_diff > 0.6
AND ydate > '&1'
AND ydate - 7 < '&1'
AND g2 < 0.0004
GROUP BY pair
HAVING(STDDEV(g4) > 0)
ORDER BY pair
/

-- This is called by other sql scripts.
-- So, comment out exit:
-- exit
