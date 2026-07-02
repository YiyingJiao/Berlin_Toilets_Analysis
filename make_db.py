#this file is to be run after extract_population file
import sqlite3
import pandas as pd
db_file = sqlite3.connect("berlin_toilets.db")          # creates a real database file

toilet_table = pd.read_excel("berliner-toiletten-standorte.xlsx")
toilet_table.to_sql("berlin_toilets", db_file, index=False, if_exists="replace")


population_table= pd.read_csv("population.csv")
population_table.to_sql("population", db_file, index=False, if_exists="replace")


db_file.close()


print("Created berlin_toilets.db with tables: berlin_toilets; population")
