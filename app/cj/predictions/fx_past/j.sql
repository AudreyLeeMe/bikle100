--
-- fx_past_week.sql
--

-- Usage: @fx_past_week.sql 2011-01-30

-- I use this script to get 1 week's worth of fx-prediction data.
-- This script depends on tables created by fx_past.sql
-- So, I should run fx_past.sql before I run fx_past_week.sql

-- Start by showing summarized data for each pair:

COLUMN pair             FORMAT A8  HEADING     'Currency|Pair'    JUSTIFY left
COLUMN avg_danbot_score FORMAT 9.99 HEADING    'Avg|DanBot|Score' JUSTIFY left
COLUMN sharpe_ratio     FORMAT 9999.99 HEADING 'Sharpe|Ratio'     JUSTIFY left
COLUMN avg_5hr_gain   FORMAT 99.9999 HEADING 'Avg of|5hr|gains'   JUSTIFY left
COLUMN position_count FORMAT 9999  HEADING 'Count of|positions'   JUSTIFY left
COLUMN sum_5hr_gain   FORMAT 99.9999 HEADING 'Sum of|5hr|gains'   JUSTIFY center
COLUMN min_5hr_gain   FORMAT 99.9999 HEADING 'Min of|of|5hr|gains'JUSTIFY center
COLUMN max_5hr_gain   FORMAT 99.9999 HEADING 'Max of|5hr|gains'   JUSTIFY right
COLUMN stddev_5hr_gain FORMAT 99.9999 HEADING 'StdDeviation|of|5hr|gains' JUSTIFY right

BREAK ON REPORT

COMPUTE SUM LABEL 'Sum:' OF sum_5hr_gain   ON REPORT
COMPUTE SUM LABEL 'Sum:' OF position_count ON REPORT

SET TIME off TIMING off ECHO off LINESIZE 188 WRAP on


COLUMN anote FORMAT A120 HEADING 'Note:'

SELECT
'The above tables are summaries of predictions. A list of all predictions is displayed below '||
'if you want to load it into a spreadsheet.' anote
FROM dual
/

COLUMN timestamp_0hr FORMAT A11   HEADING 'Timestamp|at hour 0' 
COLUMN danbot_score FORMAT 9.99   HEADING 'DanBot|Score|at hour 0' 
COLUMN price_0hr    FORMAT 999.9999 HEADING 'Price at|hour 0'
COLUMN price_1hr    FORMAT 999.9999 HEADING 'Price after|1 hour'
COLUMN price_6hr    FORMAT 999.9999 HEADING 'Price after|6 hours'
COLUMN gain_6hr1hr  FORMAT  99.9999 HEADING '5 hour gain|between|hr1 and hr6'
COLUMN normalized_gain_5hr FORMAT 9.9999 HEADING 'Normalized|5hr gain'

SELECT
pair
,ydate timestamp_0hr
,ROUND(score_diff,4) danbot_score
,ROUND(price_0hr,4)  price_0hr
,ROUND(price_1hr,4)  price_1hr
,ROUND(price_6hr,4)  price_6hr
,ROUND(price_6hr-price_1hr,4)gain_6hr1hr
,ROUND((price_6hr-price_1hr)/price_0hr,4)normalized_gain_5hr
FROM fxpst12
WHERE rnng_crr1 > 0.0
AND score_diff > 0.55
AND ydate > '&1'
AND ydate - 7 < '&1'
AND g1 < 0.0004
ORDER BY pair,ydate
/

exit

SELECT
pair
,ydate timestamp_0hr
,ROUND(score_diff,4) danbot_score
,ROUND(price_0hr,4)  price_0hr
,ROUND(price_1hr,4)  price_1hr
,ROUND(price_6hr,4)  price_6hr
,ROUND((price_6hr-price_1hr),4)gain_5hr
,ROUND((price_6hr-price_1hr)/price_0hr,4)normalized_gain_5hr
FROM fxpst12
WHERE rnng_crr1 > 0.0
AND score_diff > 0.55
AND ydate > '&1'
AND ydate - 7 < '&1'
AND g1 < 0.0004
ORDER BY pair,ydate
/

exit

SELECT
pair
,ydate timestamp_0hr
,ROUND(score_diff,4) danbot_score
,ROUND(price_0hr,4)  price_0hr
,ROUND(price_1hr,4)  price_1hr
,ROUND(price_6hr,4)  price_6hr
,ROUND(price_6hr-price_1hr,4)5hr_gain
,ROUND(g5,4)         5hr_n_gain
FROM fxpst12
WHERE rnng_crr1 > 0.0
AND score_diff > 0.55
AND ydate > '&1'
AND ydate - 7 < '&1'
AND g1 < 0.0004
ORDER BY pair,ydate
/

exit

SELECT
pair
,ROUND(AVG(score_diff),2) avg_danbot_score
,ROUND(AVG(g5) / STDDEV(g5),2) sharpe_ratio
,ROUND(AVG(g5),4)   avg_5hr_gain
,COUNT(g5)          position_count
,ROUND(SUM(g5),4)   sum_5hr_gain
,ROUND(MIN(g5),4)   min_5hr_gain
,ROUND(MAX(g5),4)   max_5hr_gain
,ROUND(STDDEV(g5),4)stddev_5hr_gain
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
,ROUND(AVG(score_diff),2) avg_danbot_score
,ROUND(AVG(g5) / STDDEV(g5),2) sharpe_ratio
,ROUND(AVG(g5),4)   avg_5hr_gain
,COUNT(g5)          position_count
,ROUND(SUM(g5),4)   sum_5hr_gain
,ROUND(MIN(g5),4)   min_5hr_gain
,ROUND(MAX(g5),4)   max_5hr_gain
,ROUND(STDDEV(g5),4)stddev_5hr_gain
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


-- This is called by other sql scripts.
-- So, comment out exit:
-- exit
