# Berlin Public Toilet Access: An Equity Analysis

Is public-toilet access **equitable** across Berlin's 12 districts? This project analyzes 485 public WCs by two dimensions : 

* Provision — how many WCs exist per 100,000 residents (adjusts for population, so big and small districts compare fairly)  
* Usability — how many are step-free and open 24h

**🔗 [View the interactive dashboard on Tableau Public →](https://public.tableau.com/app/profile/nooting.pingu/viz/BerlinToiletsProjects_17831249995640/BerlinPublicToiletEquity?publish=yes)**

---

## Key findings

- **A 2.4× provision gap.** Friedrichshain-Kreuzberg has 19.1 WCs per 100,000 residents; Pankow has just 7.7.  
- **More toilets ≠ better toilets.** Per-capita provision and usability are largely *independent*. Having many WCs says little about whether they're accessible or always open.  
- **The clearest example:** Marzahn-Hellersdorf ranks near the bottom for provision but **top for usability (91.3% step-free & 24h)**. Pankow is worst per-capita yet still reaches 66.7% usability.  
- **The weakest usability:** Only **37.5% of Spandau's WCs** are both step-free and open 24h.

---

## The data

| Dataset | Source | Date | Records |
| :---- | :---- | :---- | :---- |
| Toilet locations | [daten.berlin.de](https://daten.berlin.de/datensaetze/toiletten) | 17 Jul 2025 | 509 facilities |
| District population | [Amt für Statistik Berlin-Brandenburg](https://www.statistik-berlin-brandenburg.de/a-i-5-hj) | 31 Dec 2025 | 12 districts |

**Scope:** 509 raw facilities were narrowed to **485 standard WCs**, excluding 14 Pissoirs and 10 event-only facilities.

**Data caveat:** 9% of WCs have no recorded opening hours, concentrated in Reinickendorf (24%) and Steglitz-Zehlendorf (19%).This gap is flagged directly on the dashboard, not hidden.

---

## How it was built

| Stage | Tool |
| :---- | :---- |
| Data cleaning & extraction | Python (pandas, openpyxl) |
| Analysis | SQL (SQLite) |
| Verification | pandas cross-check of every query |
| Visualisation | Tableau Public |

Every SQL result was independently re-computed in pandas to confirm it matched, no query shipped unverified.

---

## The analysis

Six SQL queries build the story step by step:

| \# | Question |
| :---- | :---- |
| Q1 | WC count per district |
| Q2 | % step-free per district |
| Q3 | % open 24h per district (with NULL handling) |
| Q4 | % that are **both** step-free **and** 24h |
| Q5 | WCs per 100,000 residents (JOIN with population) |
| Q6 | Provision vs. usability — are they related? |

---

## Repository structure

Berlin\_Toilets\_Analysis/

├── data/

│   ├── berliner-toiletten-standorte.xlsx   \# raw toilet data

│   ├── SB\_A01-05-00\_2025h02\_BE.xlsx        \# raw population data

│   └── population.csv                       \# cleaned population (12 districts)

├── scripts/

│   ├── extract\_population.py                \# pulls clean population from multi-tab xlsx

│   └── make\_db.py                           \# builds the SQLite database

├── sql/

│   └── queries.sql                          \# the 6 analysis queries

├── berlin\_toilets.db                        \# SQLite database

└── README.md

---

## Reproduce it

\# 1\. Build the population CSV from the raw statistics file

python scripts/extract\_population.py

\# 2\. Load both datasets into a SQLite database

python scripts/make\_db.py

\# 3\. Open queries.sql in any SQLite client (e.g. SQLTools in VS Code)

\#    and run the queries against berlin\_toilets.db

---

## What I practised

- Writing clean, verified **SQL** (CTEs, `CASE WHEN`, aggregation, joins, NULL handling)  
- Cleaning messy real-world data (trailing whitespace, multi-tab spreadsheets, category filtering)  
- Framing an analysis around a **question**, not just charts  
- Communicating a nuanced finding (two independent dimensions) clearly to a general audience

---

Built by [Yiying Jiao](https://github.com/YiyingJiao)