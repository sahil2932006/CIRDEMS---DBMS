-- ============================================================================
-- CYBER INCIDENT RESPONSE & DIGITAL EVIDENCE MANAGEMENT SYSTEM (CIRDEMS)
-- FILE: 04_plsql_components.sql
-- DESCRIPTION: Stored Procedures, Functions, Explicit Cursor & Triggers
-- ============================================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================================;
PROMPT 1. CREATING PL/SQL STORED PROCEDURES
PROMPT ============================================================================;

-- ----------------------------------------------------------------------------
-- PROCEDURE 1: SP_LOG_INCIDENT_WITH_INVESTIGATION
-- Business Logic: Atomically logs a new incident, spawns an initial investigation,
-- and updates the asset's operational status to 'UNDER_INVESTIGATION'.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_LOG_INCIDENT_WITH_INVESTIGATION (
    p_asset_id          IN  NUMBER,
    p_reporter_user_id  IN  NUMBER,
    p_title             IN  VARCHAR2,
    p_type              IN  VARCHAR2,
    p_severity          IN  VARCHAR2,
    p_description       IN  VARCHAR2,
    p_source            IN  VARCHAR2,
    p_impact_level      IN  VARCHAR2,
    p_lead_user_id      IN  NUMBER,
    p_methodology       IN  VARCHAR2,
    o_incident_id       OUT NUMBER,
    o_investigation_id  OUT NUMBER
) AS
    v_priority VARCHAR2(20);
BEGIN
    -- Determine investigation priority based on incident severity
    IF p_severity = 'CRITICAL' THEN
        v_priority := 'P1_URGENT';
    ELSIF p_severity = 'HIGH' THEN
        v_priority := 'P2_HIGH';
    ELSIF p_severity = 'MEDIUM' THEN
        v_priority := 'P3_MEDIUM';
    ELSE
        v_priority := 'P4_LOW';
    END IF;

    -- 1. Insert confirmed Incident record
    INSERT INTO INCIDENTS (
        asset_id, reporter_user_id, incident_title, incident_type,
        severity, description, detected_at, reported_at, status,
        source, impact_level
    ) VALUES (
        p_asset_id, p_reporter_user_id, p_title, p_type,
        p_severity, p_description, SYSTIMESTAMP, SYSTIMESTAMP, 'INVESTIGATING',
        p_source, p_impact_level
    ) RETURNING incident_id INTO o_incident_id;

-- 2. Spawn an initial investigation; additional investigations can be added later.
    INSERT INTO INVESTIGATIONS (
        incident_id, lead_user_id, start_time, priority,
        investigation_status, methodology, created_at
    ) VALUES (
        o_incident_id, p_lead_user_id, SYSTIMESTAMP, v_priority,
        'OPEN', p_methodology, SYSTIMESTAMP
    ) RETURNING investigation_id INTO o_investigation_id;

    -- 3. Update Asset operational status
    UPDATE ASSETS
    SET asset_status = 'UNDER_INVESTIGATION'
    WHERE asset_id = p_asset_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('>>> [SUCCESS] Incident #' || o_incident_id || ' logged. Spawned Investigation #' || o_investigation_id);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('>>> [ERROR] Failed to log incident: ' || SQLERRM);
        RAISE;
END SP_LOG_INCIDENT_WITH_INVESTIGATION;
/

-- ----------------------------------------------------------------------------
-- PROCEDURE 2: SP_RESOLVE_INCIDENT
-- Business Logic: Closes an incident, sets resolved timestamp, writes resolution
-- summary, marks the investigation completed, and resets asset status to 'ACTIVE'.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_RESOLVE_INCIDENT (
    p_incident_id         IN NUMBER,
    p_resolution_summary  IN VARCHAR2,
    p_investigation_concl IN VARCHAR2
) AS
    v_asset_id NUMBER(10);
BEGIN
    -- Validate existence and retrieve asset ID
    SELECT asset_id INTO v_asset_id
    FROM INCIDENTS
    WHERE incident_id = p_incident_id;

    -- 1. Update Incident record
    UPDATE INCIDENTS
    SET status = 'RESOLVED',
        resolved_at = SYSTIMESTAMP,
        resolution_summary = p_resolution_summary
    WHERE incident_id = p_incident_id;

    -- 2. Mark Investigation completed
    UPDATE INVESTIGATIONS
    SET investigation_status = 'COMPLETED',
        end_time = SYSTIMESTAMP,
        conclusion = p_investigation_concl
    WHERE incident_id = p_incident_id;

    -- 3. Restore Asset status to ACTIVE if no other open incidents exist on this asset
    UPDATE ASSETS
    SET asset_status = 'ACTIVE'
    WHERE asset_id = v_asset_id
    AND NOT EXISTS (
        SELECT 1 FROM INCIDENTS 
        WHERE asset_id = v_asset_id 
        AND status IN ('DETECTED', 'INVESTIGATING', 'CONTAINED')
        AND incident_id != p_incident_id
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('>>> [RESOLVED] Incident #' || p_incident_id || ' resolved and investigation completed successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('>>> [ERROR] Incident ID ' || p_incident_id || ' does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END SP_RESOLVE_INCIDENT;
/

PROMPT ============================================================================;
PROMPT 2. CREATING PL/SQL STORED FUNCTIONS
PROMPT ============================================================================;

-- ----------------------------------------------------------------------------
-- FUNCTION 1: FN_CALC_INCIDENT_DURATION_HOURS
-- Business Logic: Calculates precise turnaround hours for an incident.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION FN_CALC_INCIDENT_DURATION_HOURS (
    p_incident_id IN NUMBER
) RETURN NUMBER AS
    v_detected TIMESTAMP;
    v_resolved TIMESTAMP;
    v_duration_hours NUMBER;
BEGIN
    SELECT detected_at, resolved_at 
    INTO v_detected, v_resolved
    FROM INCIDENTS
    WHERE incident_id = p_incident_id;

    IF v_resolved IS NULL THEN
        v_duration_hours := ROUND((CAST(SYSTIMESTAMP AS DATE) - CAST(v_detected AS DATE)) * 24, 2);
    ELSE
        v_duration_hours := ROUND((CAST(v_resolved AS DATE) - CAST(v_detected AS DATE)) * 24, 2);
    END IF;

    RETURN v_duration_hours;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN -1;
    WHEN OTHERS THEN
        RETURN NULL;
END FN_CALC_INCIDENT_DURATION_HOURS;
/

-- ----------------------------------------------------------------------------
-- FUNCTION 2: FN_GET_ASSET_RISK_SCORE
-- Business Logic: Computes dynamic security risk rating (0 - 100) based on asset
-- criticality, open CVE count, and unacknowledged alerts.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION FN_GET_ASSET_RISK_SCORE (
    p_asset_id IN NUMBER
) RETURN NUMBER AS
    v_criticality VARCHAR2(20);
    v_crit_weight NUMBER := 10;
    v_vuln_count  NUMBER := 0;
    v_alert_count NUMBER := 0;
    v_total_score NUMBER := 0;
BEGIN
    SELECT criticality INTO v_criticality
    FROM ASSETS
    WHERE asset_id = p_asset_id;

    IF v_criticality = 'CRITICAL' THEN
        v_crit_weight := 30;
    ELSIF v_criticality = 'HIGH' THEN
        v_crit_weight := 20;
    ELSIF v_criticality = 'MEDIUM' THEN
        v_crit_weight := 10;
    ELSE
        v_crit_weight := 5;
    END IF;

    SELECT COUNT(*) INTO v_vuln_count
    FROM VULNERABILITIES
    WHERE asset_id = p_asset_id AND patch_status IN ('OPEN', 'IN_PROGRESS');

    SELECT COUNT(*) INTO v_alert_count
    FROM ALERTS
    WHERE asset_id = p_asset_id AND alert_status IN ('NEW', 'ESCALATED');

    v_total_score := v_crit_weight + (v_vuln_count * 15) + (v_alert_count * 8);
    IF v_total_score > 100 THEN
        v_total_score := 100;
    END IF;

    RETURN v_total_score;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END FN_GET_ASSET_RISK_SCORE;
/

PROMPT ============================================================================;
PROMPT 3. CREATING PL/SQL EXPLICIT CURSOR COMPONENT
-- ----------------------------------------------------------------------------
-- CURSOR: SP_AUDIT_UNPATCHED_VULNERABILITIES
-- Business Logic: Declares and opens an explicit cursor iterating through overdue
-- CVE vulnerabilities to output a compliance audit log.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_AUDIT_UNPATCHED_VULNERABILITIES AS
    CURSOR cur_overdue_vulns IS
        SELECT 
            v.vulnerability_id,
            v.cve_code,
            v.severity,
            a.asset_name,
            a.ip_address,
            v.remediation_deadline,
            ROUND(CAST(SYSDATE AS DATE) - CAST(v.remediation_deadline AS DATE)) AS days_overdue
        FROM VULNERABILITIES v
        JOIN ASSETS a ON v.asset_id = a.asset_id
        WHERE v.patch_status = 'OPEN' 
        AND v.remediation_deadline < SYSDATE
        ORDER BY days_overdue DESC;

    r_vuln cur_overdue_vulns%ROWTYPE;
    v_processed_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('           OVERDUE ASSET VULNERABILITY AUDIT REPORT                     ');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');

    OPEN cur_overdue_vulns;
    LOOP
        FETCH cur_overdue_vulns INTO r_vuln;
        EXIT WHEN cur_overdue_vulns%NOTFOUND;

        v_processed_count := v_processed_count + 1;
        DBMS_OUTPUT.PUT_LINE(
            '[' || r_vuln.severity || '] ' || r_vuln.cve_code || 
            ' | Asset: ' || r_vuln.asset_name || ' (' || r_vuln.ip_address || ')' ||
            ' | Overdue: ' || r_vuln.days_overdue || ' days'
        );
    END LOOP;
    CLOSE cur_overdue_vulns;

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total overdue vulnerability findings identified: ' || v_processed_count);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------');
END SP_AUDIT_UNPATCHED_VULNERABILITIES;
/

PROMPT ============================================================================;
PROMPT 4. CREATING PL/SQL DATABASE TRIGGERS
PROMPT ============================================================================;

-- ----------------------------------------------------------------------------
-- TRIGGER 1: TRG_PREVENT_EVIDENCE_TAMPERING
-- Business Logic: Prohibits UPDATE or DELETE on any evidence item marked 'VERIFIED'.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_PREVENT_EVIDENCE_TAMPERING
BEFORE UPDATE OR DELETE ON EVIDENCE
FOR EACH ROW
BEGIN
    IF :OLD.integrity_status = 'VERIFIED' THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'LEGAL INTEGRITY VIOLATION: Digital Evidence Item #' || :OLD.evidence_id || 
            ' in Investigation #' || :OLD.investigation_id || 
            ' is marked as VERIFIED and cannot be modified or deleted.'
        );
    END IF;
END;
/

-- ----------------------------------------------------------------------------
-- TRIGGER 2: TRG_AUTO_UPDATE_ASSET_ON_INCIDENT
-- Business Logic: Automatically marks asset status as 'COMPROMISED' on CRITICAL incidents.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_AUTO_UPDATE_ASSET_ON_INCIDENT
AFTER INSERT ON INCIDENTS
FOR EACH ROW
BEGIN
    IF :NEW.severity = 'CRITICAL' THEN
        UPDATE ASSETS
        SET asset_status = 'COMPROMISED'
        WHERE asset_id = :NEW.asset_id;
    END IF;
END;
/

PROMPT ============================================================================;
PROMPT 5. VERIFICATION & EXECUTION TEST BLOCK
PROMPT ============================================================================;

DECLARE
    v_inc_id NUMBER;
    v_inv_id NUMBER;
    v_dur    NUMBER;
    v_risk   NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- 1. Testing Function: FN_GET_ASSET_RISK_SCORE ---');
    v_risk := FN_GET_ASSET_RISK_SCORE(4);
    DBMS_OUTPUT.PUT_LINE('Risk score for Asset #4 (WEB-PORTAL-PROD): ' || v_risk || '/100');

    DBMS_OUTPUT.PUT_LINE('--- 2. Testing Function: FN_CALC_INCIDENT_DURATION_HOURS ---');
    v_dur := FN_CALC_INCIDENT_DURATION_HOURS(3);
    DBMS_OUTPUT.PUT_LINE('Duration for Incident #3: ' || v_dur || ' hours');

    DBMS_OUTPUT.PUT_LINE('--- 3. Testing Cursor Procedure: SP_AUDIT_UNPATCHED_VULNERABILITIES ---');
    SP_AUDIT_UNPATCHED_VULNERABILITIES;
END;
/

PROMPT ============================================================================;
PROMPT PL/SQL SUITE COMPILED & TESTED SUCCESSFULLY!
PROMPT ============================================================================;
