-- Query 4: Percentage of WCs that are BOTH step-free(barrierefrei)
-- and open 24 hours per Berlin district
-- Question: In each Berlin district, what share of public WCs
-- are BOTH step-free (barrierefrei) and open 24 hours?
SELECT
    TRIM(Bezirk) as districts,
    
    --Barrier free percentage
    ROUND(100*(CAST(SUM(CASE WHEN TRIM(barrierefrei) = 'ja' 
        THEN 1 ELSE 0 END) AS REAL)/COUNT(*)),2) as barrierefrei_percent,

    --24 hour open percentage
    ROUND(100*(CAST(SUM(CASE WHEN TRIM(Öffnungszeiten) = '24h' 
        THEN 1 ELSE 0 END) AS REAL)/COUNT(*)),2) as open_24h_percent,
        
    -- unknown open time percentage
    ROUND(100*(CAST(SUM(CASE WHEN Öffnungszeiten IS NULL 
        THEN 1 ELSE 0 END) AS REAL)/COUNT(*)),2) as unknown_hours_percent,

    -- BOTH barrier free and 24 hour open percentage
    ROUND(100*(CAST( SUM(CASE WHEN (TRIM(Öffnungszeiten) = '24h' AND TRIM(barrierefrei) = 'ja') 
        THEN 1 ELSE 0 END) AS REAL)/COUNT(*)),2) as barrierfree_and_24h_percent

FROM berlin_toilets
WHERE TRIM(Symbol) = 'WC'
GROUP BY TRIM(Bezirk)
ORDER BY barrierefrei_percent ASC;