
-- Query 3: Percentage of WCs that are open 24 hours per Berlin district

-- Question: In each Berlin district, what share of public WCs are open 24 hours?


WITH opening_time AS (
SELECT
    TRIM(Bezirk) as district,
    COUNT(*) as total_WC_count,
    SUM(CASE WHEN TRIM(Öffnungszeiten) = '24h' THEN 1 ELSE 0 END) as open_24h_count,
    SUM(CASE WHEN Öffnungszeiten IS NULL THEN 1 ELSE 0 END) as unknown_count

FROM berlin_toilets
WHERE TRIM(Symbol) = 'WC'
GROUP BY TRIM(Bezirk)
)

SELECT
    district,
    total_WC_count,
    100*(CAST (open_24h_count AS REAL)/total_WC_count) as open_24h_percent,
    100*(CAST (unknown_count AS REAL)/total_WC_count) as unknown_percent
From opening_time;















