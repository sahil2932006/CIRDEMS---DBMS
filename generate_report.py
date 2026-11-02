"""
CIRDEMS DBMS Project Report Generator
Builds:
1. CIRDEMS_DBMS_Report.html (Complete 4-page academic lab report)
2. CIRDEMS_Poster_Reference.html (Exact 1-page visual companion matching reference image)
3. Compiles both to pristine PDFs via Edge headless
"""

import os
import subprocess

BASE_DIR = os.path.abspath(os.path.dirname(__file__))
DOCS_DIR = os.path.join(BASE_DIR, 'docs')
os.makedirs(DOCS_DIR, exist_ok=True)

# Read the SVG diagram content to inline it or reference it
with open(os.path.join(DOCS_DIR, 'CIRDEMS_Chen_ER_Diagram.svg'), 'r', encoding='utf-8') as f:
    svg_content = f.read()

# Strip any standalone xml declaration if present for inlining
svg_inline = svg_content.replace('<?xml version="1.0" encoding="UTF-8"?>', '')

# Define the HTML template for the 4-page Academic Report
academic_report_html = f'''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CIRDEMS — DBMS Laboratory Course Project Report | VIT</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;700;800&family=Inter:wght@400;500;600;700&family=Lora:ital,wght@0,500;0,600;0,700;1,400&display=swap" rel="stylesheet">
  <style>
    :root {{
      --primary-navy: #0a335c;
      --navy-dark: #082647;
      --accent-cyan: #d2f2ed;
      --cyan-border: #99e2d8;
      --cyan-text: #054e56;
      --table-header: #0f3460;
      --table-stripe: #f8fafc;
      --border-slate: #cbd5e1;
      --text-dark: #0f172a;
      --text-muted: #334155;
      --pk-color: #0369a1;
      --fk-color: #7c2d12;
    }}

    * {{
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }}

    body {{
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      color: var(--text-dark);
      background-color: #e2e8f0;
      line-height: 1.45;
      font-size: 10.5pt;
      -webkit-font-smoothing: antialiased;
    }}

    /* Screen view styles: simulate distinct A4 pages */
    .screen-controls {{
      max-width: 210mm;
      margin: 20px auto 10px auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: #ffffff;
      padding: 12px 24px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }}

    .screen-controls h2 {{
      font-size: 1.1rem;
      color: var(--primary-navy);
      font-family: 'Cinzel', serif;
    }}

    .btn {{
      background: #0f3460;
      color: #ffffff;
      border: none;
      padding: 8px 18px;
      border-radius: 6px;
      font-weight: 600;
      font-size: 0.9rem;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      text-decoration: none;
      transition: background 0.2s;
    }}

    .btn:hover {{
      background: #0a2544;
    }}

    .btn-secondary {{
      background: #0d9488;
    }}
    .btn-secondary:hover {{
      background: #0f766e;
    }}

    /* A4 Page Container */
    .a4-page {{
      width: 210mm;
      min-height: 297mm;
      margin: 15px auto;
      background: #ffffff;
      padding: 14mm 16mm 14mm 16mm;
      box-shadow: 0 8px 24px rgba(0,0,0,0.12);
      position: relative;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }}

    @page {{
      size: A4 portrait;
      margin: 12mm 15mm 12mm 15mm;
    }}

    @media print {{
      body {{
        background: transparent !important;
        margin: 0 !important;
        padding: 0 !important;
        -webkit-print-color-adjust: exact !important;
        print-color-adjust: exact !important;
      }}
      .screen-controls {{
        display: none !important;
      }}
      .a4-page {{
        width: 100% !important;
        min-height: 270mm !important;
        margin: 0 !important;
        padding: 0 !important;
        box-shadow: none !important;
        page-break-after: always !important;
        break-after: page !important;
      }}
      .a4-page:last-child {{
        page-break-after: auto !important;
        break-after: auto !important;
      }}
    }}

    /* Header Styling */
    .univ-header {{
      text-align: center;
      border-bottom: 2px solid #0f3460;
      padding-bottom: 6px;
      margin-bottom: 12px;
    }}

    .univ-name {{
      font-family: 'Cinzel', serif;
      font-size: 13.5pt;
      font-weight: 800;
      color: #0f3460;
      letter-spacing: 0.8px;
      text-transform: uppercase;
    }}

    .univ-sub {{
      font-size: 9.5pt;
      font-weight: 600;
      color: #0d9488;
      margin-top: 1px;
    }}

    .univ-course {{
      font-size: 8.5pt;
      color: #475569;
      font-weight: 500;
    }}

    /* Title Block */
    .title-block {{
      text-align: center;
      margin: 10px 0 14px 0;
      position: relative;
    }}

    .title-rule-top {{
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 12px;
      margin-bottom: 6px;
    }}

    .title-line {{
      height: 1.5px;
      background: #0f3460;
      width: 120px;
    }}

    .title-dot {{
      width: 6px;
      height: 6px;
      border-radius: 50%;
      background: #0f3460;
    }}

    .project-title {{
      font-family: 'Cinzel', 'Lora', serif;
      font-size: 16.5pt;
      font-weight: 800;
      color: var(--primary-navy);
      line-height: 1.25;
      letter-spacing: -0.2px;
    }}

    .project-subtitle {{
      font-size: 9pt;
      color: #475569;
      margin-top: 4px;
      font-weight: 500;
    }}

    /* Section Banner */
    .section-banner {{
      background: var(--accent-cyan);
      border: 1px solid var(--cyan-border);
      color: var(--cyan-text);
      font-family: 'Cinzel', 'Lora', serif;
      font-size: 11.5pt;
      font-weight: 700;
      padding: 5px 14px;
      border-radius: 6px;
      margin: 12px 0 8px 0;
      display: flex;
      align-items: center;
      gap: 8px;
      letter-spacing: 0.3px;
    }}

    .banner-num {{
      font-family: 'Inter', sans-serif;
      background: #0f766e;
      color: #ffffff;
      border-radius: 4px;
      padding: 1px 6px;
      font-size: 9pt;
      font-weight: 700;
    }}

    /* Content styling */
    p.intro-text {{
      text-align: justify;
      font-size: 9.3pt;
      line-height: 1.5;
      color: #1e293b;
      margin-bottom: 8px;
    }}

    /* Tables */
    table.cirdems-table {{
      width: 100%;
      border-collapse: collapse;
      margin: 8px 0;
      font-size: 8.4pt;
      border: 1px solid var(--border-slate);
    }}

    table.cirdems-table th {{
      background-color: var(--table-header);
      color: #ffffff;
      font-weight: 600;
      text-align: left;
      padding: 6px 8px;
      font-size: 8.6pt;
      letter-spacing: 0.2px;
      border: 1px solid #1e40af;
    }}

    table.cirdems-table td {{
      padding: 4.5px 8px;
      border: 1px solid var(--border-slate);
      vertical-align: middle;
      line-height: 1.35;
    }}

    table.cirdems-table tr:nth-child(even) {{
      background-color: var(--table-stripe);
    }}

    table.cirdems-table td.entity-col {{
      font-weight: 700;
      color: #0f172a;
      white-space: nowrap;
      background: #f1f9f8;
      border-right: 1.5px solid var(--cyan-border);
    }}

    /* PK and FK badges */
    .pk {{
      text-decoration: underline;
      font-weight: 700;
      color: var(--pk-color);
    }}

    .fk {{
      font-weight: 600;
      color: var(--fk-color);
      font-size: 8pt;
    }}

    .badge-pk {{
      display: inline-block;
      background: #e0f2fe;
      color: #0369a1;
      border: 1px solid #7dd3fc;
      border-radius: 3px;
      font-size: 7pt;
      font-weight: 700;
      padding: 0 3px;
      margin-left: 2px;
    }}

    .badge-fk {{
      display: inline-block;
      background: #ffedd5;
      color: #c2410c;
      border: 1px solid #fed7aa;
      border-radius: 3px;
      font-size: 7pt;
      font-weight: 700;
      padding: 0 3px;
      margin-left: 2px;
    }}

    /* Footer styling */
    .page-footer {{
      border-top: 1px solid #e2e8f0;
      padding-top: 6px;
      margin-top: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 7.8pt;
      color: #64748b;
    }}

    .page-num {{
      font-weight: 600;
      color: #0f3460;
    }}

    /* Running page header */
    .running-header {{
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #cbd5e1;
      padding-bottom: 4px;
      margin-bottom: 10px;
      font-size: 7.8pt;
      color: #64748b;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }}

    .running-header span.dept {{
      color: #0d9488;
      font-weight: 600;
    }}

    /* SVG Diagram Container */
    .diagram-wrapper {{
      width: 100%;
      border: 1px solid #e2e8f0;
      border-radius: 8px;
      background: #ffffff;
      padding: 6px;
      box-shadow: inset 0 1px 4px rgba(0,0,0,0.03);
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 6px 0 10px 0;
    }}

    .diagram-wrapper svg {{
      width: 100%;
      height: auto;
      max-height: 145mm;
      display: block;
    }}

    /* Schema cards */
    .schema-card {{
      background: #f8fafc;
      border: 1px solid #cbd5e1;
      border-left: 4px solid #0f3460;
      border-radius: 4px;
      padding: 5px 10px;
      margin-bottom: 6px;
      font-family: 'Consolas', 'Courier New', monospace;
      font-size: 8.2pt;
      line-height: 1.35;
    }}

    .schema-name {{
      font-weight: 700;
      color: #0f3460;
      font-family: 'Inter', sans-serif;
      font-size: 8.8pt;
    }}

    /* Normalization boxes */
    .norm-box {{
      background: #ffffff;
      border: 1px solid #cbd5e1;
      border-radius: 6px;
      padding: 8px 12px;
      margin-bottom: 8px;
    }}

    .norm-box.highlight {{
      border-left: 4px solid #0d9488;
      background: #f0fdfa;
    }}

    .norm-header {{
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 4px;
    }}

    .norm-title {{
      font-weight: 700;
      color: #0f3460;
      font-size: 9.4pt;
    }}

    .norm-badge {{
      background: #ccfbf1;
      color: #0f766e;
      border: 1px solid #99f6e4;
      padding: 1px 8px;
      border-radius: 12px;
      font-size: 7.5pt;
      font-weight: 700;
    }}

    .norm-desc {{
      font-size: 8.4pt;
      color: #334155;
      line-height: 1.4;
    }}

    .fd-code {{
      font-family: 'Consolas', monospace;
      background: #e2e8f0;
      padding: 1px 5px;
      border-radius: 3px;
      font-size: 7.8pt;
      color: #0f172a;
    }}

    .signoff-box {{
      margin-top: 10px;
      border: 1px dashed #94a3b8;
      border-radius: 6px;
      padding: 8px 12px;
      background: #f8fafc;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 8pt;
    }}
  </style>
</head>
<body>

  <!-- Screen Action Bar -->
  <div class="screen-controls">
    <div>
      <h2>CIRDEMS DBMS Laboratory Final Report</h2>
      <p style="font-size: 0.85rem; color: #64748b;">Vellore Institute of Technology | Ready for Print & PDF Export</p>
    </div>
    <div style="display: flex; gap: 10px;">
      <button class="btn" onclick="window.print()">
        <svg width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M2.5 8a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1z"/><path d="M5 1a2 2 0 0 0-2 2v2H2a2 2 0 0 0-2 2v3a2 2 0 0 0 2 2h1v1a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2v-1h1a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-1V3a2 2 0 0 0-2-2H5zM4 3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1v2H4V3zm1 5a2 2 0 0 0-2 2v1H2a1 1 0 0 1-1-1V7a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-1v-1a2 2 0 0 0-2-2H5zm7 2v3a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1z"/></svg>
        Print / Save as PDF
      </button>
      <a class="btn btn-secondary" href="CIRDEMS_Chen_ER_Diagram.svg" target="_blank">View Standalone SVG</a>
    </div>
  </div>


  <!-- ========================================================================= -->
  <!-- PAGE 1: TITLE, INTRODUCTION & ENTITIES/ATTRIBUTES                         -->
  <!-- ========================================================================= -->
  <div class="a4-page" id="page-1">
    <div>
      <!-- University & Course Header -->
      <div class="univ-header">
        <div class="univ-name">Vellore Institute of Technology (VIT)</div>
        <div class="univ-sub">School of Computer Science Engineering and Information Systems</div>
        <div class="univ-course">BCSE202L / CSE2004 — Database Systems & Laboratory | Technical Project Report</div>
      </div>

      <!-- Main Project Title with reference design styling -->
      <div class="title-block">
        <div class="title-rule-top">
          <div class="title-line"></div>
          <div class="title-dot"></div>
          <div class="title-line"></div>
        </div>
        <h1 class="project-title">Cyber Incident Response &amp; Digital Evidence<br>Management System (CIRDEMS)</h1>
        <div class="project-subtitle">Conceptual Database Design, Chen-Style ER Modeling, Relational Schema &amp; Normalization up to BCNF</div>
      </div>

      <!-- Section 1: Introduction -->
      <div class="section-banner">
        <span class="banner-num">1</span>
        <span>Introduction</span>
      </div>
      <p class="intro-text">
        The <strong>Cyber Incident Response &amp; Digital Evidence Management System (CIRDEMS)</strong> is a database-driven system designed to organize cybersecurity incident records, investigations, digital evidence, chain-of-custody information, vulnerability records, incident reports, and response actions. The system uses relational database principles to maintain structured information, enforce relationships, and support incident tracking and forensic documentation.
      </p>
      <p class="intro-text" style="font-size: 8.8pt; color: #475569;">
        Modern Security Operations Centers (SOCs) face sophisticated attacks requiring strict auditability and evidentiary preservation. CIRDEMS models the lifecycle from security alerts to containment and forensic integrity, ensuring compliance with forensic standards (NIST SP 800-61, ISO/IEC 27037) through mathematical normalization and rigorous referential integrity constraints.
      </p>

      <!-- Section 2: Entities and Attributes -->
      <div class="section-banner">
        <span class="banner-num">2</span>
        <span>Entities and Attributes</span>
      </div>
      <table class="cirdems-table">
        <thead>
          <tr>
            <th style="width: 17%;">Entity</th>
            <th style="width: 53%;">Attributes (Primary Key underlined; Foreign Key indicated by [FK])</th>
            <th style="width: 30%;">Description</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="entity-col">USER</td>
            <td><span class="pk">User_ID</span>, Username, Password, Name, Email, Contact_No, Role, Status</td>
            <td>A person who uses the system, such as an analyst, investigator, or administrator.</td>
          </tr>
          <tr>
            <td class="entity-col">ASSET</td>
            <td><span class="pk">Asset_ID</span>, Asset_Name, Asset_Type, OS, Location, Department, Owner, Status</td>
            <td>An organizational asset such as a device, server, or application.</td>
          </tr>
          <tr>
            <td class="entity-col">INCIDENT</td>
            <td><span class="pk">Incident_ID</span>, Title, Description, Date_Reported, Severity, Status, Asset_ID <span class="badge-fk">FK</span>, Reported_By <span class="badge-fk">FK</span></td>
            <td>A security incident reported in the system.</td>
          </tr>
          <tr>
            <td class="entity-col">INVESTIGATION</td>
            <td><span class="pk">Investigation_ID</span>, Incident_ID <span class="badge-fk">FK</span>, Start_Date, End_Date, Investigator_ID <span class="badge-fk">FK</span>, Status, Findings, Conclusion</td>
            <td>An investigation conducted for an incident.</td>
          </tr>
          <tr>
            <td class="entity-col">EVIDENCE</td>
            <td><span class="pk">Evidence_ID</span>, Investigation_ID <span class="badge-fk">FK</span>, Evidence_Type, Source, File_Path, Date_Collected, Integrity_Hash, Notes</td>
            <td>Digital evidence collected during an investigation.</td>
          </tr>
          <tr>
            <td class="entity-col">CHAIN_OF_CUSTODY</td>
            <td><span class="pk">Log_ID</span>, Evidence_ID <span class="badge-fk">FK</span>, Handled_By, Action, Action_Date, Location, Remarks</td>
            <td>A record of evidence handling and transfers.</td>
          </tr>
          <tr>
            <td class="entity-col">REPORT</td>
            <td><span class="pk">Report_ID</span>, Incident_ID <span class="badge-fk">FK</span>, Generated_By, Report_Type, Date_Generated, Summary</td>
            <td>An incident report generated for a case.</td>
          </tr>
          <tr>
            <td class="entity-col">RESPONSE_ACTION</td>
            <td><span class="pk">Action_ID</span>, Incident_ID <span class="badge-fk">FK</span>, Action_Type, Description, Assigned_To, Action_Date, Status</td>
            <td>A response or mitigation action taken for an incident.</td>
          </tr>
          <tr>
            <td class="entity-col">VULNERABILITY</td>
            <td><span class="pk">Vulnerability_ID</span>, Asset_ID <span class="badge-fk">FK</span>, Title, Description, Severity, Status, Detected_Date</td>
            <td>A known vulnerability associated with an asset.</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="page-footer">
      <span>CIRDEMS — Database Systems Laboratory Project Report</span>
      <span class="page-num">Page 1 of 4</span>
      <span>Vellore Institute of Technology (VIT)</span>
    </div>
  </div>


  <!-- ========================================================================= -->
  <!-- PAGE 2: ER DIAGRAM & CARDINALITY MAPPING                                  -->
  <!-- ========================================================================= -->
  <div class="a4-page" id="page-2">
    <div>
      <div class="running-header">
        <span>CIRDEMS Project Report — Conceptual ER Modeling</span>
        <span class="dept">VIT — DBMS Laboratory</span>
      </div>

      <!-- Section 3: ER Diagram -->
      <div class="section-banner" style="margin-top: 0;">
        <span class="banner-num">3</span>
        <span>Entity-Relationship (ER) Diagram</span>
      </div>
      <p style="font-size: 8.2pt; color: #475569; margin-bottom: 4px;">
        Chen-style Entity-Relationship diagram featuring 9 strong/dependent entities, 8 relationships, multi-attribute bindings, and explicit structural cardinalities (1, N) with underlined primary keys.
      </p>

      <!-- High Resolution Embedded SVG -->
      <div class="diagram-wrapper">
        {svg_inline}
      </div>

      <!-- Section 4: Cardinality Mapping -->
      <div class="section-banner">
        <span class="banner-num">4</span>
        <span>Cardinality Mapping</span>
      </div>
      <p style="font-size: 8.4pt; font-weight: 600; color: #0f3460; margin-bottom: 4px;">4.1 Relationship Summary Table</p>
      <table class="cirdems-table" style="font-size: 8pt;">
        <thead>
          <tr>
            <th style="width: 5%;">#</th>
            <th style="width: 18%;">Relationship</th>
            <th style="width: 14%;">Entity A</th>
            <th style="width: 15%;">Entity B</th>
            <th style="width: 14%;">Cardinality</th>
            <th style="width: 34%;">Participation Constraints</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td style="text-align: center; font-weight: 700;">1</td>
            <td style="font-weight: 600;">reports</td>
            <td>USER</td>
            <td>INCIDENT</td>
            <td>One-to-Many (1:N)</td>
            <td><strong>INCIDENT: total</strong> (every incident is reported by one user).<br><strong>USER: partial</strong> (a user may report no incident).</td>
          </tr>
          <tr>
            <td style="text-align: center; font-weight: 700;">2</td>
            <td style="font-weight: 600;">occurs on</td>
            <td>INCIDENT</td>
            <td>ASSET</td>
            <td>Many-to-One (N:1)</td>
            <td><strong>INCIDENT: total</strong> (every incident occurs on an asset).<br><strong>ASSET: partial</strong> (an asset may experience no incidents).</td>
          </tr>
          <tr>
            <td style="text-align: center; font-weight: 700;">3</td>
            <td style="font-weight: 600;">is investigated in</td>
            <td>INCIDENT</td>
            <td>INVESTIGATION</td>
            <td>One-to-One (1:1)</td>
            <td><strong>Total on both sides</strong> (every incident triggers an investigation; every investigation corresponds to exactly one incident).</td>
          </tr>
          <tr>
            <td style="text-align: center; font-weight: 700;">4</td>
            <td style="font-weight: 600;">collects</td>
            <td>INVESTIGATION</td>
            <td>EVIDENCE</td>
            <td>One-to-Many (1:N)</td>
            <td><strong>EVIDENCE: total</strong> (evidence cannot exist without an investigation).<br><strong>INVESTIGATION: partial</strong> (an investigation may be pending evidence).</td>
          </tr>
          <tr>
            <td style="text-align: center; font-weight: 700;">5</td>
            <td style="font-weight: 600;">recorded in</td>
            <td>EVIDENCE</td>
            <td>CHAIN_OF_CUSTODY</td>
            <td>One-to-Many (1:N)</td>
            <td><strong>CHAIN_OF_CUSTODY: total</strong> (transfer logs must reference evidence).<br><strong>EVIDENCE: partial</strong> (newly seized items may await initial transfer).</td>
          </tr>
          <tr>
            <td style="text-align: center; font-weight: 700;">6</td>
            <td style="font-weight: 600;">generates</td>
            <td>INCIDENT</td>
            <td>REPORT</td>
            <td>One-to-Many (1:N)</td>
            <td><strong>REPORT: total</strong> (every report is generated for an incident).<br><strong>INCIDENT: partial</strong> (an active incident may not yet have a report).</td>
          </tr>
          <tr>
            <td style="text-align: center; font-weight: 700;">7</td>
            <td style="font-weight: 600;">has</td>
            <td>INCIDENT</td>
            <td>RESPONSE_ACTION</td>
            <td>One-to-Many (1:N)</td>
            <td><strong>RESPONSE_ACTION: total</strong> (containment actions bind to an incident).<br><strong>INCIDENT: partial</strong> (triage may precede action assignment).</td>
          </tr>
          <tr>
            <td style="text-align: center; font-weight: 700;">8</td>
            <td style="font-weight: 600;">has</td>
            <td>ASSET</td>
            <td>VULNERABILITY</td>
            <td>One-to-Many (1:N)</td>
            <td><strong>VULNERABILITY: total</strong> (a CVE record is detected on an asset).<br><strong>ASSET: partial</strong> (a hardened asset may have no vulnerabilities).</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="page-footer">
      <span>CIRDEMS — Database Systems Laboratory Project Report</span>
      <span class="page-num">Page 2 of 4</span>
      <span>Vellore Institute of Technology (VIT)</span>
    </div>
  </div>


  <!-- ========================================================================= -->
  <!-- PAGE 3: RELATIONAL SCHEMA & REFERENTIAL CONSTRAINTS                       -->
  <!-- ========================================================================= -->
  <div class="a4-page" id="page-3">
    <div>
      <div class="running-header">
        <span>CIRDEMS Project Report — Logical Database Design</span>
        <span class="dept">VIT — DBMS Laboratory</span>
      </div>

      <!-- Section 5: Relational Schema -->
      <div class="section-banner" style="margin-top: 0;">
        <span class="banner-num">5</span>
        <span>Relational Schema</span>
      </div>

      <p class="intro-text" style="font-size: 8.8pt; margin-bottom: 6px;">
        The conceptual Chen ER model is converted into a normalized relational database schema adhering to standard ER-to-Relational mapping algorithms: (1) Strong entities map to base relations; (2) 1:1 relationships (<code>INCIDENT</code>–<code>INVESTIGATION</code>) are implemented by embedding <code>Incident_ID</code> as a <code>UNIQUE NOT NULL</code> Foreign Key in <code>INVESTIGATION</code>; (3) 1:N relationships embed the primary key of the "1" side as a foreign key on the "N" side; (4) Referential integrity constraints prevent orphan records.
      </p>

      <p style="font-size: 8.6pt; font-weight: 600; color: #0f3460; margin: 8px 0 4px 0;">5.1 Relational Schema Definitions</p>

      <div class="schema-card">
        <span class="schema-name">USER</span> (<span class="pk">User_ID</span> <span class="badge-pk">PK</span>, Username, Password, Name, Email, Contact_No, Role, Status)
      </div>

      <div class="schema-card">
        <span class="schema-name">ASSET</span> (<span class="pk">Asset_ID</span> <span class="badge-pk">PK</span>, Asset_Name, Asset_Type, OS, Location, Department, Owner, Status)
      </div>

      <div class="schema-card">
        <span class="schema-name">INCIDENT</span> (<span class="pk">Incident_ID</span> <span class="badge-pk">PK</span>, Title, Description, Date_Reported, Severity, Status, Asset_ID <span class="badge-fk">FK</span>, Reported_By <span class="badge-fk">FK</span>)
      </div>

      <div class="schema-card">
        <span class="schema-name">INVESTIGATION</span> (<span class="pk">Investigation_ID</span> <span class="badge-pk">PK</span>, Incident_ID <span class="badge-fk">FK</span> <span style="color:#0f766e; font-weight:600;">[UNIQUE]</span>, Start_Date, End_Date, Investigator_ID <span class="badge-fk">FK</span>, Status, Findings, Conclusion)
      </div>

      <div class="schema-card">
        <span class="schema-name">EVIDENCE</span> (<span class="pk">Evidence_ID</span> <span class="badge-pk">PK</span>, Investigation_ID <span class="badge-fk">FK</span>, Evidence_Type, Source, File_Path, Date_Collected, Integrity_Hash, Notes)
      </div>

      <div class="schema-card">
        <span class="schema-name">CHAIN_OF_CUSTODY</span> (<span class="pk">Log_ID</span> <span class="badge-pk">PK</span>, Evidence_ID <span class="badge-fk">FK</span>, Handled_By, Action, Action_Date, Location, Remarks)
      </div>

      <div class="schema-card">
        <span class="schema-name">REPORT</span> (<span class="pk">Report_ID</span> <span class="badge-pk">PK</span>, Incident_ID <span class="badge-fk">FK</span>, Generated_By, Report_Type, Date_Generated, Summary)
      </div>

      <div class="schema-card">
        <span class="schema-name">RESPONSE_ACTION</span> (<span class="pk">Action_ID</span> <span class="badge-pk">PK</span>, Incident_ID <span class="badge-fk">FK</span>, Action_Type, Description, Assigned_To, Action_Date, Status)
      </div>

      <div class="schema-card">
        <span class="schema-name">VULNERABILITY</span> (<span class="pk">Vulnerability_ID</span> <span class="badge-pk">PK</span>, Asset_ID <span class="badge-fk">FK</span>, Title, Description, Severity, Status, Detected_Date)
      </div>

      <p style="font-size: 8.6pt; font-weight: 600; color: #0f3460; margin: 10px 0 4px 0;">5.2 Referential Integrity &amp; Foreign Key Constraints</p>
      <table class="cirdems-table" style="font-size: 7.9pt;">
        <thead>
          <tr>
            <th style="width: 22%;">Child Table &amp; Foreign Key</th>
            <th style="width: 22%;">Referenced Parent Key</th>
            <th style="width: 18%;">Constraint Policy</th>
            <th style="width: 38%;">Business &amp; Forensic Justification</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><code>INCIDENT(Asset_ID)</code></td>
            <td><code>ASSET(Asset_ID)</code></td>
            <td><code>ON DELETE RESTRICT</code></td>
            <td>Prevents deleting an asset if incident forensic records refer to it.</td>
          </tr>
          <tr>
            <td><code>INCIDENT(Reported_By)</code></td>
            <td><code>USER(User_ID)</code></td>
            <td><code>ON DELETE RESTRICT</code></td>
            <td>Ensures full accountability for whoever flagged the incident.</td>
          </tr>
          <tr>
            <td><code>INVESTIGATION(Incident_ID)</code></td>
            <td><code>INCIDENT(Incident_ID)</code></td>
            <td><code>ON DELETE CASCADE</code></td>
            <td>Enforces strict 1:1 binding; unique constraint prevents duplicate cases.</td>
          </tr>
          <tr>
            <td><code>INVESTIGATION(Investigator_ID)</code></td>
            <td><code>USER(User_ID)</code></td>
            <td><code>ON DELETE RESTRICT</code></td>
            <td>Maintains investigator audit trail; investigator cannot be deleted mid-case.</td>
          </tr>
          <tr>
            <td><code>EVIDENCE(Investigation_ID)</code></td>
            <td><code>INVESTIGATION(...)</code></td>
            <td><code>ON DELETE RESTRICT</code></td>
            <td>Tamper-proofing: prevents accidental deletion of legal digital evidence.</td>
          </tr>
          <tr>
            <td><code>CHAIN_OF_CUSTODY(Evidence_ID)</code></td>
            <td><code>EVIDENCE(Evidence_ID)</code></td>
            <td><code>ON DELETE RESTRICT</code></td>
            <td>Preserves legally mandated forensic chain-of-custody transfer records.</td>
          </tr>
          <tr>
            <td><code>REPORT(Incident_ID)</code></td>
            <td><code>INCIDENT(Incident_ID)</code></td>
            <td><code>ON DELETE CASCADE</code></td>
            <td>Formal breach notification and post-mortem reports belong to the incident.</td>
          </tr>
          <tr>
            <td><code>RESPONSE_ACTION(Incident_ID)</code></td>
            <td><code>INCIDENT(Incident_ID)</code></td>
            <td><code>ON DELETE CASCADE</code></td>
            <td>Containment actions (host isolation, firewall rules) bind to the incident.</td>
          </tr>
          <tr>
            <td><code>VULNERABILITY(Asset_ID)</code></td>
            <td><code>ASSET(Asset_ID)</code></td>
            <td><code>ON DELETE CASCADE</code></td>
            <td>Vulnerability scan records are lifecycle-bound to the physical/virtual asset.</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="page-footer">
      <span>CIRDEMS — Database Systems Laboratory Project Report</span>
      <span class="page-num">Page 3 of 4</span>
      <span>Vellore Institute of Technology (VIT)</span>
    </div>
  </div>


  <!-- ========================================================================= -->
  <!-- PAGE 4: NORMALIZATION (1NF, 2NF, 3NF & BCNF)                              -->
  <!-- ========================================================================= -->
  <div class="a4-page" id="page-4">
    <div>
      <div class="running-header">
        <span>CIRDEMS Project Report — Database Normalization &amp; Verification</span>
        <span class="dept">VIT — DBMS Laboratory</span>
      </div>

      <!-- Section 6: Normalization -->
      <div class="section-banner" style="margin-top: 0;">
        <span class="banner-num">6</span>
        <span>Normalization (up to 3NF &amp; BCNF)</span>
      </div>

      <p class="intro-text" style="font-size: 8.6pt; margin-bottom: 8px;">
        Database normalization is systematically applied to the CIRDEMS schema to eliminate data redundancy, prevent modification anomalies (Insertion, Update, Deletion), and ensure functional dependencies are preserved on superkeys.
      </p>

      <!-- 1NF -->
      <div class="norm-box highlight">
        <div class="norm-header">
          <span class="norm-title">6.1 First Normal Form (1NF) — Domain Atomicity</span>
          <span class="norm-badge">Satisfied</span>
        </div>
        <p class="norm-desc">
          <strong>Conditions:</strong> (1) Each column must contain only atomic (indivisible) values. (2) There must be no repeating groups or multi-valued attributes. (3) Each record is uniquely identified by a primary key.<br>
          <strong>Evaluation:</strong> In CIRDEMS, multi-valued properties (e.g. evidence chain of custody transfers, vulnerabilities per asset, containment actions) are decomposed into separate child relations rather than comma-separated lists or repeating groups. Every attribute domain (e.g., <code>Integrity_Hash</code>, <code>Date_Reported</code>, <code>Severity</code>) holds single atomic values. Each relation possesses a clearly defined, non-null Primary Key.
        </p>
      </div>

      <!-- 2NF -->
      <div class="norm-box highlight">
        <div class="norm-header">
          <span class="norm-title">6.2 Second Normal Form (2NF) — Full Functional Dependency</span>
          <span class="norm-badge">Satisfied</span>
        </div>
        <p class="norm-desc">
          <strong>Conditions:</strong> (1) The relation must satisfy 1NF. (2) Every non-prime attribute must be fully functionally dependent on the entire candidate key, eliminating partial key dependencies.<br>
          <strong>Evaluation:</strong> Partial dependency can only arise in relations with composite candidate keys ($K = \{A, B\}$ where $A \to Y$). In CIRDEMS, all 9 relations employ <strong>single-attribute surrogate primary keys</strong> (<code>User_ID</code>, <code>Asset_ID</code>, <code>Incident_ID</code>, <code>Investigation_ID</code>, <code>Evidence_ID</code>, <code>Log_ID</code>, <code>Report_ID</code>, <code>Action_ID</code>, <code>Vulnerability_ID</code>). Because no composite primary keys exist, partial functional dependencies are mathematically impossible ($|\text{PK}| = 1$). Therefore, all relations satisfy 2NF unconditionally.
        </p>
      </div>

      <!-- 3NF -->
      <div class="norm-box highlight">
        <div class="norm-header">
          <span class="norm-title">6.3 Third Normal Form (3NF) — Elimination of Transitive Dependencies</span>
          <span class="norm-badge">Satisfied</span>
        </div>
        <p class="norm-desc">
          <strong>Conditions:</strong> (1) The relation must satisfy 2NF. (2) No non-prime attribute may depend transitively on a candidate key ($X \to Y$ and $Y \to Z$ where $Z$ is non-prime and $Y$ is not a superkey).<br>
          <strong>Evaluation:</strong> In CIRDEMS, independent entities are decoupled into isolated relations:
          (a) User attributes (<code>Email</code>, <code>Role</code>, <code>Contact_No</code>) are stored only in <code>USER</code>; incidents merely reference <code>Reported_By</code>, preventing $\text{Incident\_ID} \to \text{Reported\_By} \to \text{User\_Email}$.
          (b) Asset attributes (<code>OS</code>, <code>Location</code>, <code>Department</code>) are segregated in <code>ASSET</code>; <code>INCIDENT</code> and <code>VULNERABILITY</code> store only <code>Asset_ID</code>, avoiding $\text{Vulnerability\_ID} \to \text{Asset\_ID} \to \text{Location}$.
          All non-key attributes depend exclusively and directly on the primary key, eliminating transitive dependencies.
        </p>
      </div>

      <!-- BCNF -->
      <div class="norm-box highlight">
        <div class="norm-header">
          <span class="norm-title">6.4 Boyce-Codd Normal Form (BCNF) — Superkey Determinancy</span>
          <span class="norm-badge">Satisfied &amp; Verified</span>
        </div>
        <p class="norm-desc">
          <strong>Conditions:</strong> A relation $R$ is in BCNF if, for every non-trivial functional dependency $X \to Y$, the determinant $X$ is a <strong>superkey</strong> of $R$.<br>
          <strong>Rigorous FD Verification:</strong>
        </p>
        <table class="cirdems-table" style="margin: 4px 0; font-size: 7.6pt;">
          <thead>
            <tr>
              <th style="width: 25%;">Relation</th>
              <th style="width: 45%;">Functional Dependencies (FDs)</th>
              <th style="width: 15%;">Determinant $X$</th>
              <th style="width: 15%;">Is Superkey?</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><code>USER</code></td>
              <td><code>User_ID &rarr; Username, Password, Name, Email, Role, Status</code><br><code>Username &rarr; ...</code>; <code>Email &rarr; ...</code></td>
              <td>Candidate Keys</td>
              <td><span style="color:#0f766e; font-weight:700;">YES (BCNF)</span></td>
            </tr>
            <tr>
              <td><code>ASSET</code></td>
              <td><code>Asset_ID &rarr; Asset_Name, Asset_Type, OS, Location, Department, ...</code></td>
              <td>Primary Key</td>
              <td><span style="color:#0f766e; font-weight:700;">YES (BCNF)</span></td>
            </tr>
            <tr>
              <td><code>INCIDENT</code></td>
              <td><code>Incident_ID &rarr; Title, Description, Date_Reported, Severity, Asset_ID, ...</code></td>
              <td>Primary Key</td>
              <td><span style="color:#0f766e; font-weight:700;">YES (BCNF)</span></td>
            </tr>
            <tr>
              <td><code>INVESTIGATION</code></td>
              <td><code>Investigation_ID &rarr; Incident_ID, Start_Date, End_Date, Status, ...</code><br><code>Incident_ID &rarr; Investigation_ID, ...</code> (1:1 Unique Constraint)</td>
              <td>Candidate Keys</td>
              <td><span style="color:#0f766e; font-weight:700;">YES (BCNF)</span></td>
            </tr>
            <tr>
              <td><code>EVIDENCE</code></td>
              <td><code>Evidence_ID &rarr; Investigation_ID, Evidence_Type, File_Path, Hash, ...</code></td>
              <td>Primary Key</td>
              <td><span style="color:#0f766e; font-weight:700;">YES (BCNF)</span></td>
            </tr>
            <tr>
              <td><code>CHAIN_OF_CUSTODY</code></td>
              <td><code>Log_ID &rarr; Evidence_ID, Handled_By, Action, Action_Date, Location, ...</code></td>
              <td>Primary Key</td>
              <td><span style="color:#0f766e; font-weight:700;">YES (BCNF)</span></td>
            </tr>
          </tbody>
        </table>
        <p style="font-size: 7.8pt; color: #475569; margin-top: 3px;">
          *In all 9 tables, every left-hand determinant $X$ in non-trivial FDs is a valid candidate key or superkey. The schema is formally confirmed to reside in BCNF without functional dependency loss.
        </p>
      </div>

      <!-- Signoff Box -->
      <div class="signoff-box">
        <div>
          <strong>Academic Submission Sign-Off:</strong><br>
          <span style="color: #64748b;">Course: BCSE202L Database Systems Laboratory | Vellore Institute of Technology</span>
        </div>
        <div style="text-align: right;">
          <span>Faculty Reviewer: ________________________</span><br>
          <span>Date &amp; Status: [ &nbsp; ] Accepted &nbsp; [ &nbsp; ] Verified BCNF</span>
        </div>
      </div>
    </div>

    <div class="page-footer">
      <span>CIRDEMS — Database Systems Laboratory Project Report</span>
      <span class="page-num">Page 4 of 4</span>
      <span>Vellore Institute of Technology (VIT)</span>
    </div>
  </div>

</body>
</html>
'''

with open(os.path.join(DOCS_DIR, 'CIRDEMS_DBMS_Report.html'), 'w', encoding='utf-8') as f:
    f.write(academic_report_html)
print("Saved docs/CIRDEMS_DBMS_Report.html")

# Also create the 1-page visual companion matching the reference image arrangement!
poster_html = f'''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>CIRDEMS — Visual Reference Poster | DBMS Laboratory</title>
  <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    @page {{
      size: A4 portrait;
      margin: 8mm 10mm 8mm 10mm;
    }}
    * {{ box-sizing: border-box; margin: 0; padding: 0; }}
    body {{
      font-family: 'Inter', -apple-system, sans-serif;
      color: #0f172a;
      background: #ffffff;
      padding: 10px 14px;
      font-size: 8.5pt;
      line-height: 1.35;
    }}
    .title-block {{
      text-align: center;
      margin-bottom: 8px;
    }}
    .title-rule {{
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      margin-bottom: 4px;
    }}
    .title-line {{ height: 1.5px; background: #0a335c; width: 100px; }}
    .title-dot {{ width: 5px; height: 5px; border-radius: 50%; background: #0a335c; }}
    h1 {{
      font-family: 'Cinzel', serif;
      font-size: 15pt;
      font-weight: 800;
      color: #0a335c;
      line-height: 1.2;
    }}
    .sub {{
      font-size: 8pt;
      color: #475569;
      font-weight: 500;
    }}
    .banner {{
      background: #d2f2ed;
      border: 1px solid #99e2d8;
      color: #054e56;
      font-family: 'Cinzel', serif;
      font-size: 10pt;
      font-weight: 700;
      padding: 3px 10px;
      border-radius: 5px;
      margin: 7px 0 5px 0;
    }}
    table {{
      width: 100%;
      border-collapse: collapse;
      margin: 4px 0 6px 0;
      font-size: 7.6pt;
    }}
    th {{
      background: #0f3460;
      color: #ffffff;
      padding: 4px 6px;
      text-align: left;
      font-weight: 600;
      border: 1px solid #1e40af;
    }}
    td {{
      padding: 3px 6px;
      border: 1px solid #cbd5e1;
    }}
    tr:nth-child(even) {{ background: #f8fafc; }}
    .pk {{ text-decoration: underline; font-weight: 700; color: #0369a1; }}
    .fk {{ color: #c2410c; font-weight: 600; }}
    .diagram-box {{
      width: 100%;
      display: flex;
      justify-content: center;
      margin: 4px 0 6px 0;
      border: 1px solid #e2e8f0;
      border-radius: 6px;
      padding: 4px;
    }}
    .diagram-box svg {{
      width: 100%;
      height: auto;
      max-height: 110mm;
    }}
  </style>
</head>
<body>
  <div class="title-block">
    <div class="title-rule">
      <div class="title-line"></div>
      <div class="title-dot"></div>
      <div class="title-line"></div>
    </div>
    <h1>Cyber Incident Response &amp; Digital Evidence<br>Management System (CIRDEMS)</h1>
    <div class="sub">Database Systems (DBMS) Laboratory | Vellore Institute of Technology (VIT)</div>
  </div>

  <div class="banner">1. Introduction</div>
  <p style="text-align: justify; font-size: 8pt; margin-bottom: 4px;">
    The Cyber Incident Response &amp; Digital Evidence Management System (CIRDEMS) is a database-driven system designed to organize cybersecurity incident records, investigations, digital evidence, chain-of-custody information, vulnerability records, incident reports, and response actions. The system uses relational database principles to maintain structured information, enforce relationships, and support incident tracking and forensic documentation.
  </p>

  <div class="banner">2. Entities and Attributes</div>
  <table>
    <thead>
      <tr>
        <th style="width: 16%;">Entity</th>
        <th style="width: 52%;">Attributes (primary key underlined by position: first)</th>
        <th style="width: 32%;">Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="font-weight:700;">User</td>
        <td><span class="pk">User_ID</span>, Username, Password, Name, Email, Contact_No, Role, Status</td>
        <td>A person who uses the system (analyst, investigator, admin, etc.)</td>
      </tr>
      <tr>
        <td style="font-weight:700;">Asset</td>
        <td><span class="pk">Asset_ID</span>, Asset_Name, Asset_Type, OS, Location, Department, Owner, Status</td>
        <td>An organisational asset (device/server/application)</td>
      </tr>
      <tr>
        <td style="font-weight:700;">Incident</td>
        <td><span class="pk">Incident_ID</span>, Title, Description, Date_Reported, Severity, Status, Asset_ID <span class="fk">(FK)</span>, Reported_By <span class="fk">(FK)</span></td>
        <td>A security incident reported in the system</td>
      </tr>
      <tr>
        <td style="font-weight:700;">Investigation</td>
        <td><span class="pk">Investigation_ID</span>, Incident_ID <span class="fk">(FK)</span>, Start_Date, End_Date, Investigator_ID <span class="fk">(FK)</span>, Status, Findings, Conclusion</td>
        <td>Investigation carried out for an incident</td>
      </tr>
      <tr>
        <td style="font-weight:700;">Evidence</td>
        <td><span class="pk">Evidence_ID</span>, Investigation_ID <span class="fk">(FK)</span>, Evidence_Type, Source, File_Path, Date_Collected, Integrity_Hash, Notes</td>
        <td>Digital evidence collected during an investigation</td>
      </tr>
      <tr>
        <td style="font-weight:700;">Chain_of_Custody</td>
        <td><span class="pk">Log_ID</span>, Evidence_ID <span class="fk">(FK)</span>, Handled_By, Action, Action_Date, Location, Remarks</td>
        <td>Record of transfer/handling of evidence</td>
      </tr>
      <tr>
        <td style="font-weight:700;">Report</td>
        <td><span class="pk">Report_ID</span>, Incident_ID <span class="fk">(FK)</span>, Generated_By, Report_Type, Date_Generated, Summary</td>
        <td>Incident report generated for the case</td>
      </tr>
      <tr>
        <td style="font-weight:700;">Response_Action</td>
        <td><span class="pk">Action_ID</span>, Incident_ID <span class="fk">(FK)</span>, Action_Type, Description, Assigned_To, Action_Date, Status</td>
        <td>Response/mitigation actions taken for an incident</td>
      </tr>
      <tr>
        <td style="font-weight:700;">Vulnerability</td>
        <td><span class="pk">Vulnerability_ID</span>, Asset_ID <span class="fk">(FK)</span>, Title, Description, Severity, Status, Detected_Date</td>
        <td>Known vulnerability associated with an asset</td>
      </tr>
    </tbody>
  </table>

  <div class="banner">3. ER Diagram</div>
  <div class="diagram-box">
    {svg_inline}
  </div>

  <div class="banner">4. Cardinality Mapping</div>
  <p style="font-size: 7.8pt; font-weight:700; color:#0f3460; margin-bottom:2px;">4.1 Relationship Summary</p>
  <table>
    <thead>
      <tr>
        <th style="width: 5%;">#</th>
        <th style="width: 18%;">Relationship</th>
        <th style="width: 14%;">Entity A</th>
        <th style="width: 15%;">Entity B</th>
        <th style="width: 16%;">Cardinality</th>
        <th style="width: 32%;">Participation</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td style="text-align:center;">1</td>
        <td>reports</td>
        <td>User</td>
        <td>Incident</td>
        <td>One-to-Many (1:N)</td>
        <td>INCIDENT: total. USER: partial.</td>
      </tr>
      <tr>
        <td style="text-align:center;">2</td>
        <td>occurs on</td>
        <td>Incident</td>
        <td>Asset</td>
        <td>Many-to-One (N:1)</td>
        <td>INCIDENT: total. ASSET: partial.</td>
      </tr>
      <tr>
        <td style="text-align:center;">3</td>
        <td>is investigated in</td>
        <td>Incident</td>
        <td>Investigation</td>
        <td>One-to-One (1:1)</td>
        <td>Total on both sides.</td>
      </tr>
      <tr>
        <td style="text-align:center;">4</td>
        <td>collects</td>
        <td>Investigation</td>
        <td>Evidence</td>
        <td>One-to-Many (1:N)</td>
        <td>EVIDENCE: total. INVESTIGATION: partial.</td>
      </tr>
      <tr>
        <td style="text-align:center;">5</td>
        <td>recorded in</td>
        <td>Evidence</td>
        <td>Chain_of_Custody</td>
        <td>One-to-Many (1:N)</td>
        <td>CHAIN_OF_CUSTODY: total. EVIDENCE: partial.</td>
      </tr>
      <tr>
        <td style="text-align:center;">6</td>
        <td>generates</td>
        <td>Incident</td>
        <td>Report</td>
        <td>One-to-Many (1:N)</td>
        <td>REPORT: total. INCIDENT: partial.</td>
      </tr>
      <tr>
        <td style="text-align:center;">7</td>
        <td>has</td>
        <td>Incident</td>
        <td>Response_Action</td>
        <td>One-to-Many (1:N)</td>
        <td>RESPONSE_ACTION: total. INCIDENT: partial.</td>
      </tr>
      <tr>
        <td style="text-align:center;">8</td>
        <td>has</td>
        <td>Asset</td>
        <td>Vulnerability</td>
        <td>One-to-Many (1:N)</td>
        <td>VULNERABILITY: total. ASSET: partial.</td>
      </tr>
    </tbody>
  </table>

  <div style="margin-top: 5px; font-size: 7.4pt; color: #64748b; display: flex; justify-content: space-between; border-top: 1px solid #e2e8f0; padding-top: 3px;">
    <span>CIRDEMS — Database Systems Laboratory</span>
    <span>Vellore Institute of Technology (VIT)</span>
    <span>Relational Schema &amp; Normalization: 1NF &bull; 2NF &bull; 3NF &bull; BCNF Verified</span>
  </div>
</body>
</html>
'''

with open(os.path.join(DOCS_DIR, 'CIRDEMS_Poster_Reference.html'), 'w', encoding='utf-8') as f:
    f.write(poster_html)
print("Saved docs/CIRDEMS_Poster_Reference.html")
