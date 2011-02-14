--
-- 6hp.sql
--

SET LINES 66
DESC di5min
SET LINES 166

CREATE OR REPLACE VIEW hp10 AS
SELECT
pair
-- ydate is granular down to 5 minutes:
,ydate
,clse
-- Derive an attribute I call "day_hour":
,TO_CHAR(ydate,'D')||'_'||TO_CHAR(ROUND(ydate,'HH24'),'HH24')dhr
,TO_CHAR(ydate,'Dy')||'_'||TO_CHAR(ROUND(ydate,'HH24'),'HH24')dyhr
-- Get ydate 6 hours in the future:
,LEAD(ydate,6*12,NULL)OVER(PARTITION BY pair ORDER BY pair,ydate) ydate6
-- Get closing price 6 hours in the future:
,LEAD(clse,6*12,NULL)OVER(PARTITION BY pair ORDER BY pair,ydate) clse6
FROM di5min
WHERE ydate > '2009-01-01'
ORDER BY pair,ydate
/

-- rpt
SELECT
pair,dhr,dyhr
,MIN(ydate)min_date
,COUNT(ydate)count_npg
,MAX(ydate)max_date
FROM hp10
WHERE (ydate6 - ydate)BETWEEN 6/24 AND 6.29/24
AND dhr='3_18'
GROUP BY pair,dhr,dyhr
ORDER BY pair,dhr,dyhr
/

SELECT
pair
,MIN(ydate)
,COUNT(ydate)
,MAX(ydate)
FROM hp10
GROUP BY pair
ORDER BY pair
/

-- I derive more attributes:
CREATE OR REPLACE VIEW hp12 AS
SELECT
pair
,ydate
,clse
,dhr
,dyhr
,ydate6
,clse6
,(clse6 - clse)/clse npg
FROM hp10
WHERE (ydate6 - ydate)BETWEEN 6/24 AND 6.29/24
ORDER BY pair,ydate
/

--rpt
SELECT COUNT(ydate)FROM hp10;
SELECT AVG(ydate6 - ydate), MIN(ydate6 - ydate),MAX(ydate6 - ydate),COUNT(ydate)FROM hp12;
-- I should see no rows WHERE the date difference is less than 6 hours:
SELECT COUNT(ydate)FROM hp12 WHERE (ydate6 - ydate) < 6/24;

-- I should see many rows WHERE the date difference is exactly 6 hours:
SELECT MIN(ydate),COUNT(ydate),MAX(ydate)FROM hp12 WHERE (ydate6 - ydate) = 6/24;

-- If I am missing some rows, cclues may appear here:
SELECT TO_CHAR(ydate,'Dy'),MIN(ydate),COUNT(ydate),MAX(ydate)
FROM hp12
GROUP BY TO_CHAR(ydate,'Dy')
ORDER BY COUNT(ydate)
/

-- Now I can aggregate:
SELECT
pair,dhr,dyhr
,MIN(ydate)min_date
,COUNT(npg)count_npg
,MAX(ydate)max_date
,ROUND(MIN(npg),4)min_npg
,ROUND(AVG(npg),4)avg_npg
,ROUND(STDDEV(npg),4)stddev_npg
,ROUND(AVG(npg)/STDDEV(npg),2)sharpe_ratio
,ROUND(MAX(npg),4)max_npg
,ROUND(SUM(npg),4)sum_npg
FROM hp12
GROUP BY pair,dhr,dyhr
-- I want a Sharpe Ratio > 0.5
HAVING ABS(AVG(npg)/STDDEV(npg)) > 0.5
ORDER BY pair,dhr,dyhr
/

exit

