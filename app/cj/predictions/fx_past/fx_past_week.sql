--
-- fx_past_week.sql
--

-- Usage: @fx_past_week.sql 2011-01-30

-- I use this script to get 1 week's worth of fx-prediction data.
-- This script depends on tables created by fx_past.sql
-- So, I should run fx_past.sql before I run fx_past_week.sql

-- Start by showing summarized data for each pair:

COLUMN pair   FORMAT A14
COLUMN sum_g5 FORMAT 99.9999
COLUMN avg_g5 FORMAT 99.9999
COLUMN sharpe_ratio FORMAT 9999.99
COLUMN min_g5 FORMAT 99.9999
COLUMN max_g5 FORMAT 99.9999
COLUMN avg_score FORMAT 9.99

BREAK ON REPORT

COMPUTE SUM LABEL 'All Pairs Sum:' OF sum_g5         ON REPORT
COMPUTE SUM LABEL 'All Pairs Sum:' OF position_count ON REPORT

SET TIME off TIMING off ECHO off
SET MARKUP HTML ON TABLE "class='table_fx_past_week'"
SPOOL tmp_fx_past_week_&1

SELECT
pair
,ROUND(AVG(score_diff),2) avg_score
,ROUND(AVG(g5) / STDDEV(g5),2) sharpe_ratio
,ROUND(AVG(g5),4)   avg_g5
,COUNT(g5)          position_count
,ROUND(SUM(g5),4)   sum_g5
,ROUND(MIN(g5),4)   min_g5
,ROUND(MAX(g5),4)   max_g5
FROM fxpst12
WHERE rnng_crr1 > 0.0
AND score_diff < -0.55
AND ydate > '&1'
AND ydate - 7 < '&1'
AND g1 > -0.0004
GROUP BY pair
HAVING(STDDEV(g5) > 0)
ORDER BY pair
/

SELECT
pair
,ROUND(AVG(score_diff),2) avg_score
,ROUND(AVG(g5) / STDDEV(g5),2) sharpe_ratio
,ROUND(AVG(g5),4)   avg_g5
,COUNT(g5)          position_count
,ROUND(SUM(g5),4)   sum_g5
,ROUND(MIN(g5),4)   min_g5
,ROUND(MAX(g5),4)   max_g5
FROM fxpst12
WHERE rnng_crr1 > 0.0
AND score_diff > 0.55
AND ydate > '&1'
AND ydate - 7 < '&1'
AND g1 < 0.0004
GROUP BY pair
HAVING(STDDEV(g5) > 0)
ORDER BY pair
/

SPOOL OFF
SET MARKUP HTML OFF

-- This is called by other sql scripts.
-- So, comment out exit:
-- exit
