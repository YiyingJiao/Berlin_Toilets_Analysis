-- Query 2: Percentage of step-free(barrierefrei) WCs per district

-- Question: In each Berlin district, what share of public WCs 
-- are step-free (barrierefrei)

SELECT  TRIM(Bezirk) as district, 
        --CASE WHEN creates an intermediate column that fills in the values
        --according to the condition and the values will be either then or else
        COUNT(*) as total_WC_count,
        SUM(CASE WHEN barrierefrei = 'ja' 
            THEN 1 ELSE 0 END) as barrierefrei_count,
        100*CAST((SUM(CASE WHEN barrierefrei = 'ja' 
            THEN 1 ELSE 0 END)) AS REAL)/COUNT(*) as barrierefrei_percent
From berlin_toilets
WHERE TRIM(Symbol) = 'WC'
GROUP BY TRIM(Bezirk)
