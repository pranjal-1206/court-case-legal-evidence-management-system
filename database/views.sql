
USE court_legal_management;

-- ==========================================
-- PHASE 6A: DATABASE VIEWS
-- ==========================================


-- VIEW 1: Complete case details with court information

CREATE OR REPLACE VIEW case_details_view AS
SELECT
    lc.case_id,
    lc.case_number,
    lc.case_type,
    lc.filing_date,
    lc.status,
    lc.priority,
    lc.description,
    c.court_name,
    c.location AS court_location
FROM legal_cases lc
INNER JOIN courts c
    ON lc.court_id = c.court_id;


-- VIEW 2: Case details with associated lawyers

CREATE OR REPLACE VIEW case_lawyers_view AS
SELECT
    lc.case_id,
    lc.case_number,
    l.lawyer_id,
    l.name AS lawyer_name,
    l.specialization,
    cl.representation_type
FROM legal_cases lc
INNER JOIN case_lawyers cl
    ON lc.case_id = cl.case_id
INNER JOIN lawyers l
    ON cl.lawyer_id = l.lawyer_id;


-- VIEW 3: Case details with assigned judges

CREATE OR REPLACE VIEW case_judges_view AS
SELECT
    lc.case_number,
    j.judge_id,
    j.name AS judge_name,
    c.court_name,
    cj.assignment_date,
    cj.assignment_role
FROM legal_cases lc
INNER JOIN case_judges cj
    ON lc.case_id = cj.case_id
INNER JOIN judges j
    ON cj.judge_id = j.judge_id
INNER JOIN courts c
    ON j.court_id = c.court_id;


-- VIEW 4: Evidence details with submitting user

CREATE OR REPLACE VIEW evidence_details_view AS
SELECT
    e.evidence_id,
    e.case_id,
    lc.case_number,
    e.evidence_type,
    e.description,
    e.submission_date,
    e.status AS evidence_status,
    e.storage_location,
    su.full_name AS submitted_by
FROM evidence e
INNER JOIN legal_cases lc
    ON e.case_id = lc.case_id
INNER JOIN system_users su
    ON e.submitted_by_user_id = su.user_id;


-- VIEW 5: Case hearing summary

CREATE OR REPLACE VIEW hearing_summary_view AS
SELECT
    h.hearing_id,
    lc.case_number,
    h.hearing_date,
    h.start_time,
    h.end_time,
    h.hearing_type,
    h.purpose,
    h.outcome,
    h.status AS hearing_status,
    j.name AS judge_name,
    h.courtroom
FROM hearings h
INNER JOIN legal_cases lc
    ON h.case_id = lc.case_id
INNER JOIN judges j
    ON h.judge_id = j.judge_id;
