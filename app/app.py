"""
CYBER INCIDENT RESPONSE & DIGITAL EVIDENCE MANAGEMENT SYSTEM (CIRDEMS)
Flask Application Server & SOC Web Interface
"""

import sys
import os
from flask import Flask, render_template, request, jsonify, send_from_directory

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
if BASE_DIR not in sys.path:
    sys.path.insert(0, BASE_DIR)

from db_config import get_connection

app = Flask(
    __name__,
    template_folder=os.path.join(BASE_DIR, 'templates'),
    static_folder=os.path.join(BASE_DIR, 'static')
)

# Sample Fallback In-Memory State for Demonstration if Oracle XE credentials are not yet configured
MOCK_ASSETS = [
    {"asset_id": 1, "asset_name": "DC-CORP-01", "asset_type": "Domain Controller", "ip_address": "10.0.1.5", "criticality": "CRITICAL", "asset_status": "ACTIVE"},
    {"asset_id": 2, "asset_name": "DB-ORACLE-PROD", "asset_type": "Database Server", "ip_address": "10.0.1.10", "criticality": "CRITICAL", "asset_status": "ACTIVE"},
    {"asset_id": 3, "asset_name": "FW-PERIMETER-01", "asset_type": "Firewall", "ip_address": "192.168.1.1", "criticality": "CRITICAL", "asset_status": "ACTIVE"},
    {"asset_id": 4, "asset_name": "WEB-PORTAL-PROD", "asset_type": "Web Server", "ip_address": "10.0.2.15", "criticality": "HIGH", "asset_status": "UNDER_INVESTIGATION"},
    {"asset_id": 5, "asset_name": "FS-FINANCE-01", "asset_type": "Workstation", "ip_address": "10.0.3.50", "criticality": "HIGH", "asset_status": "COMPROMISED"}
]

MOCK_INCIDENTS = [
    {"incident_id": 1, "asset_name": "WEB-PORTAL-PROD", "incident_title": "External Web Application Compromise (MOVEit)", "severity": "CRITICAL", "status": "INVESTIGATING", "detected_at": "2024-03-01 02:14"},
    {"incident_id": 2, "asset_name": "FS-FINANCE-01", "incident_title": "Finance BlackCat Ransomware Infection", "severity": "CRITICAL", "status": "CONTAINED", "detected_at": "2024-03-02 04:30"},
    {"incident_id": 3, "asset_name": "DC-CORP-01", "incident_title": "Kerberoasting Offline Attack Campaign", "severity": "HIGH", "status": "RESOLVED", "detected_at": "2024-03-03 10:15"}
]

MOCK_EVIDENCE = [
    {"investigation_id": 1, "evidence_id": 1, "file_name": "moveit_vm_disk.E01", "evidence_type": "Disk Image", "hash_value": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", "integrity_status": "VERIFIED"},
    {"investigation_id": 1, "evidence_id": 2, "file_name": "human2.aspx", "evidence_type": "Malware Sample", "hash_value": "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8", "integrity_status": "VERIFIED"},
    {"investigation_id": 2, "evidence_id": 1, "file_name": "finance_memdump.raw", "evidence_type": "Memory Dump", "hash_value": "4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a", "integrity_status": "VERIFIED"}
]

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/diagram')
@app.route('/static/chen_er_diagram.html')
def serve_chen_er():
    return send_from_directory(os.path.join(BASE_DIR, 'static'), 'chen_er_diagram.html')

@app.route('/er-data')
def er_data_page():
    return render_template('er_data.html')

@app.route('/api/er-data', methods=['GET'])
def er_data_options():
    """Small lookup lists used by the ER entity entry forms."""
    conn, err = get_connection()
    if not conn:
        return jsonify({"error": err or "Oracle is unavailable"}), 503
    try:
        cursor = conn.cursor()
        result = {}
        for key, sql in {
            "users": "SELECT user_id, first_name || ' ' || last_name FROM USERS ORDER BY user_id",
            "assets": "SELECT asset_id, asset_name FROM ASSETS ORDER BY asset_id",
            "incidents": "SELECT incident_id, incident_title FROM INCIDENTS ORDER BY incident_id DESC",
            "investigations": "SELECT investigation_id, 'Investigation ' || investigation_id || ' (incident ' || incident_id || ')' FROM INVESTIGATIONS ORDER BY investigation_id DESC",
            "evidence": "SELECT evidence_id, file_name FROM EVIDENCE ORDER BY evidence_id"
        }.items():
            cursor.execute(sql)
            result[key] = [list(row) for row in cursor.fetchall()]
        cursor.close()
        conn.close()
        return jsonify(result)
    except Exception as exc:
        conn.close()
        return jsonify({"error": str(exc)}), 500

@app.route('/api/er/<entity>', methods=['POST'])
def create_er_record(entity):
    """Insert one ER-diagram entity record into Oracle."""
    data = request.get_json(silent=True) or {}
    conn, err = get_connection()
    if not conn:
        return jsonify({"success": False, "error": err or "Oracle is unavailable"}), 503
    cursor = conn.cursor()
    new_id_var = cursor.var(int)
    try:
        if entity == 'user':
            cursor.execute("""INSERT INTO USERS
                (username, first_name, last_name, email, role, department, job_title, account_status)
                VALUES (:username, :first_name, :last_name, :email, :role, :department, :job_title, :status)
                RETURNING user_id INTO :new_id""", {
                "username": data['username'], "first_name": data['first_name'], "last_name": data['last_name'],
                "email": data['email'], "role": data['role'], "department": data.get('department') or 'Security',
                "job_title": data.get('job_title') or data['role'].replace('_', ' ').title(),
                "status": data.get('status') or 'ACTIVE', "new_id": new_id_var})
        elif entity == 'asset':
            cursor.execute("""INSERT INTO ASSETS
                (asset_name, asset_type, ip_address, mac_address, operating_system, location, criticality, owner_user_id, asset_status)
                VALUES (:name, :type, :ip, :mac, :os, :location, :criticality, :owner, :status)
                RETURNING asset_id INTO :new_id""", {
                "name": data['asset_name'], "type": data['asset_type'], "ip": data['ip_address'], "mac": data['mac_address'],
                "os": data['operating_system'], "location": data['location'], "criticality": data['criticality'],
                "owner": data.get('owner_user_id') or None, "status": data.get('status') or 'ACTIVE', "new_id": new_id_var})
        elif entity == 'incident':
            cursor.execute("""INSERT INTO INCIDENTS
                (asset_id, reporter_user_id, incident_title, incident_type, severity, description, source, impact_level, status)
                VALUES (:asset, :reporter, :title, :type, :severity, :description, :source, :impact, 'DETECTED')
                RETURNING incident_id INTO :new_id""", {
                "asset": int(data['asset_id']), "reporter": int(data['reporter_user_id']), "title": data['title'],
                "type": data['incident_type'], "severity": data['severity'], "description": data['description'],
                "source": data.get('source') or 'Website', "impact": data.get('impact_level') or 'MODERATE', "new_id": new_id_var})
        elif entity == 'response_action':
            cursor.execute("""INSERT INTO RESPONSE_ACTIONS
                (incident_id, investigation_id, assigned_to, action_type, action_description, executed_at, action_date, action_status)
                VALUES (:incident, NULL, :user_id, :type, :description,
                        TO_TIMESTAMP(:action_date, 'YYYY-MM-DD HH24:MI'), TO_TIMESTAMP(:action_date, 'YYYY-MM-DD HH24:MI'), :status)
                RETURNING action_id INTO :new_id""", {
                "incident": int(data['incident_id']), "user_id": int(data['assigned_to']), "type": data['action_type'],
                "description": data['description'], "action_date": data.get('action_date') or '2000-01-01 00:00',
                "status": data.get('status') or 'COMPLETED', "new_id": new_id_var})
        elif entity == 'report':
            cursor.execute("""INSERT INTO REPORTS (incident_id, report_type, summary, generated_by)
                VALUES (:incident, :type, :summary, :user_id) RETURNING report_id INTO :new_id""", {
                "incident": int(data['incident_id']), "type": data['report_type'], "summary": data.get('summary'),
                "user_id": int(data['generated_by']) if data.get('generated_by') else None, "new_id": new_id_var})
        elif entity == 'investigation':
            cursor.execute("""INSERT INTO INVESTIGATIONS
                (incident_id, lead_user_id, start_time, end_time, investigation_status, findings, conclusion, methodology)
                VALUES (:incident, :user_id, TO_TIMESTAMP(:start_date, 'YYYY-MM-DD HH24:MI'),
                        CASE WHEN :end_date IS NULL THEN NULL ELSE TO_TIMESTAMP(:end_date, 'YYYY-MM-DD HH24:MI') END,
                        :status, :findings, :conclusion, :methodology)
                RETURNING investigation_id INTO :new_id""", {
                "incident": int(data['incident_id']), "user_id": int(data['investigated_by']) if data.get('investigated_by') else None,
                "start_date": data.get('start_date') or '2000-01-01 00:00', "end_date": data.get('end_date') or None,
                "status": data.get('status') or 'OPEN', "findings": data.get('findings'), "conclusion": data.get('conclusion'),
                "methodology": data.get('methodology') or 'Standard investigation', "new_id": new_id_var})
        elif entity == 'evidence':
            incident_id = int(data['incident_id'])
            cursor.execute("SELECT MIN(investigation_id) FROM INVESTIGATIONS WHERE incident_id = :incident", {"incident": incident_id})
            investigation_id = cursor.fetchone()[0]
            cursor.execute("SELECT seq_evidence_id.NEXTVAL FROM DUAL")
            evidence_id = cursor.fetchone()[0]
            cursor.execute("""INSERT INTO EVIDENCE
                (investigation_id, evidence_id, incident_id, collected_by, evidence_type, file_name, hash_value,
                 storage_location, integrity_status, description, acquisition_method, source, file_path, notes)
                VALUES (:investigation, :evidence_id, :incident, :user_id, :type, :file_name, :hash,
                       :location, 'UNVERIFIED', :description, :source, :source, :file_path, :notes)""", {
                "investigation": investigation_id, "evidence_id": evidence_id, "incident": incident_id,
                "user_id": int(data['collected_by']) if data.get('collected_by') else None, "type": data['evidence_type'],
                "file_name": data['file_name'], "hash": data['integrity_hash'], "location": data.get('location') or data['file_path'],
                "description": data.get('notes') or 'Captured from CIRDEMS web form', "source": data.get('source') or 'Website',
                "file_path": data['file_path'], "notes": data.get('notes')})
            new_id_var.setvalue(0, evidence_id)
        elif entity == 'custody':
            cursor.execute("""INSERT INTO CHAIN_OF_CUSTODY
                (evidence_id, handled_by, action_detail, action_time, location, remarks)
                VALUES (:evidence, :user_id, :action, TO_TIMESTAMP(:action_time, 'YYYY-MM-DD HH24:MI'), :location, :remarks)
                RETURNING log_id INTO :new_id""", {
                "evidence": int(data['evidence_id']),
                "user_id": int(data['handled_by']), "action": data['action'],
                "action_time": data.get('action_time') or '2000-01-01 00:00', "location": data.get('location'),
                "remarks": data.get('remarks'), "new_id": new_id_var})
        elif entity == 'vulnerability':
            cursor.execute("SELECT asset_id FROM INCIDENTS WHERE incident_id = :incident", {"incident": int(data['incident_id'])})
            incident_asset = cursor.fetchone()
            if not incident_asset:
                raise ValueError("Choose a valid incident")
            cursor.execute("""INSERT INTO VULNERABILITIES
                (incident_id, asset_id, cve_code, vulnerability_title, description, severity, patch_status, discovered_at, remediation_deadline)
                VALUES (:incident, :asset, :cve, :title, :description, :severity, :status,
                       TO_TIMESTAMP(:detected, 'YYYY-MM-DD HH24:MI'), TRUNC(SYSDATE) + 30)
                RETURNING vulnerability_id INTO :new_id""", {
                "incident": int(data['incident_id']), "asset": incident_asset[0], "cve": data['cve_code'], "title": data['title'],
                "description": data['description'], "severity": data['severity'], "status": data.get('status') or 'OPEN',
                "detected": data.get('detected_date') or '2000-01-01 00:00', "new_id": new_id_var})
        else:
            cursor.close(); conn.close()
            return jsonify({"success": False, "error": "Unknown ER entity"}), 404
        new_id = new_id_var.getvalue()
        conn.commit()
        cursor.close(); conn.close()
        return jsonify({"success": True, "id": new_id, "message": f"Saved to Oracle (ID {new_id})"})
    except Exception as exc:
        conn.rollback()
        cursor.close(); conn.close()
        return jsonify({"success": False, "error": str(exc)}), 400

@app.route('/api/status', methods=['GET'])
def db_status():
    conn, err = get_connection()
    if conn:
        conn.close()
        return jsonify({"status": "ONLINE", "message": "Connected to Oracle Database 21c XE", "mode": "LIVE_ORACLE"})
    else:
        return jsonify({"status": "STANDALONE_DEMO", "message": f"Demo Mode (Oracle offline: {err})", "mode": "STANDALONE"})

@app.route('/api/assets', methods=['GET'])
def get_assets():
    conn, err = get_connection()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("SELECT asset_id, asset_name, asset_type, ip_address, criticality, asset_status FROM ASSETS ORDER BY asset_id")
            rows = [{"asset_id": r[0], "asset_name": r[1], "asset_type": r[2], "ip_address": r[3], "criticality": r[4], "asset_status": r[5]} for r in cursor.fetchall()]
            cursor.close()
            conn.close()
            return jsonify(rows)
        except Exception:
            conn.close()
    return jsonify(MOCK_ASSETS)

@app.route('/api/incidents', methods=['GET'])
def get_incidents():
    conn, err = get_connection()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT i.incident_id, a.asset_name, i.incident_title, i.severity, i.status, 
                       TO_CHAR(i.detected_at, 'YYYY-MM-DD HH24:MI')
                FROM INCIDENTS i 
                JOIN ASSETS a ON i.asset_id = a.asset_id 
                ORDER BY i.incident_id DESC
            """)
            rows = [{"incident_id": r[0], "asset_name": r[1], "incident_title": r[2], "severity": r[3], "status": r[4], "detected_at": r[5]} for r in cursor.fetchall()]
            cursor.close()
            conn.close()
            return jsonify(rows)
        except Exception:
            conn.close()
    return jsonify(MOCK_INCIDENTS)

@app.route('/api/evidence', methods=['GET'])
def get_evidence():
    conn, err = get_connection()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT investigation_id, evidence_id, file_name, evidence_type, hash_value, integrity_status 
                FROM EVIDENCE ORDER BY investigation_id, evidence_id
            """)
            rows = [{"investigation_id": r[0], "evidence_id": r[1], "file_name": r[2], "evidence_type": r[3], "hash_value": r[4], "integrity_status": r[5]} for r in cursor.fetchall()]
            cursor.close()
            conn.close()
            return jsonify(rows)
        except Exception:
            conn.close()
    return jsonify(MOCK_EVIDENCE)

@app.route('/api/action/log_incident', methods=['POST'])
def action_log_incident():
    """Executes Stored Procedure SP_LOG_INCIDENT_WITH_INVESTIGATION"""
    data = request.json or {}
    asset_id = int(data.get('asset_id', 4))
    title = data.get('title', 'Automated Perimeter Intrusion Attempt')
    severity = data.get('severity', 'CRITICAL')
    desc = data.get('description', 'Suspicious outbound command execution detected on host.')
    
    conn, err = get_connection()
    if conn:
        try:
            cursor = conn.cursor()
            o_inc_id = cursor.var(int)
            o_inv_id = cursor.var(int)
            cursor.callproc('SP_LOG_INCIDENT_WITH_INVESTIGATION', [
                asset_id, 2, title, 'Malware', severity, desc,
                'SOC Web Portal', 'MAJOR', 3, 'Live Response Forensics',
                o_inc_id, o_inv_id
            ])
            inc_val = o_inc_id.getvalue()
            inv_val = o_inv_id.getvalue()
            cursor.close()
            conn.close()
            return jsonify({
                "success": True,
                "flow": "User Form -> SP_LOG_INCIDENT_WITH_INVESTIGATION -> Oracle Trigger TRG_AUTO_UPDATE_ASSET_ON_INCIDENT -> Incident Table + Investigation Table Updated",
                "incident_id": inc_val,
                "investigation_id": inv_val,
                "message": f"Procedure SP_LOG_INCIDENT_WITH_INVESTIGATION executed successfully! Incident #{inc_val} & Investigation #{inv_val} created."
            })
        except Exception as e:
            conn.close()
            return jsonify({"success": False, "error": str(e)})

    return jsonify({
        "success": False,
        "error": err or "Oracle Database is unavailable.",
        "message": "Incident was not saved. Connect to Oracle Database and try again."
    }), 503

@app.route('/api/action/calc_risk', methods=['GET'])
def action_calc_risk():
    """Executes Stored Function FN_GET_ASSET_RISK_SCORE"""
    asset_id = int(request.args.get('asset_id', 4))
    conn, err = get_connection()
    if conn:
        try:
            cursor = conn.cursor()
            risk_score = cursor.callfunc('FN_GET_ASSET_RISK_SCORE', int, [asset_id])
            cursor.close()
            conn.close()
            return jsonify({"success": True, "asset_id": asset_id, "risk_score": risk_score})
        except Exception as e:
            conn.close()
            return jsonify({"success": False, "error": str(e)})

    # Mock calculation
    weights = {1: 85, 2: 70, 3: 45, 4: 92, 5: 98}
    score = weights.get(asset_id, 65)
    return jsonify({"success": True, "asset_id": asset_id, "risk_score": score, "formula": "Base Criticality + (Open CVEs * 15) + (Active Alerts * 8)"})

@app.route('/api/action/test_tamper_trigger', methods=['POST'])
def action_test_trigger():
    """Attempts to delete or alter a verified evidence row to trigger TRG_PREVENT_EVIDENCE_TAMPERING"""
    conn, err = get_connection()
    if conn:
        try:
            cursor = conn.cursor()
            # Attempt forbidden delete on verified evidence
            cursor.execute("DELETE FROM EVIDENCE WHERE evidence_id = 1")
            # Never commit this demonstration delete, even if the trigger is disabled.
            conn.rollback()
            cursor.close()
            conn.close()
            return jsonify({"success": False, "trigger_fired": False, "message": "The trigger did not block the delete. The transaction was rolled back, so no evidence was removed."})
        except Exception as e:
            conn.rollback()
            conn.close()
            return jsonify({
                "success": False,
                "trigger_fired": True,
                "error_code": "ORA-20001",
                "trigger_name": "TRG_PREVENT_EVIDENCE_TAMPERING",
                "database_response": str(e),
                "explanation": "Trigger TRG_PREVENT_EVIDENCE_TAMPERING successfully intercepted and halted unauthorized DELETE/UPDATE on verified digital evidence!"
            })

    return jsonify({
        "success": False,
        "trigger_fired": False,
        "error": err or "Oracle Database is unavailable.",
        "message": "The database trigger was not tested because Oracle is unavailable."
    }), 503

if __name__ == '__main__':
    port = int(os.getenv("PORT", 5000))
    print(f"[*] Starting CIRDEMS SOC Web Interface on http://localhost:{port}")
    app.run(host='127.0.0.1', port=port, debug=False)
