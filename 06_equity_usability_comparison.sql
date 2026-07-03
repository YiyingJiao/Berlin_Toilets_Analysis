-- Query 6: Equity comparison — per-capita provision vs quality (step-free & 24h)
-- Question: Do districts with fewer toilets per resident also tend to have
-- lower quality access (step-free AND 24h)?

WITH counts AS (
    SELECT
        TRIM(Bezirk)  AS district,
        COUNT(*)      AS toilet_count
    FROM berlin_toilets
    WHERE TRIM(Symbol) = 'WC'
    GROUP BY TRIM(Bezirk)
),
quality AS (
    SELECT
        TRIM(Bezirk)  AS district,
        ROUND(100.0 * SUM(CASE WHEN TRIM(Öffnungszeiten) = '24h'
            AND TRIM(barrierefrei) = 'ja' THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_both
    FROM berlin_toilets
    WHERE TRIM(Symbol) = 'WC'
    GROUP BY TRIM(Bezirk)
),
pop AS (
    SELECT district, population FROM population
)
SELECT
    c.district,
    ROUND(100000.0 * c.toilet_count / p.population, 1)  AS toilets_per_100k,
    q.pct_both                                           AS pct_stepfree_and_24h
FROM counts c
JOIN pop p ON c.district = p.district
JOIN quality q ON c.district = q.district
ORDER BY toilets_per_100k ASC;