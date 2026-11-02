# Cyber Incident Response & Digital Evidence Management System (CIRDEMS)

> **Course:** Database Systems & Laboratory (CSE2004 / BCSE202L)  
> **Institution:** School of Computer Science Engineering and Information Systems, Vellore Institute of Technology (VIT)  
> **Target Database:** Oracle Database 21c Enterprise / Express Edition (XE) & PL/SQL  
> **Application Layer:** Python 3.13 (`oracledb`, `Flask`) & Interactive Cyber SOC Web Interface  

---

## 📁 Repository & Project Architecture

```
CIRDEMS - DBMS/
│
├── CIRDEMS_DBMS_First_Review_Report.md  # Complete 10-Section Academic Project Report
├── run_soc_dashboard.bat               # 1-Click Windows Launcher for SOC Web App
├── README.md                           # Project Directory & Quickstart Documentation
│
├── database/                           # Oracle 21c SQL & PL/SQL Component Suite
│   ├── run_all.sql                     # Master script: Runs entire database suite
│   ├── 01_schema_ddl.sql               # 10 Normalized tables with PK, FK, CHECK, UNIQUE
│   ├── 02_data_seed.sql                # 10+ realistic records per table (100+ total rows)
│   ├── 03_advanced_queries.sql         # 15 Advanced analytical SQL queries (5 categories)
│   ├── 04_plsql_components.sql         # 2 Procedures, 2 Functions, 1 Cursor, 2 Triggers
│   └── 05_dml_demo.sql                 # INSERT, UPDATE, DELETE & ACID transaction demo
│   └── 06_er_diagram_alignment.sql     # ER entities and direct relationships
│
├── docs/                               # Diagrams, Layouts & Viva Preparation
│   ├── chen_er_diagram.html            # ER entities, attributes, and relationship cardinalities
│   └── VIVA_AND_REVIEW_GUIDE.md        # Faculty Review & Viva Voce Q&A Cheat Sheet
│
└── app/                                # Python Interactive Application Layer
    ├── app.py                          # Flask API & transaction pipeline server
    ├── db_config.py                    # Oracle 21c XE connector (`python-oracledb`)
    ├── static/
    │   └── chen_er_diagram.html        # Embedded ER diagram visualizer
    └── templates/
        └── index.html                  # Cyber SOC Dark Theme Command Console
```

---

## 🚀 Quickstart Guide

### 1. Execute Database Scripts in Oracle 21c XE
Open **SQL*Plus** and connect to the `XE` service (`CDB$ROOT`). This local project stores its CIRDEMS tables in the `SYSTEM` schema there; the password is kept in the local `.env` file, not in the Python code.
```sql
CONNECT SYSTEM@localhost:1521/XE
-- Enter your SYSTEM password when prompted.
SHOW USER
SHOW CON_NAME
```

The master schema script drops and recreates the CIRDEMS tables in the current schema. Run it only if you are okay replacing those tables and their data:
```sql
@database/run_all.sql
```

### 2. Launch the Interactive SOC Web Console
Double-click `run_soc_dashboard.bat`. It starts the site on `http://127.0.0.1:5000` using the private `.env` file and opens your browser. The password is not stored in the Python source.

The app listens only on your computer. Incident submissions require a live Oracle connection; if Oracle is offline, the app shows an error and does not pretend the incident was saved. Open **`http://127.0.0.1:5000`** in any web browser to interact with:
- Stored Procedure `SP_LOG_INCIDENT_WITH_INVESTIGATION`
- Dynamic Function `FN_GET_ASSET_RISK_SCORE`
- Tamper-Guard Trigger `TRG_PREVENT_EVIDENCE_TAMPERING` (intercepting illegal modifications with `ORA-20001`)
- Live Monitored Assets & Incidents tables

When Oracle is unavailable, write operations return an error instead of pretending a record was saved.

---

## 📑 Core Documentation Links
- **Academic Project Report:** [`CIRDEMS_DBMS_First_Review_Report.md`](file:///c:/Users/never/OneDrive/Desktop/PROJECTS---/CIRDEMS%20-%20DBMS/CIRDEMS_DBMS_First_Review_Report.md)
- **Faculty Viva Voce Guide:** [`docs/VIVA_AND_REVIEW_GUIDE.md`](file:///c:/Users/never/OneDrive/Desktop/PROJECTS---/CIRDEMS%20-%20DBMS/docs/VIVA_AND_REVIEW_GUIDE.md)
- **ER Diagram Reference:** [`docs/chen_er_diagram.html`](file:///c:/Users/never/OneDrive/Desktop/PROJECTS---/CIRDEMS%20-%20DBMS/docs/chen_er_diagram.html)

## ER diagram data entry

Use **ER Data Entry** in the dashboard or open `http://127.0.0.1:5000/er-data` to insert records for all nine entities in the supplied diagram: User, Asset, Incident, Response Action, Report, Investigation, Evidence, Chain of Custody, and Vulnerability. Each form submits to Flask and commits to Oracle. Lookup fields come from the live tables.

The `06_er_diagram_alignment.sql` migration is included in `database/run_all.sql`. It adds the missing Report and Chain of Custody tables, gives Evidence its own primary key, links custody records directly to Evidence, and adds direct incident links for response actions, evidence, and vulnerabilities. Existing evidence rows are retained and renumbered to unique IDs. The project keeps supporting tables (`ALERTS`, `INDICATORS`, and `USER_PHONES`) as extensions.
