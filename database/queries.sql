
USE court_legal_management;

-- ==========================================
-- PHASE 5: SQL QUERIES
-- ==========================================


-- QUERY 1: Display all registered legal cases

SELECT *
FROM legal_cases;


-- QUERY 2: Display cases that are currently ongoing

SELECT
    case_id,
    case_number,
    case_type,
    filing_date,
    status
FROM legal_cases
WHERE status = 'Ongoing';


-- QUERY 3: Display high-priority cases

SELECT
    case_number,
    case_type,
    priority,
    status
FROM legal_cases
WHERE priority = 'High';


-- QUERY 4: Display cases in descending order of filing date

SELECT
    case_number,
    case_type,
    filing_date,
    status
FROM legal_cases
ORDER BY filing_date DESC;


-- QUERY 5: Display cases along with their respective courts

SELECT
    lc.case_number,
    lc.case_type,
    lc.status,
    c.court_name,
    c.location
FROM legal_cases lc
INNER JOIN courts c
    ON lc.court_id = c.court_id;

-- ==========================================
-- QUERIES 6 TO 10
-- ==========================================


-- QUERY 6: Display cases with their associated parties

SELECT
    lc.case_number,
    p.name AS party_name,
    p.party_type,
    cp.party_role
FROM legal_cases lc
INNER JOIN case_parties cp
    ON lc.case_id = cp.case_id
INNER JOIN parties p
    ON cp.party_id = p.party_id
ORDER BY lc.case_number;


-- QUERY 7: Display cases and their assigned lawyers

SELECT
    lc.case_number,
    l.name AS lawyer_name,
    l.specialization,
    cl.representation_type
FROM legal_cases lc
INNER JOIN case_lawyers cl
    ON lc.case_id = cl.case_id
INNER JOIN lawyers l
    ON cl.lawyer_id = l.lawyer_id
ORDER BY lc.case_number;


-- QUERY 8: Display cases and their assigned judges

SELECT
    lc.case_number,
    j.name AS judge_name,
    c.court_name,
    cj.assignment_role
FROM legal_cases lc
INNER JOIN case_judges cj
    ON lc.case_id = cj.case_id
INNER JOIN judges j
    ON cj.judge_id = j.judge_id
INNER JOIN courts c
    ON j.court_id = c.court_id
ORDER BY lc.case_number;


-- QUERY 9: Count the total number of registered cases

SELECT
    COUNT(*) AS total_cases
FROM legal_cases;


-- QUERY 10: Count cases according to their status

SELECT
    status,
    COUNT(*) AS total_cases
FROM legal_cases
GROUP BY status
ORDER BY total_cases DESC;

-- ==========================================
-- QUERIES 11 TO 15
-- ==========================================


-- QUERY 11: Count cases registered in each court

SELECT
    c.court_name,
    COUNT(lc.case_id) AS total_cases
FROM courts c
LEFT JOIN legal_cases lc
    ON c.court_id = lc.court_id
GROUP BY c.court_id, c.court_name
ORDER BY total_cases DESC;


-- QUERY 12: Find lawyers handling more than one case

SELECT
    l.lawyer_id,
    l.name AS lawyer_name,
    COUNT(DISTINCT cl.case_id) AS cases_handled
FROM lawyers l
INNER JOIN case_lawyers cl
    ON l.lawyer_id = cl.lawyer_id
GROUP BY l.lawyer_id, l.name
HAVING COUNT(DISTINCT cl.case_id) > 1;


-- QUERY 13: Display total evidence submitted for each case

SELECT
    lc.case_number,
    COUNT(e.evidence_id) AS total_evidence
FROM legal_cases lc
LEFT JOIN evidence e
    ON lc.case_id = e.case_id
GROUP BY lc.case_id, lc.case_number
ORDER BY total_evidence DESC;


-- QUERY 14: Display evidence details and the submitting user

SELECT
    e.evidence_id,
    lc.case_number,
    e.evidence_type,
    e.description,
    e.submission_date,
    e.status,
    su.full_name AS submitted_by
FROM evidence e
INNER JOIN legal_cases lc
    ON e.case_id = lc.case_id
INNER JOIN system_users su
    ON e.submitted_by_user_id = su.user_id;


-- QUERY 15: Display pending deadlines with responsible persons

SELECT
    lc.case_number,
    d.deadline_type,
    d.due_date,
    d.status,
    su.full_name AS responsible_person
FROM deadlines d
INNER JOIN legal_cases lc
    ON d.case_id = lc.case_id
INNER JOIN system_users su
    ON d.responsible_user_id = su.user_id
WHERE d.status = 'Pending'
ORDER BY d.due_date ASC;


-- ==========================================
-- QUERIES 16 TO 20
-- ADVANCED SQL OPERATIONS
-- ==========================================


-- QUERY 16: Find cases that have no judgment recorded
-- Concept: NOT EXISTS and correlated subquery

SELECT
    lc.case_id,
    lc.case_number,
    lc.case_type,
    lc.status
FROM legal_cases lc
WHERE NOT EXISTS (
    SELECT 1
    FROM judgments j
    WHERE j.case_id = lc.case_id
);


-- QUERY 17: Find cases having more than one evidence record
-- Concept: GROUP BY and HAVING

SELECT
    lc.case_number,
    COUNT(e.evidence_id) AS evidence_count
FROM legal_cases lc
INNER JOIN evidence e
    ON lc.case_id = e.case_id
GROUP BY lc.case_id, lc.case_number
HAVING COUNT(e.evidence_id) > 1;


-- QUERY 18: Find cases having at least one expert witness
-- Concept: EXISTS and correlated subquery

SELECT
    lc.case_number,
    lc.case_type,
    lc.status
FROM legal_cases lc
WHERE EXISTS (
    SELECT 1
    FROM case_witnesses cw
    INNER JOIN witnesses w
        ON cw.witness_id = w.witness_id
    WHERE cw.case_id = lc.case_id
      AND w.is_expert = TRUE
);


-- QUERY 19: Display complete chain of custody for evidence
-- Concept: Multiple INNER JOINs

SELECT
    e.evidence_id,
    lc.case_number,
    e.evidence_type,
    co.transfer_date,
    su1.full_name AS transferred_from,
    su2.full_name AS transferred_to,
    co.location,
    co.transfer_reason
FROM chain_of_custody co
INNER JOIN evidence e
    ON co.evidence_id = e.evidence_id
INNER JOIN legal_cases lc
    ON e.case_id = lc.case_id
INNER JOIN system_users su1
    ON co.from_user_id = su1.user_id
INNER JOIN system_users su2
    ON co.to_user_id = su2.user_id
ORDER BY co.transfer_date DESC;


-- QUERY 20: Display cases with their total number of hearings
-- Concept: LEFT JOIN, COUNT and GROUP BY

SELECT
    lc.case_number,
    lc.case_type,
    lc.status,
    COUNT(h.hearing_id) AS total_hearings
FROM legal_cases lc
LEFT JOIN hearings h
    ON lc.case_id = h.case_id
GROUP BY
    lc.case_id,
    lc.case_number,
    lc.case_type,
    lc.status
ORDER BY total_hearings DESC;
