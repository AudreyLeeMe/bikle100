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
,gain1day
FROM di5min_stk_c2
WHERE ydate > '2011-01-30'
ORDER BY tkr,ydate
/

ANALYZE TABLE us_stk_pst10 ESTIMATE STATISTICS SAMPLE 9 PERCENT;

exit
