--
-- us_stk_past.sql
--

-- I use this script to join 3 types of tables:
-- prices,gains
-- gatt-scores
-- gattn-scores

-- I can pattern off this script:
-- /pt/s/rluck/svm62/qrs2.sql

DROP TABLE us_stk_pst10;
PURGE RECYCLEBIN;
CREATE TABLE us_stk_pst10 COMPRESS AS
SELECT
tkr
,ydate
,tkrdate
,clse
,selldate
,gain1day g1
FROM di5min_stk_c2
WHERE ydate > '2011-01-30'
ORDER BY tkr,ydate
/

ANALYZE TABLE us_stk_pst10 ESTIMATE STATISTICS SAMPLE 9 PERCENT;

DROP TABLE us_stk_pst12;
CREATE TABLE us_stk_pst12 COMPRESS AS
SELECT
m.tkr
,m.ydate
,m.clse
,(l.score-s.score)         score_diff
,ROUND(l.score-s.score,1) rscore_diff1
,ROUND(l.score-s.score,2) rscore_diff2
,m.g1
,CORR(l.score-s.score,m.g1)OVER(PARTITION BY l.tkr ORDER BY l.ydate ROWS BETWEEN 12*24*5 PRECEDING AND CURRENT ROW)rnng_crr1
FROM stkscores l,stkscores s,us_stk_pst10 m
WHERE l.targ='gatt'
AND   s.targ='gattn'
AND l.tkrdate = s.tkrdate
AND l.tkrdate = m.tkrdate
-- Speed things up:
AND l.ydate > '2011-01-30'
AND s.ydate > '2011-01-30'
/

ANALYZE TABLE us_stk_pst12 ESTIMATE STATISTICS SAMPLE 9 PERCENT;

-- rpt
-- This SELECT gives me a list of recent week-names.
-- I use minday, maxday to help me understand the contents of each week.
SELECT
TO_CHAR(ydate,'WW')
,MIN(ydate)
,TO_CHAR(MIN(ydate),'Dy')minday
,COUNT(ydate)
,MAX(ydate)
,TO_CHAR(MAX(ydate),'Dy')maxday
FROM us_stk_pst12
GROUP BY 
TO_CHAR(ydate,'WW')
ORDER BY 
MIN(ydate)
/

exit
