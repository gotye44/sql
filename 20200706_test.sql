SELECT gb, sido, sigungu
FROm fastfood;

발전지수 = (KFC+버거킹+맥날 )/ 롯리
순위, 시도, 시군구, 버거 도시발전지수
정렬은 순위가 높은행이 가장 먼저 나오도록
1, 서울특별시, 강남구, 5.32
2, 서울특별시, 서초구, 5.13
...

SELECT NVL(a.sido, b.sido), NVL(a.sigungu, b.sigungu), round((NVL(b.cnt, 0) / NVL(a.cnt, 0)), 2)
FROM
(SELECT sido, sigungu, count(gb) cnt
FROM fastfood
WHERE gb = '롯데리아'
GROUP BY sido, sigungu) a 
FULL OUTER JOIN
(SELECT sido, sigungu, count(gb) cnt
FROM fastfood
WHERE gb IN('버거킹','맥도날드', 'KFC')
GROUP BY sido, sigungu) b ON(a.sido = b. sido) AND (a.sigungu = b. sigungu);

-----------------------------------------------------------------------------------

SELECT kfc.sido, kfc.sigungu, ROUND((kfc.kfc + bk.bk + mac.mac) / lot.lot, 2) score
FROM
(SELECT sido, sigungu, COUNT(*) kfc
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu) kfc,

(SELECT sido, sigungu, COUNT(*) bk
FROM fastfood
WHERE gb = '버거킹'
GROUP BY sido, sigungu) bk,

(SELECT sido, sigungu, COUNT(*) mac
FROM fastfood
WHERE gb = '맥도날드'
GROUP BY sido, sigungu) mac,

(SELECT sido, sigungu, COUNT(*) lot
FROM fastfood
WHERE gb = '롯데리아'
GROUP BY sido, sigungu) lot

WHERE kfc.sido = bk.sido
    AND kfc.sigungu = bk.sigungu
    AND kfc.sido = mac.sido
    AND kfc.sigungu = mac.sigungu
    AND kfc.sido = lot.sido
    AND kfc.sigungu = lot.sigungu
ORDER BY ROUND((kfc.kfc + bk.bk + mac.mac) / lot.lot, 2) DESC;


----------------------------------------------------

SELECT m.sido, m.sigungu, ROUND((m.m / d.d), 2) score
FROM
(SELECT sido, sigungu, COUNT(*) m
FROM fastfood
WHERE gb IN ('KFC', '버거킹', '맥도날드')
GROUP BY sido, sigungu) m,
(SELECT sido, sigungu, COUNT(*) d
FROM fastfood
WHERE gb = '롯데리아'
GROUP BY sido, sigungu) d
WHERE m.sido = d.sido
AND m.sigungu = d.sigungu
ORDER BY score DESC;

------------------------------------------

SELECT sido, sigungu, 
    ROUND((NVL(SUM(DECODE(gb, 'KFC', 1)), 0) + 
    NVL(SUM(DECODE(gb, '맥도날드', 1)), 0) +  
    NVL(SUM(DECODE(gb, '버거킹', 1)), 0)) /  
    NVL(SUM(DECODE(gb, '롯데리아', 1)), 1), 2) score
FROM fastfood
WHERE gb IN('롯데리아', 'KFC', '맥도날드', '버거킹')
GROUP BY sido, sigungu
ORDER BY score DESC;


------------------------------------------------
SELECT *
FROM burgerstore;

SELECT sido, sigungu, 
    ROUND((NVL(SUM(DECODE(storecategory, 'KFC', 1)), 0) + 
    NVL(SUM(DECODE(storecategory, 'MACDONALD', 1)), 0) +  
    NVL(SUM(DECODE(storecategory, 'BURGER KING', 1)), 0)) /  
    NVL(SUM(DECODE(storecategory, 'LOTTERIA', 1)), 1), 2) score
FROM burgerstore
WHERE storecategory IN('LOTTERIA', 'KFC', 'MACDONALD', 'BURGER KING')
GROUP BY sido, sigungu
ORDER BY score DESC;