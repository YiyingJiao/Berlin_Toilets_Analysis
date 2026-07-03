-- Query 5: Number of public WCs per 100,000 residents per Berlin district
-- Question: When adjusted for population size, which Berlin districts
-- are most and least served by public WCs?

WITH toilet_counts AS (
    SELECT
        TRIM(Bezirk)  AS district,
        COUNT(*)      AS toilet_count
    FROM berlin_toilets
    WHERE TRIM(Symbol) = 'WC'
    GROUP BY TRIM(Bezirk)
)
SELECT
    t.district,
    t.toilet_count,
    p.population,
    ROUND(100000.0 * t.toilet_count / p.population, 1)  AS toilets_per_100k
FROM toilet_counts t
JOIN population p ON t.district = p.district
ORDER BY toilets_per_100k ASC;


