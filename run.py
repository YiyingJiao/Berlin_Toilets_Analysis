import sys
import sqlite3
import pandas as pd

# source of the data for toilets: https://daten.berlin.de/datensaetze/toiletten
# link to file: https://www.berlin.de/sen/uvk/_assets/verkehr/infrastruktur/oeffentliche-toiletten/berliner-toiletten-standorte.xlsx?ts=1753174745
# date of the data: July 17, 2025

# source of the data for population:https://www.statistik-berlin-brandenburg.de/a-i-5-hj
# link to file: https://download.statistik-berlin-brandenburg.de/77af5b36036a22b7/8eb01f34d064/SB_A01-05-00_2025h02_BE.xlsx
# date of the data: December 31, 2025


#load the two data sources as dataframes
toilet_df = pd.read_excel("berliner-toiletten-standorte.xlsx")
pop_df = pd.read_csv("population.csv")

#load the query
sql_file = sys.argv[1]

# start SQLite (in memory), not saved to disk
con = sqlite3.connect(":memory:")      

# load the two dataframes as table "berlin_toilets" and "population"
toilet_df.to_sql("berlin_toilets", con, index=False)
pop_df.to_sql("population", con, index=False)


with open(sql_file) as q:
    query = q.read()

print(pd.read_sql_query(query, con).to_string(index=False))