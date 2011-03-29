--
-- us_stk_past_week.sql
--

-- Usage: @us_stk_past_week.sql 2011-01-30

-- I use this script to get 1 week's worth of us_stk-prediction data.

-- Start by showing summarized data for each pair:

COLUMN sum_g1 FORMAT 9999.9999
COLUMN avg_g1 FORMAT 999.9999
COLUMN sharpe_ratio FORMAT 999.99
COLUMN min_g1 FORMAT 999.9999
COLUMN max_g1 FORMAT 999.9999

SET TIME off TIMING off ECHO off
SET MARKUP HTML ON TABLE "class='table_us_stk_past_week'"
SPOOL tmp_us_stk_past_week_&1

SELECT
tkr
,ROUND(SUM(g1),4)   sum_g1
,ROUND(AVG(g1),4)   avg_g1
,ROUND(AVG(g1) / STDDEV(g1),2) sharpe_ratio
,ROUND(MIN(g1),4)   min_g1
,ROUND(MAX(g1),4)   max_g1
,COUNT(g1) position_count
FROM us_stk_pst12
WHERE rnng_crr1 > 0.1
AND score_diff > 0.6
AND ydate > '&1'
AND ydate - 7 < '&1'
GROUP BY tkr
HAVING(STDDEV(g1) > 0)
ORDER BY tkr
/

SELECT
tkr
,ROUND(SUM(g1),4)   sum_g1
,ROUND(AVG(g1),4)   avg_g1
,ROUND(AVG(g1) / STDDEV(g1),2) sharpe_ratio
,ROUND(MIN(g1),4)   min_g1
,ROUND(MAX(g1),4)   max_g1
,COUNT(g1) position_count
FROM us_stk_pst12
WHERE rnng_crr1 > 0.1
AND score_diff < -0.6
AND ydate > '&1'
AND ydate - 7 < '&1'
GROUP BY tkr
HAVING(STDDEV(g1) > 0)
ORDER BY tkr
/

SPOOL OFF
SET MARKUP HTML OFF

-- This is called by other sql scripts.
-- So, comment out exit:
-- exit
