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


