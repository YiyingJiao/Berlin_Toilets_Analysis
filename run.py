import sys
import sqlite3
import pandas as pd

# ── Plumbing: write once, never edit. ──
# pandas reads your Excel file, then loads it into SQLite as a table
# called "Berlin Toilets". Your SQL then runs against that table.
# source of the data : https://daten.berlin.de/datensaetze/toiletten
# linke to file:https://www.berlin.de/sen/uvk/_assets/verkehr/infrastruktur/oeffentliche-toiletten/berliner-toiletten-standorte.xlsx?ts=1753174745
# date of the data: July 17, 2025


#load the data
df = pd.read_excel("berliner-toiletten-standorte.xlsx")

#load the query
sql_file = sys.argv[1]
#sql_file = sys.argv[1] if len(sys.argv) > 1 else "01_count_by_district.sql"
con = sqlite3.connect(":memory:")                          # start SQLite (in memory)
df.to_sql("berlin_toilets", con, index=False)                     # load data as table "toilets"
 
with open(sql_file) as q:
    query = q.read()

print(pd.read_sql_query(query, con).to_string(index=False))