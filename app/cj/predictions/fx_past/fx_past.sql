--
-- fx_past.sql
--

-- I use this script to join 3 types of tables:
-- prices,gains
-- gatt-scores
-- gattn-scores

-- I can pattern off this script:
-- /pt/s/rluck/svm62/qrs2.sql

DROP TABLE fxpst10;
PURGE RECYCLEBIN;
CREATE TABLE fxpst10 COMPRESS AS
SELECT
pair
,ydate
,clse
,prdate
,(LEAD(clse,12*2,NULL)OVER(PARTITION BY pair ORDER BY ydate)-clse)/clse g2
,(LEAD(clse,12*6,NULL)OVER(PARTITION BY pair ORDER BY ydate)-clse)/clse g6
FROM di5min
WHERE ydate > sysdate - (7 * 7)
AND clse > 0
ORDER BY pair,ydate
/

ANALYZE TABLE fxpst10 COMPUTE STATISTICS;

DROP TABLE fxpst12;
CREATE TABLE fxpst12 COMPRESS AS
SELECT
m.pair
,m.ydate
,m.clse
,ROUND(l.score-s.score,1) rscore_diff1
,ROUND(l.score-s.score,2) rscore_diff2
,m.g2
,m.g6
,m.g6-m.g2 g4
,CORR(l.score-s.score,g6)OVER(PARTITION BY l.pair ORDER BY l.ydate ROWS BETWEEN 12*24*1 PRECEDING AND CURRENT ROW)rnng_crr1
FROM svm62scores l,svm62scores s,fxpst10 m
WHERE l.targ='gatt'
AND   s.targ='gattn'
AND l.prdate = s.prdate
AND l.prdate = m.prdate
-- Speed things up:
AND l.ydate > sysdate - (7 * 7)
AND s.ydate > sysdate - (7 * 7)
/

ANALYZE TABLE fxpst12 COMPUTE STATISTICS;

SELECT
TO_CHAR(ydate,'W')
,TO_CHAR(ydate,'WW')
,MIN(ydate)
,COUNT(ydate)
,MAX(ydate)
FROM fxpst12
GROUP BY 
TO_CHAR(ydate,'W')
,TO_CHAR(ydate,'WW')
ORDER BY 
TO_CHAR(ydate,'W')
,TO_CHAR(ydate,'WW')
/

exit


select count(*)from
(
SELECT
pair
,ydate
,rscore_diff2
,g2
,ROUND(rnng_crr1,2)      rnng_crr1
,(sysdate - ydate)*24*60 minutes_age
FROM fxpst12
WHERE rnng_crr1 > 0.1
ORDER BY pair,ydate
)
/

select count(*)from
(
SELECT
pair
,CASE WHEN rscore_diff2<0 THEN'sell'ELSE'buy'END bors
,ROUND(clse,4)clse
,rscore_diff2
,ROUND(g2,4)g2
,ROUND(rnng_crr1,2)      rnng_crr1
,(sysdate - ydate)*24*60 minutes_age
--,ydate + 6/24 cls_date
,TO_CHAR(ydate + 6/24,'YYYYMMDD_HH24:MI:SS')||'_GMT' cls_str
FROM fxpst12
WHERE rnng_crr1 > 0.1
AND ABS(rscore_diff2) > 0.6
ORDER BY pair,ydate
)
/

exit
