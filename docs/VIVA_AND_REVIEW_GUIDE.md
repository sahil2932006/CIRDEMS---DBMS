# CIRDEMS — FACULTY REVIEW & VIVA VOCE PREPARATION GUIDE
## Database Systems Laboratory (CSE2004 / BCSE202L) — VIT

---

## 1. QUICK SYSTEM SUMMARY (ELEVATOR PITCH)
> **"What is your project about in 30 seconds?"**
> 
> "Our project is **CIRDEMS** (Cyber Incident Response & Digital Evidence Management System). It is a relational database application designed to organize cybersecurity incidents and their response records.
> 
> It follows the supplied ER diagram with nine core entities: User, Asset, Incident, Response Action, Report, Investigation, Evidence, Chain of Custody, and Vulnerability. The database also has project-support tables for alerts, indicators, and user phone numbers.
> 
> Incidents refer to an asset and a reporting user, and can have multiple investigations, reports, response actions, evidence records, and vulnerabilities. Custody logs refer directly to evidence records.
> 
> We implemented it using **Oracle 21c SQL and PL/SQL**, incorporating stored procedures, functions, explicit cursors, tamper-guard triggers, and an interactive **Python web console** connecting directly to the database."

---

## 2. TOP FACULTY QUESTIONS & MODEL ANSWERS (ER & RELATIONAL DESIGN)

### Q1: How is `EVIDENCE` modeled in the supplied diagram?
- **Model Answer:**
  `EVIDENCE` is a regular entity with its own primary key, `evidence_id`. It belongs to an incident; its attributes include type, source, file path, collection date, integrity hash, and notes. A custody record points to one evidence row.

### Q2: How did you handle Composite and Multivalued attributes?
- **Model Answer:**
  - **Composite Attributes:** `USER.name` (First, Middle, Last) and `USER.address` (Street, City, State, Pincode) are modeled as branching ovals in conceptual Chen notation. In the relational schema (1NF), they are flattened into atomic individual columns.
  - **Multivalued Attribute:** `USER.phone` allows a responder or analyst to have multiple phone numbers (e.g., Mobile, Desk Phone, On-call Pager). In Chen notation, it is drawn as a **double oval**. To adhere to First Normal Form (1NF), it is mapped to an independent table: `USER_PHONES(user_id, phone_number, phone_type)`, where `(user_id, phone_number)` forms the composite primary key.

### Q3: Why is `duration` in `INCIDENT` a Derived Attribute?
- **Model Answer:**
  Storing duration directly violates normalization principles because it causes redundancy: $\text{Duration} = \text{resolved\_at} - \text{detected\_at}$. If someone updates the resolution timestamp, a stored duration column would become inconsistent. Therefore, in the ER diagram, it is represented as a **dashed oval (derived attribute)** and dynamically calculated using SQL expressions, PL/SQL functions (`FN_CALC_INCIDENT_DURATION_HOURS`), or database views.

### Q4: How did you implement the 1:N relationship between `INCIDENT` and `INVESTIGATION`?
- **Model Answer:**
  Each investigation stores `incident_id` as a foreign key. That foreign key is not unique, so an incident can have multiple investigation rows. The stored procedure creates an initial investigation when it logs a new incident; additional investigations can be entered later.

### Q5: How do you prove your database is in 3NF and BCNF?
- **Model Answer:**
  1. **1NF:** All attribute values are atomic; multivalued phone numbers are normalized into `USER_PHONES`; every table has a primary key.
  2. **2NF:** The core ER tables use single-column primary keys; the separate `USER_PHONES` support table uses `(user_id, phone_number)` as its key.
  3. **3NF:** No transitive functional dependencies exist ($X \rightarrow Y$ and $Y \rightarrow Z$). Non-key attributes depend only on the primary key.
  4. **BCNF:** For every functional dependency $X \rightarrow Y$, the determinant $X$ is a superkey.

---

## 3. TOP FACULTY QUESTIONS ON PL/SQL & DATABASE INTEGRITY

### Q6: What PL/SQL Stored Procedures did you build, and why?
- **Model Answer:**
  - **Procedure 1 (`SP_LOG_INCIDENT_WITH_INVESTIGATION`):** Atomically inserts an incident and its initial investigation, determines investigation priority from severity, and updates the asset status.
  - **Procedure 2 (`SP_RESOLVE_INCIDENT`):** Safely closes an incident. It updates `resolved_at`, writes the post-mortem resolution summary, marks the investigation `'COMPLETED'`, and resets the asset status back to `'ACTIVE'` only if no other active incidents remain on that asset.

### Q7: What PL/SQL Functions did you write?
- **Model Answer:**
  - **Function 1 (`FN_CALC_INCIDENT_DURATION_HOURS`):** Computes turnaround duration in hours between `detected_at` and `resolved_at` (or current timestamp if still ongoing). Implements the derived attribute cleanly.
  - **Function 2 (`FN_GET_ASSET_RISK_SCORE`):** Dynamically calculates an asset's risk score (0–100) based on asset criticality tier (e.g., CRITICAL = 30 pts), count of active unpatched CVEs (15 pts each), and pending high-severity alerts (8 pts each).

### Q8: What Cursors did you use?
- **Model Answer:**
  We implemented an explicit cursor in `SP_AUDIT_UNPATCHED_VULNERABILITIES`. It declares `CURSOR cur_overdue_vulns IS ...`, opens it, fetches rows in a loop (`FETCH ... INTO`), checks `%NOTFOUND`, calculates days overdue ($T_{\text{sysdate}} - T_{\text{deadline}}$), outputs compliance warnings via `DBMS_OUTPUT`, and closes the cursor.

### Q9: What Database Triggers did you implement?
- **Model Answer:**
  - **Trigger 1 (`TRG_PREVENT_EVIDENCE_TAMPERING`):** A `BEFORE UPDATE OR DELETE ON EVIDENCE` row-level trigger. If `:OLD.integrity_status = 'VERIFIED'`, it immediately aborts the transaction via `RAISE_APPLICATION_ERROR(-20001, ...)`. This enforces legal forensic chain-of-custody rules.
  - **Trigger 2 (`TRG_AUTO_UPDATE_ASSET_ON_INCIDENT`):** An `AFTER INSERT ON INCIDENTS` row-level trigger. Whenever an incident with severity `'CRITICAL'` is inserted, it automatically updates `ASSETS.asset_status = 'COMPROMISED'` for the target machine.

---

## 4. THE 5-STAGE INTERACTIVE TRANSACTION EXPLANATION (GUIDELINE POINT 4)

During your viva / demonstration, the evaluator will ask you to explain an interactive transaction. Use this exact 5-point explanation:

| Question Prompt | Student Response for CIRDEMS |
| :--- | :--- |
| **1. What operation is being performed?** | Emergency Incident Triage & Automated Investigation Spawning. |
| **2. Which table(s) are involved?** | `INCIDENTS`, `INVESTIGATIONS`, and `ASSETS`. |
| **3. Which SQL/PL/SQL component is executed?** | Stored Procedure `SP_LOG_INCIDENT_WITH_INVESTIGATION` and Trigger `TRG_AUTO_UPDATE_ASSET_ON_INCIDENT`. |
| **4. How is the database affected?** | A new row is inserted into `INCIDENTS`; an initial row is inserted into `INVESTIGATIONS`; the trigger updates the asset status for a critical incident. The ER relationship permits additional investigation rows. |
| **5. What result is generated?** | A confirmed Incident ID and Investigation ID are returned to the caller; SOC monitoring displays the asset in red compromise state. |

---

## 5. ER relationship quick reference

| Parent entity | Relationship | Child entity | Cardinality |
|---|---|---|---|
| User | reports | Incident | 1:N |
| Asset | has incidents | Incident | 1:N |
| Incident | has | Response_Action | 1:N |
| Incident | generates | Report | 1:N |
| Incident | involves | Investigation | 1:N |
| Incident | collects | Evidence | 1:N |
| Incident | has | Vulnerability | 1:N |
| Evidence | is recorded in | Chain_of_Custody | 1:N |

---

## 6. COMMAND EXECUTION QUICK REFERENCE

### Running in Oracle SQL*Plus:
```sql
-- Connect to Oracle XE
sqlplus system/oracle@localhost:1521/XEPDB1

-- Run all CIRDEMS scripts in sequence
@run_all.sql
```

### Running the Python Interactive SOC Console:
```powershell
# From project root:
py app/app.py

# Open in Browser:
# http://localhost:5000
```
