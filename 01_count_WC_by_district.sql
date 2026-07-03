-- Query 1: WC count by district in Berlin
-- Question: How many public WCs does each Berlin district have?


-- district names some of them have spaces, trim to get rid of empty spaces
Select
    TRIM(bezirk) AS district,
    count(*) AS "number of WC"

-- The SQL Tool connects to the pre-made db file called toilets
FROM berlin_toilets

-- Here we want only true toilets, so we exclude the two other types, 
-- Pissoirs  and WC(bei Veranstaltungen) as we want to look into toilets
-- that are available for all genders and  are permanent instead of events based,
-- Hence we only want WC

WHERE TRIM(Symbol) = 'WC'


GROUP BY  TRIM(Bezirk)



ORDER By "number of WC" DESC;


