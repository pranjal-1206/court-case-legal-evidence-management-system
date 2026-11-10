
USE court_legal_management;

DELIMITER //

-- ==========================================
-- PHASE 6B: STORED PROCEDURES
-- ==========================================


-- PROCEDURE 1:
-- Search for a case using its case number

CREATE PROCEDURE GetCaseByNumber(
    IN p_case_number VARCHAR(50)
)
BEGIN
    SELECT *
    FROM case_details_view
    WHERE case_number = p_case_number;
END //


-- PROCEDURE 2:
-- Retrieve all cases assigned to a particular lawyer

CREATE PROCEDURE GetCasesByLawyer(
    IN p_lawyer_id INT UNSIGNED
)
BEGIN
    SELECT *
    FROM case_lawyers_view
    WHERE lawyer_id = p_lawyer_id;
END //


-- PROCEDURE 3:
-- Retrieve hearings assigned to a particular judge

CREATE PROCEDURE GetHearingsByJudge(
    IN p_judge_id INT UNSIGNED
)
BEGIN
    SELECT
        h.hearing_id,
        lc.case_number,
        h.hearing_date,
        h.start_time,
        h.end_time,
        h.hearing_type,
        h.status,
        h.courtroom
    FROM hearings h
    INNER JOIN legal_cases lc
        ON h.case_id = lc.case_id
    WHERE h.judge_id = p_judge_id
    ORDER BY h.hearing_date;
END //


-- PROCEDURE 4:
-- Count the total evidence records for a case

CREATE PROCEDURE GetEvidenceCount(
    IN p_case_id INT UNSIGNED,
    OUT p_total_evidence INT
)
BEGIN
    SELECT COUNT(*)
    INTO p_total_evidence
    FROM evidence
    WHERE case_id = p_case_id;
END //


-- PROCEDURE 5:
-- Register a new legal case

CREATE PROCEDURE RegisterNewCase(
    IN p_case_number VARCHAR(50),
    IN p_case_type VARCHAR(100),
    IN p_filing_date DATE,
    IN p_status VARCHAR(50),
    IN p_priority VARCHAR(50),
    IN p_description TEXT,
    IN p_court_id INT UNSIGNED
)
BEGIN
    INSERT INTO legal_cases (
        case_number,
        case_type,
        filing_date,
        status,
        priority,
        description,
        court_id
    )
    VALUES (
        p_case_number,
        p_case_type,
        p_filing_date,
        p_status,
        p_priority,
        p_description,
        p_court_id
    );
END //

DELIMITER ;
