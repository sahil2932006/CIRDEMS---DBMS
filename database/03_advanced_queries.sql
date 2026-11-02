-- ============================================================================
-- CYBER INCIDENT RESPONSE & DIGITAL EVIDENCE MANAGEMENT SYSTEM (CIRDEMS)
-- FILE: 03_advanced_queries.sql
-- DESCRIPTION: 15 Meaningful Analytical SQL Queries Across Multiple Categories
-- ============================================================================

SET PAGESIZE 100;
SET LINESIZE 200;
SET FEEDBACK ON;

PROMPT ============================================================================;
PROMPT CATEGORY 1: COMPLEX MULTI-TABLE JOINS (INNER, LEFT OUTER)
PROMPT ============================================================================;

-- ----------------------------------------------------------------------------
-- QUERY 1: Unified SOC Incident Tracking Dashboard (5-Table Join)
-- Description: Joins INCIDENTS, ASSETS, USERS (Reporter), INVESTIGATIONS, and
-- USERS (Lead Investigator) to present a consolidated overview of all active incidents.
-- ----------------------------------------------------------------------------
PROMPT --- Query 1: Active Incident Oversight ---;
SELECT 
    i.incident_id,
    SUBSTR(i.incident_title, 1, 35) AS incident_title,
    i.severity,
    a.asset_name,
    a.ip_address,
    u_rep.first_name || ' ' || u_rep.last_name AS reported_by,
    NVL(u_lead.first_name || ' ' || u_lead.last_name, 'UNASSIGNED') AS lead_investigator,
    inv.investigation_status,
    inv.priority AS inv_priority
FROM INCIDENTS i
JOIN ASSETS a ON i.asset_id = a.asset_id
JOIN USERS u_rep ON i.reporter_user_id = u_rep.user_id
LEFT JOIN INVESTIGATIONS inv ON i.incident_id = inv.incident_id
LEFT JOIN USERS u_lead ON inv.lead_user_id = u_lead.user_id
WHERE i.status != 'CLOSED'
ORDER BY CASE i.severity 
    WHEN 'CRITICAL' THEN 1 
    WHEN 'HIGH' THEN 2 
    WHEN 'MEDIUM' THEN 3 
    ELSE 4 END;

-- ----------------------------------------------------------------------------
-- QUERY 2: Digital Evidence Forensic Chain of Custody Audit
-- Description: Cross-references weak entity EVIDENCE with parent INVESTIGATIONS,
-- INCIDENTS, and the forensic examiner USER who collected the artifact.
-- ----------------------------------------------------------------------------
PROMPT --- Query 2: Digital Evidence Custody Audit ---;
SELECT 
    e.investigation_id,
    e.evidence_id,
    SUBSTR(e.file_name, 1, 25) AS file_name,
    e.evidence_type,
    SUBSTR(e.hash_value, 1, 16) || '...' AS sha256_prefix,
    e.integrity_status,
    u.first_name || ' ' || u.last_name AS examiner_name,
    SUBSTR(i.incident_title, 1, 30) AS incident_title
FROM EVIDENCE e
JOIN INVESTIGATIONS inv ON e.investigation_id = inv.investigation_id
JOIN INCIDENTS i ON inv.incident_id = i.incident_id
LEFT JOIN USERS u ON e.collected_by = u.user_id
ORDER BY e.investigation_id, e.evidence_id;

-- ----------------------------------------------------------------------------
-- QUERY 3: Assets Experiencing Critical Incidents & Unpatched CVEs (Correlated Subquery)
-- Description: Uses correlated EXISTS subqueries to detect assets in critical jeopardy.
-- ----------------------------------------------------------------------------
PROMPT --- Query 3: High-Jeopardy Assets (Correlated Subquery) ---;
SELECT 
    a.asset_id,
    a.asset_name,
    a.asset_type,
    a.criticality,
    a.ip_address,
    a.asset_status
FROM ASSETS a
WHERE EXISTS (
    SELECT 1 FROM INCIDENTS i 
    WHERE i.asset_id = a.asset_id 
    AND i.severity IN ('HIGH', 'CRITICAL') 
    AND i.status NOT IN ('RESOLVED', 'CLOSED')
)
AND EXISTS (
    SELECT 1 FROM VULNERABILITIES v 
    WHERE v.asset_id = a.asset_id 
    AND v.patch_status = 'OPEN'
);

PROMPT ============================================================================;
PROMPT CATEGORY 2: AGGREGATIONS, GROUP BY, AND HAVING CLAUSES
PROMPT ============================================================================;

-- ----------------------------------------------------------------------------
-- QUERY 4: Mean Resolution Turnaround Time (MTTR) by Asset Criticality
-- Description: Computes total incidents, resolved counts, and average resolution
-- hours grouped by asset criticality tier.
-- ----------------------------------------------------------------------------
PROMPT --- Query 4: Incident MTTR by Asset Criticality ---;
SELECT 
    a.criticality,
    COUNT(i.incident_id) AS total_incidents,
    COUNT(i.resolved_at) AS resolved_incidents,
    ROUND(AVG(
        CASE WHEN i.resolved_at IS NOT NULL 
        THEN (CAST(i.resolved_at AS DATE) - CAST(i.detected_at AS DATE)) * 24 
        ELSE NULL END
    ), 2) AS avg_resolution_hours
FROM ASSETS a
JOIN INCIDENTS i ON a.asset_id = i.asset_id
GROUP BY a.criticality
ORDER BY total_incidents DESC;

-- ----------------------------------------------------------------------------
-- QUERY 5: High-Alert Density Assets Exceeding Confidence Threshold (HAVING Clause)
-- Description: Identifies assets with > 1 alert and an average confidence score > 70.
-- ----------------------------------------------------------------------------
PROMPT --- Query 5: High-Alert Density Assets (HAVING Clause) ---;
SELECT 
    a.asset_id,
    a.asset_name,
    a.ip_address,
    COUNT(al.alert_id) AS alert_count,
    ROUND(AVG(al.confidence_score), 1) AS avg_confidence
FROM ASSETS a
JOIN ALERTS al ON a.asset_id = al.asset_id
GROUP BY a.asset_id, a.asset_name, a.ip_address
HAVING COUNT(al.alert_id) > 1 AND AVG(al.confidence_score) > 70
ORDER BY avg_confidence DESC;

-- ----------------------------------------------------------------------------
-- QUERY 6: Threat Indicator Distribution Across Attack Categories
-- Description: Aggregates active threat IOCs by category with confidence statistics.
-- ----------------------------------------------------------------------------
PROMPT --- Query 6: Threat Indicator Distribution by Category ---;
SELECT 
    ind.threat_category,
    COUNT(ind.indicator_id) AS total_iocs,
    MIN(ind.confidence) AS min_confidence,
    MAX(ind.confidence) AS max_confidence,
    ROUND(AVG(ind.confidence), 1) AS avg_confidence
FROM INDICATORS ind
WHERE ind.status = 'ACTIVE'
GROUP BY ind.threat_category
HAVING COUNT(ind.indicator_id) >= 1
ORDER BY total_iocs DESC;

PROMPT ============================================================================;
PROMPT CATEGORY 3: NESTED SUBQUERIES AND SET OPERATIONS (UNION, INTERSECT, MINUS)
PROMPT ============================================================================;

-- ----------------------------------------------------------------------------
-- QUERY 7: Assets Clean of Any Open Incidents (NOT EXISTS Subquery)
-- Description: Identifies all digital assets with zero active or pending investigations.
-- ----------------------------------------------------------------------------
PROMPT --- Query 7: Assets Without Active Incidents (NOT EXISTS) ---;
SELECT 
    a.asset_id, 
    a.asset_name, 
    a.asset_type, 
    a.operating_system, 
    a.location
FROM ASSETS a
WHERE NOT EXISTS (
    SELECT 1 FROM INCIDENTS i 
    WHERE i.asset_id = a.asset_id 
    AND i.status IN ('DETECTED', 'INVESTIGATING', 'CONTAINED')
);

-- ----------------------------------------------------------------------------
-- QUERY 8: Users Who Reported Incidents but Never Performed Actions (MINUS)
-- Description: Demonstrates relational set difference (MINUS).
-- ----------------------------------------------------------------------------
PROMPT --- Query 8: Incident Reporters Who Never Executed Actions (MINUS) ---;
SELECT user_id, first_name || ' ' || last_name AS full_name, email, role
FROM USERS
WHERE user_id IN (
    SELECT reporter_user_id FROM INCIDENTS
    MINUS
    SELECT performed_by FROM RESPONSE_ACTIONS WHERE performed_by IS NOT NULL
);

-- ----------------------------------------------------------------------------
-- QUERY 9: Assets with Both High Alerts and Open Vulnerabilities (INTERSECT)
-- Description: Uses set intersection to find overlapping high-risk asset IDs.
-- ----------------------------------------------------------------------------
PROMPT --- Query 9: High Alert & Open Vuln Asset Intersection (INTERSECT) ---;
SELECT asset_id FROM ALERTS WHERE severity IN ('HIGH', 'CRITICAL')
INTERSECT
SELECT asset_id FROM VULNERABILITIES WHERE patch_status IN ('OPEN', 'IN_PROGRESS');

PROMPT ============================================================================;
PROMPT CATEGORY 4: ANALYTICAL & WINDOW FUNCTIONS
PROMPT ============================================================================;

-- ----------------------------------------------------------------------------
-- QUERY 10: Chronological Incident Severity Ranking per Asset (DENSE_RANK)
-- Description: Partitions incidents by asset and applies DENSE_RANK based on severity.
-- ----------------------------------------------------------------------------
PROMPT --- Query 10: Ranked Incident Severity per Asset (DENSE_RANK) ---;
SELECT 
    i.incident_id,
    a.asset_name,
    SUBSTR(i.incident_title, 1, 35) AS incident_title,
    i.severity,
    TO_CHAR(i.detected_at, 'YYYY-MM-DD HH24:MI') AS detected_time,
    DENSE_RANK() OVER (
        PARTITION BY i.asset_id 
        ORDER BY CASE i.severity 
            WHEN 'CRITICAL' THEN 1 
            WHEN 'HIGH' THEN 2 
            WHEN 'MEDIUM' THEN 3 
            ELSE 4 END, i.detected_at ASC
    ) AS asset_incident_rank
FROM INCIDENTS i
JOIN ASSETS a ON i.asset_id = a.asset_id;

-- ----------------------------------------------------------------------------
-- QUERY 11: Cumulative Response Actions Executed per Investigation (Running Total)
-- Description: Evaluates cumulative response actions over time using window frames.
-- ----------------------------------------------------------------------------
PROMPT --- Query 11: Cumulative Actions Taken (Window Framing) ---;
SELECT 
    ra.action_id,
    ra.investigation_id,
    ra.action_type,
    TO_CHAR(ra.executed_at, 'YYYY-MM-DD HH24:MI') AS executed_time,
    ra.result,
    COUNT(ra.action_id) OVER (
        PARTITION BY ra.investigation_id 
        ORDER BY ra.executed_at 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_actions_taken
FROM RESPONSE_ACTIONS ra;

-- ----------------------------------------------------------------------------
-- QUERY 12: Lead Investigator Performance League (RANK Window Function)
-- Description: Ranks investigators based on closed forensic investigations.
-- ----------------------------------------------------------------------------
PROMPT --- Query 12: Investigator Performance Ranking (RANK) ---;
SELECT 
    u.user_id,
    u.first_name || ' ' || u.last_name AS lead_analyst,
    u.role,
    COUNT(inv.investigation_id) AS closed_investigations,
    RANK() OVER (ORDER BY COUNT(inv.investigation_id) DESC) AS performance_rank
FROM USERS u
JOIN INVESTIGATIONS inv ON u.user_id = inv.lead_user_id
WHERE inv.investigation_status = 'COMPLETED'
GROUP BY u.user_id, u.first_name, u.last_name, u.role;

PROMPT ============================================================================;
PROMPT CATEGORY 5: STRING OPERATIONS, SUBNETTING, AND DERIVED DURATION
PROMPT ============================================================================;

-- ----------------------------------------------------------------------------
-- QUERY 13: Network Subnet Segmentation & Host Compromise Density
-- Description: Uses SUBSTR and INSTR to parse IP address subnets and compute stats.
-- ----------------------------------------------------------------------------
PROMPT --- Query 13: Subnet Segmentation & Compromised Counts ---;
SELECT 
    SUBSTR(ip_address, 1, INSTR(ip_address, '.', 1, 3) - 1) AS subnet_prefix,
    COUNT(asset_id) AS total_assets_in_subnet,
    SUM(CASE WHEN asset_status IN ('COMPROMISED', 'ISOLATED') THEN 1 ELSE 0 END) AS compromised_count
FROM ASSETS
GROUP BY SUBSTR(ip_address, 1, INSTR(ip_address, '.', 1, 3) - 1)
ORDER BY compromised_count DESC;

-- ----------------------------------------------------------------------------
-- QUERY 14: Overdue Vulnerability Remediation Tracking
-- Description: Identifies unpatched CVEs where the remediation deadline has lapsed.
-- ----------------------------------------------------------------------------
PROMPT --- Query 14: Overdue Vulnerabilities Past Deadline ---;
SELECT 
    v.cve_code,
    SUBSTR(v.vulnerability_title, 1, 40) AS vuln_title,
    v.severity,
    a.asset_name,
    TO_CHAR(v.remediation_deadline, 'YYYY-MM-DD') AS deadline,
    ROUND(CAST(SYSDATE AS DATE) - CAST(v.remediation_deadline AS DATE)) AS days_overdue
FROM VULNERABILITIES v
JOIN ASSETS a ON v.asset_id = a.asset_id
WHERE v.patch_status = 'OPEN' 
AND v.remediation_deadline < SYSDATE
ORDER BY days_overdue DESC;

-- ----------------------------------------------------------------------------
-- QUERY 15: Derived Incident Duration Computation
-- Description: Dynamically evaluates the derived attribute 'duration' for closed cases.
-- ----------------------------------------------------------------------------
PROMPT --- Query 15: Derived Incident Duration Derivation ---;
SELECT 
    i.incident_id,
    SUBSTR(i.incident_title, 1, 35) AS incident_title,
    i.severity,
    TO_CHAR(i.detected_at, 'YYYY-MM-DD HH24:MI') AS detected,
    TO_CHAR(i.resolved_at, 'YYYY-MM-DD HH24:MI') AS resolved,
    TRUNC(CAST(i.resolved_at AS DATE) - CAST(i.detected_at AS DATE)) || 'd ' ||
    TRUNC(MOD((CAST(i.resolved_at AS DATE) - CAST(i.detected_at AS DATE)) * 24, 24)) || 'h ' ||
    ROUND(MOD((CAST(i.resolved_at AS DATE) - CAST(i.detected_at AS DATE)) * 1440, 60)) || 'm' AS calculated_duration
FROM INCIDENTS i
WHERE i.resolved_at IS NOT NULL;
