
USE court_legal_management;


-- ==========================================
-- PHASE 6D: DATABASE TRANSACTIONS
-- ==========================================


-- TRANSACTION 1:
-- Register a case and associate a party
-- Both operations succeed or both are cancelled.

START TRANSACTION;

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
    'TXN-TEST-001',
    'Civil',
    CURRENT_DATE,
    'Pending',
    'Medium',
    'Transaction demonstration case',
    1
);

SET @new_case_id = LAST_INSERT_ID();

INSERT INTO case_parties (
    case_id,
    party_id,
    party_role,
    start_date
)
VALUES (
    @new_case_id,
    1,
    'Plaintiff',
    CURRENT_DATE
);

COMMIT;


-- TRANSACTION 2:
-- Demonstrate ROLLBACK
-- The temporary change will not be saved.

START TRANSACTION;

UPDATE legal_cases
SET priority = 'High'
WHERE case_id = 1;

ROLLBACK;


-- TRANSACTION 3:
-- Demonstrate SAVEPOINT
-- Only changes after the savepoint are cancelled.

START TRANSACTION;

UPDATE legal_cases
SET priority = 'High'
WHERE case_id = 2;

SAVEPOINT after_first_update;

UPDATE legal_cases
SET status = 'Closed'
WHERE case_id = 3;

ROLLBACK TO SAVEPOINT after_first_update;

COMMIT;


-- TRANSACTION 4:
-- Demonstrate a transaction for evidence submission.

START TRANSACTION;

INSERT INTO evidence (
    case_id,
    submitted_by_user_id,
    evidence_type,
    description,
    submission_date,
    status,
    storage_location,
    integrity_hash,
    is_sensitive
)
VALUES (
    1,
    1,
    'Document',
    'Transaction demonstration evidence',
    CURRENT_DATE,
    'Submitted',
    'Secure Storage',
    REPEAT('c', 64),
    FALSE
);

SET @new_evidence_id = LAST_INSERT_ID();

INSERT INTO chain_of_custody (
    evidence_id,
    from_user_id,
    to_user_id,
    transfer_date,
    transfer_reason,
    location,
    remarks
)
VALUES (
    @new_evidence_id,
    1,
    2,
    CURRENT_TIMESTAMP,
    'Initial evidence handover',
    'Evidence Storage Room',
    'Initial transfer recorded'
);

COMMIT;


-- ==========================================
-- END OF TRANSACTIONS
-- ==========================================
