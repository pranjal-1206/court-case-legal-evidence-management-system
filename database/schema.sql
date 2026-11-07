
CREATE DATABASE IF NOT EXISTS court_legal_management;

USE court_legal_management;

-- 1. COURTS
CREATE TABLE courts (
    court_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    court_name VARCHAR(150) NOT NULL,
    location VARCHAR(150),
    court_type VARCHAR(100),
    address TEXT,
    contact_info VARCHAR(150)
) ENGINE=InnoDB;

-- 2. PARTIES
CREATE TABLE parties (
    party_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    party_type VARCHAR(50) NOT NULL,
    contact_details VARCHAR(150),
    address TEXT,
    organization_name VARCHAR(150),
    is_active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- 3. LAWYERS
CREATE TABLE lawyers (
    lawyer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    registration_number VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(150) NOT NULL,
    specialization VARCHAR(150),
    contact_info VARCHAR(150),
    address TEXT,
    is_active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- 4. JUDGES
CREATE TABLE judges (
    judge_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    specialization VARCHAR(150),
    contact_info VARCHAR(150),
    court_id INT UNSIGNED NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (court_id)
        REFERENCES courts(court_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 5. SYSTEM USERS
CREATE TABLE system_users (
    user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    user_role VARCHAR(50) NOT NULL,
    organization VARCHAR(150),
    is_active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- 6. LEGAL CASES
CREATE TABLE legal_cases (
    case_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_number VARCHAR(50) NOT NULL UNIQUE,
    case_type VARCHAR(100) NOT NULL,
    filing_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    priority VARCHAR(30) DEFAULT 'Normal',
    description TEXT,
    court_id INT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (court_id)
        REFERENCES courts(court_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    INDEX idx_case_status (status),
    INDEX idx_case_filing_date (filing_date)
) ENGINE=InnoDB;

-- 7. CASE PARTIES
CREATE TABLE case_parties (
    case_party_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_id INT UNSIGNED NOT NULL,
    party_id INT UNSIGNED NOT NULL,
    party_role VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,

    UNIQUE KEY uq_case_party_role
        (case_id, party_id, party_role),

    CHECK (end_date IS NULL OR end_date > start_date),

    FOREIGN KEY (case_id)
        REFERENCES legal_cases(case_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (party_id)
        REFERENCES parties(party_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 8. CASE LAWYERS
CREATE TABLE case_lawyers (
    case_lawyer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_id INT UNSIGNED NOT NULL,
    lawyer_id INT UNSIGNED NOT NULL,
    representation_type VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,

    UNIQUE KEY uq_case_lawyer_role
        (case_id, lawyer_id, representation_type),

    CHECK (end_date IS NULL OR end_date > start_date),

    FOREIGN KEY (case_id)
        REFERENCES legal_cases(case_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (lawyer_id)
        REFERENCES lawyers(lawyer_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 9. CASE JUDGES
CREATE TABLE case_judges (
    case_judge_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_id INT UNSIGNED NOT NULL,
    judge_id INT UNSIGNED NOT NULL,
    assignment_date DATE NOT NULL,
    end_date DATE,
    assignment_role VARCHAR(100) NOT NULL,

    UNIQUE KEY uq_case_judge_role
        (case_id, judge_id, assignment_role),

    CHECK (end_date IS NULL OR end_date > assignment_date),

    FOREIGN KEY (case_id)
        REFERENCES legal_cases(case_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (judge_id)
        REFERENCES judges(judge_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 10. WITNESSES
CREATE TABLE witnesses (
    witness_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    contact_info VARCHAR(150),
    address TEXT,
    statement_date DATE,
    statement_reference VARCHAR(255),
    is_expert BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- 11. EVIDENCE
CREATE TABLE evidence (
    evidence_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_id INT UNSIGNED NOT NULL,
    submitted_by_user_id INT UNSIGNED NOT NULL,
    evidence_type VARCHAR(100) NOT NULL,
    description TEXT,
    submission_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL,
    storage_location VARCHAR(500),
    integrity_hash CHAR(64),
    is_sensitive BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (case_id)
        REFERENCES legal_cases(case_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (submitted_by_user_id)
        REFERENCES system_users(user_id)
        ON DELETE RESTRICT,

    INDEX idx_evidence_case (case_id)
) ENGINE=InnoDB;

-- 12. DOCUMENTS
CREATE TABLE documents (
    document_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_id INT UNSIGNED NOT NULL,
    uploaded_by_user_id INT UNSIGNED NOT NULL,
    document_type VARCHAR(100) NOT NULL,
    title VARCHAR(255) NOT NULL,
    uploaded_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    file_reference VARCHAR(500),
    version INT UNSIGNED DEFAULT 1,
    status VARCHAR(50) NOT NULL,

    FOREIGN KEY (case_id)
        REFERENCES legal_cases(case_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (uploaded_by_user_id)
        REFERENCES system_users(user_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 13. DEADLINES
CREATE TABLE deadlines (
    deadline_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_id INT UNSIGNED NOT NULL,
    deadline_type VARCHAR(100) NOT NULL,
    due_date DATETIME NOT NULL,
    responsible_user_id INT UNSIGNED NOT NULL,
    status VARCHAR(50) NOT NULL,
    description TEXT,

    FOREIGN KEY (case_id)
        REFERENCES legal_cases(case_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (responsible_user_id)
        REFERENCES system_users(user_id)
        ON DELETE RESTRICT,

    INDEX idx_deadline_due_date (due_date)
) ENGINE=InnoDB;

-- 14. HEARINGS
CREATE TABLE hearings (
    hearing_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_id INT UNSIGNED NOT NULL,
    judge_id INT UNSIGNED NOT NULL,
    hearing_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    hearing_type VARCHAR(100),
    purpose TEXT,
    outcome TEXT,
    status VARCHAR(50) NOT NULL,
    courtroom VARCHAR(100),
    next_hearing_date DATE,
    notes TEXT,

    CHECK (end_time > start_time),

    FOREIGN KEY (case_id)
        REFERENCES legal_cases(case_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (judge_id)
        REFERENCES judges(judge_id)
        ON DELETE RESTRICT,

    INDEX idx_hearing_date (hearing_date)
) ENGINE=InnoDB;

-- 15. JUDGMENTS
CREATE TABLE judgments (
    judgment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_id INT UNSIGNED NOT NULL,
    document_id INT UNSIGNED,
    judgment_type VARCHAR(100),
    judgment_date DATE NOT NULL,
    decision TEXT,
    penalties TEXT,
    status VARCHAR(50) NOT NULL,
    notes TEXT,

    FOREIGN KEY (case_id)
        REFERENCES legal_cases(case_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (document_id)
        REFERENCES documents(document_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 16. CASE WITNESSES
CREATE TABLE case_witnesses (
    case_witness_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    case_id INT UNSIGNED NOT NULL,
    witness_id INT UNSIGNED NOT NULL,
    witness_role VARCHAR(100) NOT NULL,
    statement_date DATE,
    status VARCHAR(50) NOT NULL,
    notes TEXT,

    UNIQUE KEY uq_case_witness
        (case_id, witness_id, witness_role),

    FOREIGN KEY (case_id)
        REFERENCES legal_cases(case_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (witness_id)
        REFERENCES witnesses(witness_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 17. EVIDENCE WITNESSES
CREATE TABLE evidence_witnesses (
    evidence_witness_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    evidence_id INT UNSIGNED NOT NULL,
    witness_id INT UNSIGNED NOT NULL,
    relationship_type VARCHAR(100) NOT NULL,
    notes TEXT,

    UNIQUE KEY uq_evidence_witness
        (evidence_id, witness_id, relationship_type),

    FOREIGN KEY (evidence_id)
        REFERENCES evidence(evidence_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (witness_id)
        REFERENCES witnesses(witness_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 18. CHAIN OF CUSTODY
CREATE TABLE chain_of_custody (
    custody_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    evidence_id INT UNSIGNED NOT NULL,
    from_user_id INT UNSIGNED NOT NULL,
    to_user_id INT UNSIGNED NOT NULL,
    transfer_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    transfer_reason VARCHAR(255),
    location VARCHAR(255),
    remarks TEXT,

    FOREIGN KEY (evidence_id)
        REFERENCES evidence(evidence_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (from_user_id)
        REFERENCES system_users(user_id)
        ON DELETE RESTRICT,

    FOREIGN KEY (to_user_id)
        REFERENCES system_users(user_id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

