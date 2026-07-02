-- Query 1: Toilet count by district
-- Question: How many public toilets does each Berlin district have?

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
-- group by happens first before select in actual run time
-- for group by, always use native name as good practice  

GROUP BY  TRIM(Bezirk)



ORDER By "number of toilets" DESC;


