-- ============================================================================
-- CYBER INCIDENT RESPONSE & DIGITAL EVIDENCE MANAGEMENT SYSTEM (CIRDEMS)
-- FILE: 02_data_seed.sql
-- DESCRIPTION: Comprehensive Realistic Data Seeding (10+ records per table)
-- ============================================================================

SET SERVEROUTPUT ON;

PROMPT ============================================================================;
PROMPT SEEDING CIRDEMS DATASET (10+ Meaningful Records per Table)
PROMPT ============================================================================;

-- ----------------------------------------------------------------------------
-- 1. SEED USERS (12 Records)
-- ----------------------------------------------------------------------------
INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Vikram', 'R.', 'Aditya', 'vikram.aditya@cirdems.org', 'SECURITY_MANAGER', 'SOC Management', 'Chief Information Security Officer', '42 Technology Park Rd', 'Chennai', 'Tamil Nadu', '600113', DATE '2023-01-10', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Aarav', 'Kumar', 'Sharma', 'aarav.sharma@cirdems.org', 'SOC_ANALYST', 'Threat Operations', 'Senior SOC Analyst - Tier 2', '15 Cyber City Ave', 'Vellore', 'Tamil Nadu', '632014', DATE '2023-03-15', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Priya', 'Nair', 'Menon', 'priya.menon@cirdems.org', 'FORENSIC_EXAMINER', 'Digital Forensics', 'Lead Digital Forensics Specialist', '88 Silicon Valley St', 'Bengaluru', 'Karnataka', '560100', DATE '2023-02-01', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Rohan', 'Das', 'Gupta', 'rohan.gupta@cirdems.org', 'INCIDENT_RESPONDER', 'Incident Response', 'Incident Handling Engineer', '12 Brigade Gate', 'Bengaluru', 'Karnataka', '560025', DATE '2023-04-18', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Neha', 'S.', 'Verma', 'neha.verma@cirdems.org', 'SYSTEM_ADMIN', 'Infrastructure & Cloud', 'Principal Systems Architect', '104 Anna Salai', 'Chennai', 'Tamil Nadu', '600002', DATE '2022-11-05', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Siddharth', 'M.', 'Iyer', 'siddharth.iyer@cirdems.org', 'SOC_ANALYST', 'Threat Operations', 'Junior Triage Analyst - Tier 1', '7 Greenview Blvd', 'Vellore', 'Tamil Nadu', '632014', DATE '2024-01-12', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Ananya', 'Devi', 'Patel', 'ananya.patel@cirdems.org', 'FORENSIC_EXAMINER', 'Digital Forensics', 'Forensic Artifact Examiner', '21 Infotech Road', 'Hyderabad', 'Telangana', '500081', DATE '2023-06-20', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Karthik', 'B.', 'Rao', 'karthik.rao@cirdems.org', 'INCIDENT_RESPONDER', 'Incident Response', 'Threat Hunter & Malware Analyst', '55 MG Road', 'Bengaluru', 'Karnataka', '560001', DATE '2023-08-14', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Deepa', 'L.', 'Reddy', 'deepa.reddy@cirdems.org', 'SYSTEM_ADMIN', 'Network Operations', 'Senior Network Security Admin', '9 Jubilee Hills', 'Hyderabad', 'Telangana', '500033', DATE '2022-09-01', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Manish', 'K.', 'Tiwari', 'manish.tiwari@cirdems.org', 'STANDARD_USER', 'Finance & Payroll', 'Senior Accounts Officer', '18 Nehru Nagar', 'New Delhi', 'Delhi', '110065', DATE '2023-05-10', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Swathi', 'P.', 'Nambiar', 'swathi.nambiar@cirdems.org', 'STANDARD_USER', 'Human Resources', 'HR Operations Lead', '73 Marine Lines', 'Mumbai', 'Maharashtra', '400020', DATE '2023-07-02', 'ACTIVE');

INSERT INTO USERS (first_name, middle_name, last_name, email, role, department, job_title, street, city, state, pincode, date_joined, account_status)
VALUES ('Gaurav', 'R.', 'Chopra', 'gaurav.chopra@cirdems.org', 'STANDARD_USER', 'Research & Development', 'Lead Systems Software Engineer', '34 Whitefield Ring', 'Bengaluru', 'Karnataka', '560066', DATE '2023-09-15', 'ACTIVE');

-- ----------------------------------------------------------------------------
-- 2. SEED USER_PHONES (14 Records)
-- ----------------------------------------------------------------------------
INSERT INTO USER_PHONES VALUES (1, '+91-98401-11223', 'MOBILE');
INSERT INTO USER_PHONES VALUES (1, '+91-44-22501001', 'WORK_DESK');
INSERT INTO USER_PHONES VALUES (2, '+91-98840-22334', 'MOBILE');
INSERT INTO USER_PHONES VALUES (2, '+91-98840-99901', 'ON_CALL_PAGER');
INSERT INTO USER_PHONES VALUES (3, '+91-97390-33445', 'MOBILE');
INSERT INTO USER_PHONES VALUES (3, '+91-80-41234567', 'WORK_DESK');
INSERT INTO USER_PHONES VALUES (4, '+91-98450-44556', 'MOBILE');
INSERT INTO USER_PHONES VALUES (5, '+91-94440-55667', 'MOBILE');
INSERT INTO USER_PHONES VALUES (6, '+91-98765-66778', 'MOBILE');
INSERT INTO USER_PHONES VALUES (7, '+91-94901-77889', 'MOBILE');
INSERT INTO USER_PHONES VALUES (8, '+91-98860-88990', 'MOBILE');
INSERT INTO USER_PHONES VALUES (9, '+91-98490-99001', 'WORK_DESK');
INSERT INTO USER_PHONES VALUES (10, '+91-98110-10112', 'MOBILE');
INSERT INTO USER_PHONES VALUES (11, '+91-98200-11223', 'MOBILE');

-- ----------------------------------------------------------------------------
-- 3. SEED ASSETS (12 Records)
-- ----------------------------------------------------------------------------
INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('DC-CORP-01', 'Domain Controller', '10.0.1.5', '00:1A:2B:3C:4D:01', 'Windows Server', '2022 Datacenter', 'Server Room A - Rack 1', 'CRITICAL', 5, DATE '2022-01-15', DATE '2024-03-01', 'ACTIVE');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('DB-ORACLE-PROD', 'Database Server', '10.0.1.10', '00:1A:2B:3C:4D:02', 'Red Hat Enterprise Linux', '8.9', 'Server Room A - Rack 2', 'CRITICAL', 5, DATE '2022-03-10', DATE '2024-03-10', 'ACTIVE');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('FW-PERIMETER-01', 'Firewall', '192.168.1.1', '00:1A:2B:3C:4D:03', 'Palo Alto PAN-OS', '10.2.4', 'DMZ Gateway Zone', 'CRITICAL', 9, DATE '2021-06-25', DATE '2024-03-15', 'ACTIVE');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('WEB-PORTAL-PROD', 'Web Server', '10.0.2.15', '00:1A:2B:3C:4D:04', 'Ubuntu Server', '22.04 LTS', 'DMZ Web Zone', 'HIGH', 5, DATE '2022-08-12', DATE '2024-02-28', 'UNDER_INVESTIGATION');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('FS-FINANCE-01', 'Workstation', '10.0.3.50', '00:1A:2B:3C:4D:05', 'Windows 11 Pro', '23H2', 'Finance Dept - 2nd Floor', 'HIGH', 10, DATE '2023-01-20', DATE '2024-03-05', 'COMPROMISED');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('WS-HR-LEAD', 'Workstation', '10.0.3.55', '00:1A:2B:3C:4D:06', 'Windows 11 Pro', '22H2', 'HR Dept - 3rd Floor', 'MEDIUM', 11, DATE '2023-02-14', DATE '2024-02-20', 'ACTIVE');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('RTR-CORE-BACKBONE', 'Core Router', '10.0.0.1', '00:1A:2B:3C:4D:07', 'Cisco IOS-XE', '17.6.3a', 'Datacenter Main MDF', 'CRITICAL', 9, DATE '2021-04-10', DATE '2024-03-01', 'ACTIVE');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('DEV-WORKSTATION-09', 'Workstation', '10.0.4.88', '00:1A:2B:3C:4D:08', 'Fedora Workstation', '39', 'R&D Lab 4', 'MEDIUM', 12, DATE '2023-05-18', DATE '2024-03-12', 'ISOLATED');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('SOC-SIEM-CLUSTER', 'Database Server', '10.0.1.20', '00:1A:2B:3C:4D:09', 'RHEL', '9.2', 'SOC Secure Cage', 'CRITICAL', 2, DATE '2022-10-05', DATE '2024-03-15', 'ACTIVE');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('API-GATEWAY-EXT', 'Web Server', '10.0.2.30', '00:1A:2B:3C:4D:10', 'Debian Linux', '12 (Bookworm)', 'DMZ API Zone', 'HIGH', 5, DATE '2023-04-01', DATE '2024-02-25', 'ACTIVE');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('BACKUP-NAS-PRIMARY', 'Database Server', '10.0.1.80', '00:1A:2B:3C:4D:11', 'TrueNAS Enterprise', '13.0', 'Datacenter Storage Room', 'CRITICAL', 5, DATE '2022-12-15', DATE '2024-03-01', 'ACTIVE');

INSERT INTO ASSETS (asset_name, asset_type, ip_address, mac_address, operating_system, os_version, location, criticality, owner_user_id, purchase_date, last_scan_date, asset_status)
VALUES ('VPN-CONCENTRATOR', 'Firewall', '192.168.1.10', '00:1A:2B:3C:4D:12', 'FortiOS', '7.2.5', 'DMZ Perimeter', 'HIGH', 9, DATE '2022-07-20', DATE '2024-03-08', 'ACTIVE');

-- ----------------------------------------------------------------------------
-- 4. SEED VULNERABILITIES (12 Records)
-- ----------------------------------------------------------------------------
INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (4, 'CVE-2023-34362', 'MOVEit Transfer SQL Injection Vulnerability', 'SQL injection vulnerability in Progress MOVEit Transfer allows unauthenticated attacker remote code execution.', 'CRITICAL', TIMESTAMP '2024-02-15 09:30:00', 'OPEN', DATE '2024-02-25', '2023.0.0', 'Hotfix patch downloaded, pending change window approval');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (1, 'CVE-2024-21413', 'Microsoft Outlook Remote Code Execution Flaw', 'MonikerLink bug bypasses Office Protected View allowing NTLM credential leak and remote arbitrary code execution.', 'CRITICAL', TIMESTAMP '2024-02-18 11:00:00', 'OPEN', DATE '2024-02-28', 'Outlook 365 16.0', 'Group Policy push scheduled for all endpoints');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (2, 'CVE-2021-44228', 'Apache Log4j JNDI Remote Code Execution (Log4Shell)', 'JNDI injection in log messages enables full unauthenticated remote code execution on server.', 'CRITICAL', TIMESTAMP '2024-01-10 14:00:00', 'PATCHED', DATE '2024-01-15', 'log4j-core 2.14.1', 'Patched to log4j-core 2.17.1 across production JVM instances');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (5, 'CVE-2023-36884', 'Windows Search & Office Defense in Depth RCE', 'Exploitation of specially crafted Microsoft Office documents via search protocols allowing remote execution.', 'HIGH', TIMESTAMP '2024-02-20 16:45:00', 'IN_PROGRESS', DATE '2024-03-05', 'Windows 11 22H2', 'Registry mitigation applied; KB5028244 update deployed');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (3, 'CVE-2024-3400', 'Palo Alto PAN-OS Command Injection in GlobalProtect', 'Command injection in GlobalProtect feature allows unauthenticated remote attacker to execute arbitrary code with root privileges.', 'CRITICAL', TIMESTAMP '2024-03-01 08:00:00', 'OPEN', DATE '2024-03-06', 'PAN-OS 10.2.4', 'Threat Prevention Rule 95187 enabled; hotfix upgrade scheduled');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (6, 'CVE-2023-23397', 'Microsoft Outlook NTLM Relay Elevation of Privilege', 'Specially crafted calendar invitation triggers automatic NTLM hash leakage to external SMB listener.', 'HIGH', TIMESTAMP '2024-01-25 10:30:00', 'PATCHED', DATE '2024-02-05', 'Outlook 2016/2019', 'CVE script run, port 445 egress blocked at perimeter');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (10, 'CVE-2023-44487', 'HTTP/2 Rapid Reset DDoS Vulnerability', 'Abuse of stream cancellation in HTTP/2 allows attackers to consume excessive CPU resources.', 'HIGH', TIMESTAMP '2024-02-12 13:15:00', 'PATCHED', DATE '2024-02-20', 'Nginx 1.20', 'Nginx rate limiting and stream concurrency limits tuned');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (8, 'CVE-2023-4911', 'GNU C Library ld.so Buffer Overflow (Looney Tunables)', 'Buffer overflow in dynamic loader allows local unprivileged user to obtain root privileges via GLIBC_TUNABLES.', 'HIGH', TIMESTAMP '2024-02-14 17:00:00', 'OPEN', DATE '2024-02-24', 'glibc 2.38', 'Yum update pending for dev workstations');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (7, 'CVE-2023-20198', 'Cisco IOS XE Web UI Privilege Escalation', 'Unauthenticated attacker can create a high-privilege account and gain control of the network device.', 'CRITICAL', TIMESTAMP '2024-01-18 09:00:00', 'PATCHED', DATE '2024-01-22', 'IOS-XE 17.6', 'HTTP Server disabled, patched firmware 17.6.3a installed');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (12, 'CVE-2023-27997', 'Fortinet FortiOS SSL-VPN Remote Heap Buffer Overflow', 'Heap-based buffer overflow in sslvpnd daemon allows pre-authentication arbitrary code execution.', 'CRITICAL', TIMESTAMP '2024-02-22 15:30:00', 'OPEN', DATE '2024-03-01', 'FortiOS 7.2.4', 'Firmware patch downloaded, scheduled reboot midnight');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (11, 'CVE-2023-48795', 'SSH Terrapin Attack Prefix Truncation', 'Vulnerability in SSH transport protocol enables attacker to manipulate sequence numbers and downgrade security.', 'MEDIUM', TIMESTAMP '2024-02-10 11:20:00', 'RISK_ACCEPTED', DATE '2024-04-30', 'OpenSSH 8.8', 'Strict KEX negotiation cipher restrictions enforced');

INSERT INTO VULNERABILITIES (asset_id, cve_code, vulnerability_title, description, severity, discovered_at, patch_status, remediation_deadline, affected_version, remediation_notes)
VALUES (5, 'CVE-2024-21338', 'Windows Kernel Elevation of Privilege Vulnerability', 'Vulnerability in appid.sys allows local attacker to gain SYSTEM privileges used by Lazarus group.', 'HIGH', TIMESTAMP '2024-02-28 14:10:00', 'OPEN', DATE '2024-03-07', 'Windows 11 23H2', 'Pending installation during next maintenance cycle');

-- ----------------------------------------------------------------------------
-- 5. SEED ALERTS (14 Records)
-- ----------------------------------------------------------------------------
INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (4, 1, 'Web Shell Exploitation', 'Suspicious outbound POST connection to known C2 server following HTTP 500 error on /moveit endpoint', 'CRITICAL', 'Suricata NIDS', 95, TIMESTAMP '2024-03-01 02:14:22', 'ESCALATED', 'RULE-IDS-WEB-EXPLOIT-09', TIMESTAMP '2024-03-01 02:20:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (5, 4, 'Ransomware Canary Triggered', 'Multiple file extensions modified to .enc_blackcat within 60 seconds on C:\Finance\Ledgers', 'CRITICAL', 'CrowdStrike Falcon EDR', 99, TIMESTAMP '2024-03-02 04:30:10', 'ESCALATED', 'RULE-EDR-RANSOM-CANARY', TIMESTAMP '2024-03-02 04:32:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (1, 2, 'Kerberoasting Attack', 'Abnormal high volume of Kerberos TGS ticket requests targeting SPNs with RC4 encryption', 'HIGH', 'Splunk Enterprise SIEM', 88, TIMESTAMP '2024-03-03 10:15:00', 'ACKNOWLEDGED', 'RULE-SIEM-AD-KERBEROAST', TIMESTAMP '2024-03-03 10:25:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (8, 8, 'Cobalt Strike Beacon Detection', 'Process curl executing base64 pipe to sh every 30 seconds matching malleable C2 profile', 'HIGH', 'Wazuh HIDS', 92, TIMESTAMP '2024-03-04 14:45:00', 'ESCALATED', 'RULE-HIDS-BEACON-INTERVAL', TIMESTAMP '2024-03-04 14:50:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (3, 5, 'External Port Scan', 'TCP SYN scan detected from external IP 185.220.101.5 targeting ports 22, 443, 3389, 8443', 'MEDIUM', 'Palo Alto PAN-OS', 75, TIMESTAMP '2024-03-05 01:10:00', 'ACKNOWLEDGED', 'RULE-FW-PORT-SCAN-THRESHOLD', TIMESTAMP '2024-03-05 01:30:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (2, 3, 'SQL Injection Attempt', 'Union-based SQL injection strings identified in HTTP GET request parameters', 'HIGH', 'ModSecurity WAF', 85, TIMESTAMP '2024-03-05 18:22:15', 'ACKNOWLEDGED', 'RULE-WAF-SQLI-SIG-4001', TIMESTAMP '2024-03-05 18:35:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (10, 7, 'HTTP/2 Rapid Reset Flooding', 'Stream reset frame burst exceeding 20,000 requests/second from distributed bots', 'HIGH', 'Cloudflare Edge WAF', 90, TIMESTAMP '2024-03-06 08:40:00', 'ACKNOWLEDGED', 'RULE-EDGE-HTTP2-FLOOD', TIMESTAMP '2024-03-06 08:42:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (12, 10, 'VPN Brute Force Attack', 'Failed authentication threshold exceeded: 150 failed logins for user admin from IP 45.154.255.8', 'MEDIUM', 'FortiGate Syslog', 82, TIMESTAMP '2024-03-06 23:15:00', 'ACKNOWLEDGED', 'RULE-VPN-BRUTE-FORCE-100', TIMESTAMP '2024-03-06 23:30:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (6, 6, 'Suspicious Email Attachment', 'Email with macro-enabled invoice.docm containing obfuscated VBA script quarantined', 'MEDIUM', 'Proofpoint Email Gateway', 89, TIMESTAMP '2024-03-07 09:05:00', 'ACKNOWLEDGED', 'RULE-EMAIL-MALICIOUS-VBA', TIMESTAMP '2024-03-07 09:12:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (1, NULL, 'Pass-the-Hash Lateral Movement', 'NTLM login using stolen credentials detected from workstation 10.0.4.88 to Domain Controller', 'CRITICAL', 'Microsoft Defender for Identity', 96, TIMESTAMP '2024-03-07 16:30:00', 'ESCALATED', 'RULE-MDI-PTH-ALERT-01', TIMESTAMP '2024-03-07 16:35:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (7, 9, 'Unauthorized SNMP Sweep', 'SNMP v2c community string public brute force attempt against router interfaces', 'LOW', 'Suricata NIDS', 60, TIMESTAMP '2024-03-08 03:00:00', 'NEW', 'RULE-IDS-SNMP-SWEEP', NULL);

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (11, NULL, 'Unusual After-Hours Data Transfer', '45 GB egress traffic transfer detected to unknown external S3 bucket IP', 'HIGH', 'Zeek Network Monitor', 84, TIMESTAMP '2024-03-08 22:45:00', 'ESCALATED', 'RULE-ZEEK-HIGH-VOLUME-EGRESS', TIMESTAMP '2024-03-08 23:00:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (8, NULL, 'Shadow Copy Deletion', 'Process vssadmin.exe delete shadows /all /quiet executed by unprivileged session', 'HIGH', 'CrowdStrike Falcon EDR', 97, TIMESTAMP '2024-03-09 11:20:00', 'ACKNOWLEDGED', 'RULE-EDR-VSS-TAMPERING', TIMESTAMP '2024-03-09 11:22:00');

INSERT INTO ALERTS (asset_id, vulnerability_id, alert_type, alert_message, severity, source_system, confidence_score, generated_at, alert_status, detection_rule, acknowledgement_time)
VALUES (5, NULL, 'DNS Tunneling Activity', 'Anomalous volume of TXT queries resolving random base32 encoded subdomains to ns1.c2domain.cc', 'HIGH', 'Infoblox DNS Firewall', 87, TIMESTAMP '2024-03-09 15:10:00', 'ESCALATED', 'RULE-DNS-TUNNELING-DETECTION', TIMESTAMP '2024-03-09 15:15:00');

-- ----------------------------------------------------------------------------
-- 6. SEED INCIDENTS (12 Records)
-- ----------------------------------------------------------------------------
INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (4, 2, 'External Web Application Compromise via MOVEit Exploit', 'Data Exfiltration', 'CRITICAL', 'Attackers leveraged CVE-2023-34362 to inject web shells into MOVEit transfer service and steal customer records.', TIMESTAMP '2024-03-01 02:14:22', TIMESTAMP '2024-03-01 02:30:00', 'INVESTIGATING', NULL, 'Suricata NIDS', 'MAJOR', NULL);

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (5, 10, 'Finance Department BlackCat Ransomware Infection', 'Ransomware', 'CRITICAL', 'Workstation FS-FINANCE-01 encrypted by BlackCat/ALPHV ransomware variant with ransom note left on desktop.', TIMESTAMP '2024-03-02 04:30:10', TIMESTAMP '2024-03-02 05:00:00', 'CONTAINED', NULL, 'CrowdStrike Falcon EDR', 'CATASTROPHIC', NULL);

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (1, 6, 'Active Directory Kerberoasting Attack Campaign', 'Brute Force', 'HIGH', 'Adversary requested multiple Service Principal Name Kerberos tickets to crack offline and obtain domain admin privileges.', TIMESTAMP '2024-03-03 10:15:00', TIMESTAMP '2024-03-03 10:45:00', 'RESOLVED', TIMESTAMP '2024-03-03 19:30:00', 'Splunk SIEM', 'MODERATE', 'Compromised service accounts disabled, Kerberos AES encryption enforced, SPN passwords rotated.');

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (8, 2, 'R&D Linux Workstation Cobalt Strike C2 Implant', 'Malware', 'HIGH', 'Developer station found communicating with external bulletproof hosting server in Romania via DNS & HTTPS beacons.', TIMESTAMP '2024-03-04 14:45:00', TIMESTAMP '2024-03-04 15:10:00', 'CONTAINED', NULL, 'Wazuh HIDS', 'MODERATE', NULL);

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (3, 6, 'Distributed Perimeter Reconnaissance and Port Scanning', 'Denial of Service', 'LOW', 'Automated scanning botnet probe sweeping external boundary firewalls for unpatched VPN services.', TIMESTAMP '2024-03-05 01:10:00', TIMESTAMP '2024-03-05 02:00:00', 'RESOLVED', TIMESTAMP '2024-03-05 04:15:00', 'Palo Alto PAN-OS', 'MINOR', 'Originating IP subnets added to global dynamic block list; zero perimeter ports compromised.');

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (2, 2, 'Automated SQL Injection Attack on Customer Database', 'Data Exfiltration', 'HIGH', 'Malicious actor launched automated SQL map injection payloads against backend product search APIs.', TIMESTAMP '2024-03-05 18:22:15', TIMESTAMP '2024-03-05 18:50:00', 'RESOLVED', TIMESTAMP '2024-03-06 01:10:00', 'ModSecurity WAF', 'MODERATE', 'Attacking IP blacklisted at WAF layer, vulnerable parameter prepared statements sanitized and deployed.');

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (10, 2, 'DDoS HTTP/2 Rapid Reset Volumetric Attack', 'Denial of Service', 'HIGH', 'High volumetric layer-7 stream flood overwhelming API Gateway CPU resources causing service degradation.', TIMESTAMP '2024-03-06 08:40:00', TIMESTAMP '2024-03-06 09:00:00', 'RESOLVED', TIMESTAMP '2024-03-06 13:45:00', 'Cloudflare Edge WAF', 'MODERATE', 'Enabled Cloudflare Under Attack mode; configured stream reset threshold in Nginx configuration.');

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (12, 6, 'Credential Stuffing on Corporate SSL-VPN Portal', 'Brute Force', 'MEDIUM', 'Over 12,000 automated login attempts utilizing compromised credential combos leaked on dark web.', TIMESTAMP '2024-03-06 23:15:00', TIMESTAMP '2024-03-07 00:10:00', 'RESOLVED', TIMESTAMP '2024-03-07 06:00:00', 'FortiGate Syslog', 'MINOR', 'Enforced mandatory MFA on all VPN profiles, blocked source IP block and rotated 3 flagged passwords.');

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (6, 11, 'Executive Spear-Phishing Campaign Targeting HR', 'Phishing', 'MEDIUM', 'Targeted email containing macro payload impersonating government tax agency received by HR employees.', TIMESTAMP '2024-03-07 09:05:00', TIMESTAMP '2024-03-07 09:25:00', 'RESOLVED', TIMESTAMP '2024-03-07 14:00:00', 'Proofpoint Email Gateway', 'MINOR', 'Email purged from all 240 employee mailboxes; sender domain blacklisted; security awareness advisory issued.');

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (1, 2, 'Internal Domain Controller Lateral Movement Attempt', 'Privilege Escalation', 'CRITICAL', 'Pass-the-hash technique used with dumped LSASS hash from workstation DEV-09 to access DC.', TIMESTAMP '2024-03-07 16:30:00', TIMESTAMP '2024-03-07 16:50:00', 'INVESTIGATING', NULL, 'Microsoft Defender for Identity', 'MAJOR', NULL);

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (11, 2, 'Sensitive Data Exfiltration via S3 Egress Tunnel', 'Data Exfiltration', 'HIGH', 'Bulk archive transfer of customer database backup to external cloud bucket discovered after-hours.', TIMESTAMP '2024-03-08 22:45:00', TIMESTAMP '2024-03-08 23:15:00', 'INVESTIGATING', NULL, 'Zeek Network Monitor', 'MAJOR', NULL);

INSERT INTO INCIDENTS (asset_id, reporter_user_id, incident_title, incident_type, severity, description, detected_at, reported_at, status, resolved_at, source, impact_level, resolution_summary)
VALUES (5, 4, 'DNS Data Exfiltration & Covert Channel', 'Data Exfiltration', 'HIGH', 'Encoded staging data transferred through repetitive base32 queries to threat actor authoritative nameserver.', TIMESTAMP '2024-03-09 15:10:00', TIMESTAMP '2024-03-09 15:30:00', 'DETECTED', NULL, 'Infoblox DNS Firewall', 'MODERATE', NULL);

-- ----------------------------------------------------------------------------
-- 7. SEED INVESTIGATIONS (12 Records - 1:1 with INCIDENTS)
-- ----------------------------------------------------------------------------
INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (1, 3, TIMESTAMP '2024-03-01 02:45:00', NULL, 'P1_URGENT', 'IN_PROGRESS', 'Identified webshell human2.aspx planted in wwwroot directory. Web shell executing PowerShell scripts.', 'Active forensic examination of MOVEit transfer cluster.', 'Live Response, Memory Analysis, Web Log Forensics', NULL, TIMESTAMP '2024-03-01 02:40:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (2, 7, TIMESTAMP '2024-03-02 05:15:00', NULL, 'P1_URGENT', 'IN_PROGRESS', 'Ransomware executable identified as ALPHV/BlackCat written in Rust. Shadow copies successfully purged.', 'Triage and decryption feasibility study for finance server.', 'Disk Imaging, Memory Dump Analysis, Reverse Engineering', NULL, TIMESTAMP '2024-03-02 05:10:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (3, 3, TIMESTAMP '2024-03-03 11:00:00', TIMESTAMP '2024-03-03 19:00:00', 'P2_HIGH', 'COMPLETED', 'Attacker dumped TGS tickets for SQL-Service-Account. Ticket cracked using hashcat offline.', 'Investigation into Kerberoasting ticket harvest.', 'Active Directory Audit, Event Log Correlation', 'Single service account compromised. Account disabled and remediated.', TIMESTAMP '2024-03-03 10:55:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (4, 7, TIMESTAMP '2024-03-04 15:30:00', NULL, 'P2_HIGH', 'IN_PROGRESS', 'Found cronjob under /etc/cron.d/syscheck pulling payload from 185.190.140.44 every 15 minutes.', 'Linux endpoint investigation for rootkit and C2 implants.', 'Linux Forensic Artifacts, Network PCAP Analysis', NULL, TIMESTAMP '2024-03-04 15:20:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (5, 8, TIMESTAMP '2024-03-05 02:15:00', TIMESTAMP '2024-03-05 04:00:00', 'P4_LOW', 'COMPLETED', 'Mirai-derivative botnet scanner IP detected attempting default credential dictionaries.', 'Perimeter firewall probe analysis.', 'Firewall Log Analytics', 'Routine automated scan. Zero access gained.', TIMESTAMP '2024-03-05 02:10:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (6, 3, TIMESTAMP '2024-03-05 19:00:00', TIMESTAMP '2024-03-06 01:00:00', 'P2_HIGH', 'COMPLETED', 'Attacker probed endpoint /api/search?q= using SQL injection. WAF rules blocked database extraction.', 'Database web interface vulnerability audit.', 'WAF Log Forensics, Source Code Review', 'Attack stopped by WAF before database exfiltration occurred.', TIMESTAMP '2024-03-05 18:55:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (7, 4, TIMESTAMP '2024-03-06 09:15:00', TIMESTAMP '2024-03-06 13:30:00', 'P2_HIGH', 'COMPLETED', 'Rapid reset flood targeted API edge gateway. 12,000 distinct source bot IPs identified.', 'Volumetric DDoS analysis.', 'NetFlow & CDN Telemetry Analysis', 'Mitigated with rate limiting and upstream CDN scrubbing.', TIMESTAMP '2024-03-06 09:10:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (8, 8, TIMESTAMP '2024-03-07 00:30:00', TIMESTAMP '2024-03-07 05:45:00', 'P3_MEDIUM', 'COMPLETED', 'Brute force originated from Tor exit node 171.25.193.77. No logins succeeded due to MFA challenge.', 'Authentication brute force assessment.', 'Syslog & Identity Provider Audit', 'No accounts breached. MFA enforced successfully.', TIMESTAMP '2024-03-07 00:20:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (9, 7, TIMESTAMP '2024-03-07 09:40:00', TIMESTAMP '2024-03-07 13:45:00', 'P3_MEDIUM', 'COMPLETED', 'Weaponized document contained macro attempting download from malic-invoice-portal.top.', 'Phishing email forensic examination.', 'Static Malware Analysis, Email Header Inspection', 'Email blocked, domain sinkholed across enterprise DNS.', TIMESTAMP '2024-03-07 09:35:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (10, 3, TIMESTAMP '2024-03-07 17:00:00', NULL, 'P1_URGENT', 'IN_PROGRESS', 'Mimikatz memory scraping found on DEV-09 used to execute Remote WMI onto DC-CORP-01.', 'Domain Controller privilege escalation investigation.', 'Memory Forensics, Windows Event Log Security ID 4624', NULL, TIMESTAMP '2024-03-07 16:55:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (11, 4, TIMESTAMP '2024-03-08 23:30:00', NULL, 'P2_HIGH', 'OPEN', 'Rclone config found on BACKUP-NAS syncing sensitive customer database dump to unknown AWS account.', 'Data exfiltration path discovery.', 'CloudTrail, S3 Audit & Host Forensics', NULL, TIMESTAMP '2024-03-08 23:25:00');

INSERT INTO INVESTIGATIONS (incident_id, lead_user_id, start_time, end_time, priority, investigation_status, findings, investigation_summary, methodology, conclusion, created_at)
VALUES (12, 8, TIMESTAMP '2024-03-09 15:45:00', NULL, 'P2_HIGH', 'OPEN', 'Tunneling tool dnscat2 installed under AppData directory.', 'Covert DNS channel investigation.', 'DNS Query Log Analysis, Host Artifact Inspection', NULL, TIMESTAMP '2024-03-09 15:40:00');

-- ----------------------------------------------------------------------------
-- 8. SEED EVIDENCE (Weak Entity - Composite PK: investigation_id, evidence_id) (14 Records)
-- ----------------------------------------------------------------------------
INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (1, 1, 3, 'Disk Image', 'moveit_vm_disk.E01', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', TIMESTAMP '2024-03-01 03:30:00', '/evidence/case_01/moveit_vm_disk.E01', 'VERIFIED', 'Full forensic bitstream image of compromised MOVEit VM', 'FTK Imager Bitstream E01', 'ANALYZED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (1, 2, 3, 'Malware Sample', 'human2.aspx', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', TIMESTAMP '2024-03-01 04:15:00', '/evidence/case_01/payloads/human2.aspx', 'VERIFIED', 'Webshell script extracted from wwwroot directory', 'Live Response Acquisition', 'ANALYZED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (2, 1, 7, 'Memory Dump', 'finance_memdump.raw', '4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a', TIMESTAMP '2024-03-02 05:45:00', '/evidence/case_02/finance_memdump.raw', 'VERIFIED', '16GB RAM dump of finance workstation taken via WinPmem', 'WinPmem 4.0 Physical RAM Capture', 'ANALYZED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (2, 2, 7, 'Malware Sample', 'blackcat_encryptor.exe', 'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d', TIMESTAMP '2024-03-02 06:10:00', '/evidence/case_02/payloads/blackcat.exe', 'VERIFIED', 'ALPHV/BlackCat ransomware binary payload', 'Forensic File Extraction', 'ANALYZED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (3, 1, 3, 'System Log', 'security_event_log.evtx', '1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b', TIMESTAMP '2024-03-03 11:30:00', '/evidence/case_03/ad_sec_events.evtx', 'VERIFIED', 'Windows Security Event Log containing 4769 TGS requests', 'PowerShell Get-WinEvent Export', 'ARCHIVED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (4, 1, 7, 'Network PCAP', 'c2_beacon_traffic.pcap', '2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c', TIMESTAMP '2024-03-04 16:00:00', '/evidence/case_04/c2_traffic.pcap', 'VERIFIED', 'Packet capture of periodic Cobalt Strike beacons', 'tcpdump on eth0 interface', 'ANALYZED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (4, 2, 7, 'Malware Sample', 'syscheck.sh', '3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d', TIMESTAMP '2024-03-04 16:30:00', '/evidence/case_04/payloads/syscheck.sh', 'VERIFIED', 'Malicious stager script located in cron directory', 'Direct File Carving', 'ANALYZED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (6, 1, 3, 'System Log', 'modsec_audit.log', '4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e', TIMESTAMP '2024-03-05 19:30:00', '/evidence/case_06/modsec_audit.log', 'VERIFIED', 'Web application firewall transaction audit log', 'Syslog collector export', 'ARCHIVED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (7, 1, 4, 'System Log', 'cloudflare_ddos_telemetry.json', '5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f', TIMESTAMP '2024-03-06 10:00:00', '/evidence/case_07/cf_stream_logs.json', 'VERIFIED', 'HTTP/2 stream cancellation log extract', 'Cloudflare API log extraction', 'ARCHIVED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (9, 1, 7, 'Malware Sample', 'Urgent_Tax_Invoice.docm', '6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a', TIMESTAMP '2024-03-07 10:15:00', '/evidence/case_09/phishing_sample.docm', 'VERIFIED', 'Weaponized Word document with embedded malicious macro', 'Proofpoint quarantine release', 'ARCHIVED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (10, 1, 3, 'Memory Dump', 'dev09_lsass.dmp', '7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b', TIMESTAMP '2024-03-07 17:30:00', '/evidence/case_10/lsass.dmp', 'VERIFIED', 'Process memory dump of lsass.exe dumped by adversary', 'Procdump forensic recovery', 'ANALYZED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (11, 1, 4, 'System Log', 'nas_rclone_history.log', '8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c', TIMESTAMP '2024-03-08 23:50:00', '/evidence/case_11/rclone.log', 'UNVERIFIED', 'File transfer logs showing 45GB transfer to AWS S3 bucket', 'Host file copy', 'ACQUIRED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (12, 1, 8, 'Network PCAP', 'dns_tunneling_traffic.pcap', '9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d', TIMESTAMP '2024-03-09 16:15:00', '/evidence/case_12/dns_tunnel.pcap', 'UNVERIFIED', 'Full packet capture of suspicious DNS queries to c2domain.cc', 'Wireshark span port capture', 'ACQUIRED');

INSERT INTO EVIDENCE (investigation_id, evidence_id, collected_by, evidence_type, file_name, hash_value, collected_at, storage_location, integrity_status, description, acquisition_method, evidence_status)
VALUES (1, 3, 3, 'System Log', 'moveit_iis_access.log', '0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e', TIMESTAMP '2024-03-01 05:00:00', '/evidence/case_01/iis_access.log', 'VERIFIED', 'IIS web server access logs verifying initial SQLi injection point', 'Log file collection', 'ANALYZED');

-- ----------------------------------------------------------------------------
-- 9. SEED INDICATORS (14 Records)
-- ----------------------------------------------------------------------------
INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (1, 'IPv4', '194.165.16.14', TIMESTAMP '2024-03-01 02:14:22', TIMESTAMP '2024-03-01 04:00:00', 95, 'Mandiant Threat Intelligence', 'ACTIVE', 'Threat group lacey-tempest MOVEit exploitation source IP', 'C2_Server');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (1, 'SHA256_Hash', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', TIMESTAMP '2024-03-01 03:00:00', TIMESTAMP '2024-03-01 06:00:00', 98, 'VirusTotal', 'ACTIVE', 'SHA-256 hash of human2.aspx webshell component', 'Ransomware_Stager');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (2, 'Domain', 'alphv-leak-portal-v4.onion', TIMESTAMP '2024-03-02 04:30:10', TIMESTAMP '2024-03-02 12:00:00', 99, 'CrowdStrike Intelligence', 'ACTIVE', 'Dark web extortion portal listed in finance ransom note', 'Exfiltration_Target');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (2, 'SHA256_Hash', 'ef2d127de37b942baad06145e54b0c619a1f22327b2ebbcfbec78f5564afe39d', TIMESTAMP '2024-03-02 05:00:00', TIMESTAMP '2024-03-02 08:00:00', 100, 'AlienVault OTX', 'ACTIVE', 'Hash of ALPHV ransomware encryptor payload', 'Ransomware_Stager');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (4, 'IPv4', '185.190.140.44', TIMESTAMP '2024-03-04 14:45:00', TIMESTAMP '2024-03-04 16:30:00', 92, 'In-House Forensics', 'ACTIVE', 'Cobalt Strike C2 teamserver IP in Romania', 'C2_Server');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (4, 'Domain', 'cdn-update-cloud.org', TIMESTAMP '2024-03-04 15:00:00', TIMESTAMP '2024-03-04 17:00:00', 88, 'In-House Forensics', 'ACTIVE', 'Domain name masquerading as CDN used for beacon callbacks', 'C2_Server');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (5, 'IPv4', '185.220.101.5', TIMESTAMP '2024-03-05 01:10:00', TIMESTAMP '2024-03-05 03:00:00', 75, 'AlienVault OTX', 'REVOKED', 'Tor exit node executing automated network sweeps', 'Phishing_Drop');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (6, 'IPv4', '103.251.167.20', TIMESTAMP '2024-03-05 18:22:15', TIMESTAMP '2024-03-05 20:00:00', 90, 'In-House Forensics', 'ACTIVE', 'Originating IP of SQL injection attack payloads', 'Exfiltration_Target');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (8, 'IPv4', '171.25.193.77', TIMESTAMP '2024-03-06 23:15:00', TIMESTAMP '2024-03-07 01:00:00', 80, 'AlienVault OTX', 'ACTIVE', 'Source IP of VPN brute force dictionary attack', 'Phishing_Drop');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (9, 'Domain', 'malic-invoice-portal.top', TIMESTAMP '2024-03-07 09:05:00', TIMESTAMP '2024-03-07 11:00:00', 94, 'Proofpoint Intel', 'ACTIVE', 'C2 domain serving second-stage payload via malicious Word doc', 'Phishing_Drop');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (9, 'URL', 'http://malic-invoice-portal.top/payload/invoice.exe', TIMESTAMP '2024-03-07 09:10:00', TIMESTAMP '2024-03-07 12:00:00', 96, 'VirusTotal', 'ACTIVE', 'Direct staging URL referenced by malicious macro', 'Ransomware_Stager');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (10, 'Registry_Key', 'HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Wdigest', TIMESTAMP '2024-03-07 16:30:00', TIMESTAMP '2024-03-07 17:00:00', 90, 'In-House Forensics', 'ACTIVE', 'Registry key modified to force plaintext credential caching in LSASS', 'Exfiltration_Target');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (11, 'IPv4', '54.210.122.9', TIMESTAMP '2024-03-08 22:45:00', TIMESTAMP '2024-03-08 23:45:00', 85, 'In-House Forensics', 'ACTIVE', 'Rogue AWS S3 bucket IP receiving exfiltrated database backups', 'Exfiltration_Target');

INSERT INTO INDICATORS (incident_id, indicator_type, indicator_value, first_seen, last_seen, confidence, source, status, description, threat_category)
VALUES (12, 'Domain', 'ns1.c2domain.cc', TIMESTAMP '2024-03-09 15:10:00', TIMESTAMP '2024-03-09 16:30:00', 91, 'Infoblox Intel', 'ACTIVE', 'Authoritative nameserver handling covert DNS tunnel queries', 'C2_Server');

-- ----------------------------------------------------------------------------
-- 10. SEED RESPONSE_ACTIONS (14 Records)
-- ----------------------------------------------------------------------------
INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (1, 4, 'ISOLATE_HOST', 'Server WEB-PORTAL-PROD disconnected from enterprise VLAN and moved to isolated forensic quarantine VLAN.', TIMESTAMP '2024-03-01 02:40:00', 'SUCCESS', 'COMPLETED', 'EMERGENCY', 'Host isolated via managed switch port configuration', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (1, 4, 'BLOCK_IP', 'External IP 194.165.16.14 blocked on perimeter Palo Alto firewalls.', TIMESTAMP '2024-03-01 02:45:00', 'SUCCESS', 'COMPLETED', 'HIGH', 'Rule #9021 pushed to border edge firewalls', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (1, 5, 'APPLY_PATCH', 'Applied vendor security hotfix for CVE-2023-34362 on MOVEit Transfer service.', TIMESTAMP '2024-03-01 06:30:00', 'SUCCESS', 'COMPLETED', 'HIGH', 'Service patched and restarted; vulnerability test passed', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (2, 4, 'ISOLATE_HOST', 'Workstation FS-FINANCE-01 network link severed via EDR agent isolation command.', TIMESTAMP '2024-03-02 04:35:00', 'SUCCESS', 'COMPLETED', 'EMERGENCY', 'EDR host network containment confirmed active', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (2, 5, 'RESTORE_BACKUP', 'Initiated snapshot rollback for finance data share to 03:00 AM snapshot prior to ransomware trigger.', TIMESTAMP '2024-03-02 07:00:00', 'SUCCESS', 'COMPLETED', 'HIGH', 'Volume shadow copy and ZFS immutable snapshot restored intact', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (3, 4, 'REVOKE_CREDENTIALS', 'Forced password reset on all targeted AD service accounts and expired active Kerberos tickets.', TIMESTAMP '2024-03-03 14:00:00', 'SUCCESS', 'COMPLETED', 'HIGH', 'Service principal account passwords rotated with 25-character complexity', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (4, 8, 'KILL_PROCESS', 'Terminated malicious cronjob and killed orphaned beaconing curl processes.', TIMESTAMP '2024-03-04 15:40:00', 'SUCCESS', 'COMPLETED', 'HIGH', 'Processes PID 4122 and 4125 killed via SIGKILL', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (4, 9, 'BLOCK_IP', 'Border gateway rule applied blocking bidirectional traffic to 185.190.140.44.', TIMESTAMP '2024-03-04 15:50:00', 'SUCCESS', 'COMPLETED', 'HIGH', 'Firewall ACL updated; verified 0 egress bytes', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (5, 9, 'BLOCK_IP', 'Automated border ban on 185.220.101.5 for 72 hours due to brute force scan threshold.', TIMESTAMP '2024-03-05 01:25:00', 'SUCCESS', 'COMPLETED', 'NORMAL', 'Fail2ban automated block rule', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (6, 5, 'APPLY_PATCH', 'Deployed parameterized SQL query patch on product search API endpoint.', TIMESTAMP '2024-03-05 23:00:00', 'SUCCESS', 'COMPLETED', 'HIGH', 'Sanitized input verification verified with OWASP ZAP', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (7, 9, 'RATE_LIMIT', 'Configured stream concurrency limits and Cloudflare HTTP/2 reset mitigation rules.', TIMESTAMP '2024-03-06 11:00:00', 'SUCCESS', 'COMPLETED', 'HIGH', 'Gateway CPU dropped from 98% to 14%', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (8, 9, 'BLOCK_IP', 'Banned Tor exit node 171.25.193.77 from SSL-VPN gateway interface.', TIMESTAMP '2024-03-07 00:45:00', 'SUCCESS', 'COMPLETED', 'NORMAL', 'Banned IP list updated on FortiGate', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (9, 2, 'PURGE_EMAIL', 'Triggered automated purge of phishing email with subject Urgent Tax Invoice across mailboxes.', TIMESTAMP '2024-03-07 09:30:00', 'SUCCESS', 'COMPLETED', 'HIGH', '240 mailboxes searched; 12 unread copies purged', 'VERIFIED');

INSERT INTO RESPONSE_ACTIONS (investigation_id, performed_by, action_type, action_description, executed_at, result, action_status, priority, remarks, verification_status)
VALUES (10, 4, 'REVOKE_CREDENTIALS', 'Revoked compromised developer credentials and invalidated all active Kerberos Golden Ticket sessions.', TIMESTAMP '2024-03-07 17:15:00', 'SUCCESS', 'COMPLETED', 'EMERGENCY', 'KRBTGT account password double-rotated in Active Directory', 'VERIFIED');

COMMIT;

PROMPT ============================================================================;
PROMPT DATA SEEDING COMPLETE! ALL 10 TABLES POPULATED WITH 10+ RECORDS EACH.
PROMPT ============================================================================;
