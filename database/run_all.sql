-- ============================================================================
-- CYBER INCIDENT RESPONSE & DIGITAL EVIDENCE MANAGEMENT SYSTEM (CIRDEMS)
-- MASTER EXECUTION SCRIPT FOR ORACLE DATABASE 21c XE
-- Run this script in SQL*Plus or Oracle SQL Developer: @run_all.sql
-- ============================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED;
SET LINESIZE 200;
SET PAGESIZE 100;
SET FEEDBACK ON;
SET ECHO OFF;

PROMPT ============================================================================;
PROMPT       STARTING CIRDEMS COMPLETE DATABASE INITIALIZATION & VERIFICATION       ;
PROMPT ============================================================================;

PROMPT;
PROMPT >>> STEP 1: Executing 01_schema_ddl.sql (Tables & Constraints)...;
@01_schema_ddl.sql;

PROMPT;
PROMPT >>> STEP 2: Executing 02_data_seed.sql (Populating 10+ Records per Table)...;
@02_data_seed.sql;

PROMPT;
PROMPT >>> STEP 3: Executing 04_plsql_components.sql (Procedures, Functions, Cursor, Triggers)...;
@04_plsql_components.sql;

PROMPT;
PROMPT >>> STEP 4: Executing 06_er_diagram_alignment.sql (ER entities and relationships)...;
@06_er_diagram_alignment.sql;

PROMPT;
PROMPT >>> STEP 5: Executing 03_advanced_queries.sql (15 Analytical Queries)...;
@03_advanced_queries.sql;

PROMPT;
PROMPT >>> STEP 6: Executing 05_dml_demo.sql (DML & Transaction Demonstrations)...;
@05_dml_demo.sql;

PROMPT;
PROMPT ============================================================================;
PROMPT       CIRDEMS COMPLETE DATABASE SETUP & VERIFICATION COMPLETED!             ;
PROMPT ============================================================================;
