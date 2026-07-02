import openpyxl
import csv

# 1. Open the workbook, read Table 3 (population by district)
wb = openpyxl.load_workbook("population.xlsx", data_only=True)
ws = wb["T3 T4"]
rows = list(ws.iter_rows(values_only=True))

# 2. The 12 clean district names, in sheet column order (after the "Berlin" column)
districts = [
    "Mitte", "Friedrichshain-Kreuzberg", "Pankow", "Charlottenburg-Wilmersdorf",
    "Spandau", "Steglitz-Zehlendorf", "Tempelhof-Schöneberg", "Neukölln",
    "Treptow-Köpenick", "Marzahn-Hellersdorf", "Lichtenberg", "Reinickendorf",
]

# 3. Find the "insgesamt" (total) section, then the 2025 row inside it.
#    NOTE: section labels ("Deutsche"/"Ausländer"/"insgesamt") live in the
#    SECOND column, so we scan the whole row for the word, not just row[0].
in_total_section = False
total_2025 = None
for row in rows:
    row_text = [str(c).strip() if c is not None else "" for c in row]
    if "insgesamt" in row_text:
        in_total_section = True
        continue
    if in_total_section and row_text[0].startswith("2025-12-31"):
        total_2025 = row
        break

# 4. Map districts to values. Layout: [date, Berlin, Mitte, ...] -> skip Berlin (index 1)
berlin_total = total_2025[1]
values = total_2025[2:2 + 12]
pairs = list(zip(districts, values))

# 5. Print to verify
print("Berlin total (sanity check):", berlin_total)
print()
for d, v in pairs:
    print(f"{d:30} {v}")
print("\nSum of 12 districts:", sum(values))

# 6. Write the clean CSV
with open("population.csv", "w", newline="", encoding="utf-8") as f:
    w = csv.writer(f)
    w.writerow(["district", "population"])
    w.writerows(pairs)
print("\nWrote population.csv")
