
USE court_legal_management;

-- ==========================================
-- PHASE 6C: TRIGGERS
-- ==========================================

-- Audit table to maintain evidence activity history

CREATE TABLE IF NOT EXISTS evidence_audit_log (
    audit_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    evidence_id INT UNSIGNED NOT NULL,
    action_type VARCHAR(30) NOT NULL,
    action_description TEXT,
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    performed_by INT UNSIGNED NULL
) ENGINE=InnoDB;


DELIMITER //

-- TRIGGER 1:
-- Automatically update legal case timestamp

CREATE TRIGGER before_case_update
BEFORE UPDATE ON legal_cases
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END //


-- TRIGGER 2:
-- Record when new evidence is submitted

CREATE TRIGGER after_evidence_insert
AFTER INSERT ON evidence
FOR EACH ROW
BEGIN
    INSERT INTO evidence_audit_log (
        evidence_id,
        action_type,
        action_description,
        performed_by
    )
    VALUES (
        NEW.evidence_id,
        'INSERT',
        'New evidence submitted to the system',
        NEW.submitted_by_user_id
    );
END //


-- TRIGGER 3:
-- Record when evidence details are updated

CREATE TRIGGER after_evidence_update
AFTER UPDATE ON evidence
FOR EACH ROW
BEGIN
    INSERT INTO evidence_audit_log (
        evidence_id,
        action_type,
        action_description,
        performed_by
    )
    VALUES (
        NEW.evidence_id,
        'UPDATE',
        'Evidence record updated',
        NEW.submitted_by_user_id
    );
END //


-- TRIGGER 4:
-- Record when evidence is transferred through chain of custody

CREATE TRIGGER after_custody_insert
AFTER INSERT ON chain_of_custody
FOR EACH ROW
BEGIN
    INSERT INTO evidence_audit_log (
        evidence_id,
        action_type,
        action_description,
        performed_by
    )
    VALUES (
        NEW.evidence_id,
        'TRANSFER',
        CONCAT(
            'Evidence transferred from user ',
            NEW.from_user_id,
            ' to user ',
            NEW.to_user_id,
            '. Reason: ',
            NEW.transfer_reason
        ),
        NEW.to_user_id
    );
END //

DELIMITER ;
