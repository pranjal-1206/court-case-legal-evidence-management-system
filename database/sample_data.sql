
USE court_legal_management;

-- =============================================
-- SAMPLE DATA
-- Court Case and Legal Evidence Management System
-- All names and case details are fictional.
-- =============================================

-- 1. COURTS
INSERT INTO courts
(court_id, court_name, location, court_type, address, contact_info)
VALUES
(1, 'District Court Ludhiana', 'Ludhiana', 'District Court', 'Court Complex, Ludhiana, Punjab', '0161-2400001'),
(2, 'District Court Chandigarh', 'Chandigarh', 'District Court', 'Sector 43, Chandigarh', '0172-2600002'),
(3, 'Punjab and Haryana High Court', 'Chandigarh', 'High Court', 'Sector 1, Chandigarh', '0172-2740003');

-- 2. PARTIES
INSERT INTO parties
(party_id, name, party_type, contact_details, address, organization_name, is_active)
VALUES
(1, 'Aarav Sharma', 'Individual', '9876500001', 'Model Town, Ludhiana', NULL, TRUE),
(2, 'Meera Kapoor', 'Individual', '9876500002', 'Civil Lines, Ludhiana', NULL, TRUE),
(3, 'Rajiv Malhotra', 'Individual', '9876500003', 'Sector 22, Chandigarh', NULL, TRUE),
(4, 'Simran Kaur', 'Individual', '9876500004', 'Sarabha Nagar, Ludhiana', NULL, TRUE),
(5, 'Northstar Technologies Pvt Ltd', 'Organization', '0161-4001000', 'Focal Point, Ludhiana', 'Northstar Technologies Pvt Ltd', TRUE),
(6, 'Greenfield Developers', 'Organization', '0172-4002000', 'Sector 17, Chandigarh', 'Greenfield Developers', TRUE),
(7, 'Vikram Singh', 'Individual', '9876500007', 'Haibowal, Ludhiana', NULL, TRUE),
(8, 'Ananya Verma', 'Individual', '9876500008', 'Sector 35, Chandigarh', NULL, TRUE),
(9, 'Punjab Traders Association', 'Organization', '0161-4003000', 'Industrial Area, Ludhiana', 'Punjab Traders Association', TRUE),
(10, 'Rohan Mehta', 'Individual', '9876500010', 'Sector 8, Chandigarh', NULL, TRUE);

-- 3. LAWYERS
INSERT INTO lawyers
(lawyer_id, registration_number, name, specialization, contact_info, address, is_active)
VALUES
(1, 'PUN-LAW-001', 'Advocate Karan Bedi', 'Criminal Law', '9876510001', 'Ludhiana, Punjab', TRUE),
(2, 'PUN-LAW-002', 'Advocate Neha Sethi', 'Civil Law', '9876510002', 'Chandigarh', TRUE),
(3, 'PUN-LAW-003', 'Advocate Arjun Gill', 'Corporate Law', '9876510003', 'Ludhiana, Punjab', TRUE),
(4, 'PUN-LAW-004', 'Advocate Ritu Khanna', 'Property Law', '9876510004', 'Chandigarh', TRUE),
(5, 'PUN-LAW-005', 'Advocate Manav Arora', 'Criminal Law', '9876510005', 'Ludhiana, Punjab', TRUE),
(6, 'PUN-LAW-006', 'Advocate Pooja Nair', 'Family Law', '9876510006', 'Chandigarh', TRUE),
(7, 'PUN-LAW-007', 'Advocate Harpreet Brar', 'Commercial Law', '9876510007', 'Ludhiana, Punjab', TRUE),
(8, 'PUN-LAW-008', 'Advocate Tanya Mehta', 'Constitutional Law', '9876510008', 'Chandigarh', TRUE);

-- 4. SYSTEM USERS
-- These are demonstration-only password placeholders,
-- NOT usable authentication password hashes.
INSERT INTO system_users
(user_id, username, password_hash, full_name, email, user_role, organization, is_active)
VALUES
(1, 'court_admin', 'DEMO_HASH_REPLACE_BEFORE_AUTH', 'Court Administrator', 'admin@example.test', 'Admin', 'District Court Ludhiana', TRUE),
(2, 'evidence_officer', 'DEMO_HASH_REPLACE_BEFORE_AUTH', 'Evidence Officer', 'evidence@example.test', 'Evidence Officer', 'District Court Ludhiana', TRUE),
(3, 'case_clerk', 'DEMO_HASH_REPLACE_BEFORE_AUTH', 'Case Clerk', 'clerk@example.test', 'Clerk', 'District Court Chandigarh', TRUE),
(4, 'records_manager', 'DEMO_HASH_REPLACE_BEFORE_AUTH', 'Records Manager', 'records@example.test', 'Records Manager', 'Punjab and Haryana High Court', TRUE);

-- 5. WITNESSES
INSERT INTO witnesses
(witness_id, name, contact_info, address, statement_date, statement_reference, is_expert, is_active)
VALUES
(1, 'Dev Sharma', '9876520001', 'Ludhiana, Punjab', '2025-01-15', 'STMT-001', FALSE, TRUE),
(2, 'Nisha Arora', '9876520002', 'Chandigarh', '2025-02-10', 'STMT-002', FALSE, TRUE),
(3, 'Dr. Amit Sood', '9876520003', 'Ludhiana, Punjab', '2025-03-05', 'STMT-003', TRUE, TRUE),
(4, 'Rakesh Kumar', '9876520004', 'Chandigarh', '2025-04-12', 'STMT-004', FALSE, TRUE),
(5, 'Dr. Simran Oberoi', '9876520005', 'Chandigarh', '2025-05-18', 'STMT-005', TRUE, TRUE),
(6, 'Manoj Verma', '9876520006', 'Ludhiana, Punjab', '2025-06-20', 'STMT-006', FALSE, TRUE),
(7, 'Kavita Joshi', '9876520007', 'Chandigarh', '2025-07-08', 'STMT-007', FALSE, TRUE),
(8, 'Dr. Rahul Mehra', '9876520008', 'Chandigarh', '2025-08-14', 'STMT-008', TRUE, TRUE);

-- 6. JUDGES
INSERT INTO judges
(judge_id, name, specialization, contact_info, court_id, is_active)
VALUES
(1, 'Justice A. Sharma', 'Criminal Law', '0172-3000001', 1, TRUE),
(2, 'Justice P. Mehta', 'Civil Law', '0172-3000002', 1, TRUE),
(3, 'Justice R. Khanna', 'Corporate Law', '0172-3000003', 2, TRUE),
(4, 'Justice S. Gill', 'Property Law', '0172-3000004', 2, TRUE),
(5, 'Justice N. Kapoor', 'Constitutional Law', '0172-3000005', 3, TRUE);

-- 7. LEGAL CASES
INSERT INTO legal_cases
(case_id, case_number, case_type, filing_date, status, priority, description, court_id)
VALUES
(1, 'LDH-2025-001', 'Criminal', '2025-01-10', 'Under Investigation', 'High', 'Fictional criminal matter involving disputed financial records.', 1),
(2, 'LDH-2025-002', 'Civil', '2025-02-05', 'Ongoing', 'Normal', 'Fictional dispute concerning a commercial agreement.', 1),
(3, 'CHD-2025-003', 'Corporate', '2025-03-12', 'Ongoing', 'High', 'Fictional corporate contract dispute.', 2),
(4, 'CHD-2025-004', 'Property', '2025-04-18', 'Pending Judgment', 'Normal', 'Fictional property ownership dispute.', 2),
(5, 'LDH-2025-005', 'Criminal', '2025-05-20', 'Closed', 'High', 'Fictional matter involving digital evidence.', 1),
(6, 'CHD-2025-006', 'Family', '2025-06-11', 'Ongoing', 'Normal', 'Fictional family settlement matter.', 2),
(7, 'LDH-2025-007', 'Commercial', '2025-07-09', 'Ongoing', 'High', 'Fictional commercial payment dispute.', 1),
(8, 'CHD-2025-008', 'Civil', '2025-08-14', 'Pending Judgment', 'Normal', 'Fictional civil compensation claim.', 2),
(9, 'HC-2025-009', 'Constitutional', '2025-09-02', 'Ongoing', 'High', 'Fictional constitutional petition.', 3),
(10, 'HC-2025-010', 'Appeal', '2025-10-15', 'Ongoing', 'Normal', 'Fictional appeal against a lower court order.', 3);

-- 8. CASE PARTIES
INSERT INTO case_parties
(case_party_id, case_id, party_id, party_role, start_date, end_date)
VALUES
(1, 1, 1, 'Plaintiff', '2025-01-10', NULL),
(2, 1, 2, 'Defendant', '2025-01-10', NULL),
(3, 2, 3, 'Plaintiff', '2025-02-05', NULL),
(4, 2, 4, 'Defendant', '2025-02-05', NULL),
(5, 3, 5, 'Plaintiff', '2025-03-12', NULL),
(6, 3, 6, 'Defendant', '2025-03-12', NULL),
(7, 4, 7, 'Plaintiff', '2025-04-18', NULL),
(8, 4, 8, 'Defendant', '2025-04-18', NULL),
(9, 5, 9, 'Plaintiff', '2025-05-20', NULL),
(10, 5, 10, 'Defendant', '2025-05-20', NULL),
(11, 6, 1, 'Applicant', '2025-06-11', NULL),
(12, 6, 4, 'Respondent', '2025-06-11', NULL),
(13, 7, 5, 'Plaintiff', '2025-07-09', NULL),
(14, 7, 7, 'Defendant', '2025-07-09', NULL),
(15, 8, 8, 'Plaintiff', '2025-08-14', NULL),
(16, 8, 6, 'Defendant', '2025-08-14', NULL),
(17, 9, 9, 'Petitioner', '2025-09-02', NULL),
(18, 9, 3, 'Respondent', '2025-09-02', NULL),
(19, 10, 10, 'Appellant', '2025-10-15', NULL),
(20, 10, 2, 'Respondent', '2025-10-15', NULL);

-- 9. CASE LAWYERS
INSERT INTO case_lawyers
(case_lawyer_id, case_id, lawyer_id, representation_type, start_date, end_date)
VALUES
(1, 1, 1, 'Plaintiff Counsel', '2025-01-10', NULL),
(2, 1, 5, 'Defence Counsel', '2025-01-10', NULL),
(3, 2, 2, 'Plaintiff Counsel', '2025-02-05', NULL),
(4, 2, 4, 'Defence Counsel', '2025-02-05', NULL),
(5, 3, 3, 'Plaintiff Counsel', '2025-03-12', NULL),
(6, 3, 7, 'Defence Counsel', '2025-03-12', NULL),
(7, 4, 4, 'Plaintiff Counsel', '2025-04-18', NULL),
(8, 4, 2, 'Defence Counsel', '2025-04-18', NULL),
(9, 5, 5, 'Plaintiff Counsel', '2025-05-20', NULL),
(10, 5, 1, 'Defence Counsel', '2025-05-20', NULL),
(11, 6, 6, 'Applicant Counsel', '2025-06-11', NULL),
(12, 6, 2, 'Respondent Counsel', '2025-06-11', NULL),
(13, 7, 7, 'Plaintiff Counsel', '2025-07-09', NULL),
(14, 7, 3, 'Defence Counsel', '2025-07-09', NULL),
(15, 8, 2, 'Plaintiff Counsel', '2025-08-14', NULL),
(16, 8, 4, 'Defence Counsel', '2025-08-14', NULL),
(17, 9, 8, 'Petitioner Counsel', '2025-09-02', NULL),
(18, 9, 3, 'Respondent Counsel', '2025-09-02', NULL),
(19, 10, 8, 'Appellant Counsel', '2025-10-15', NULL),
(20, 10, 6, 'Respondent Counsel', '2025-10-15', NULL);

-- 10. CASE JUDGES
INSERT INTO case_judges
(case_judge_id, case_id, judge_id, assignment_date, end_date, assignment_role)
VALUES
(1, 1, 1, '2025-01-10', NULL, 'Presiding Judge'),
(2, 2, 2, '2025-02-05', NULL, 'Presiding Judge'),
(3, 3, 3, '2025-03-12', NULL, 'Presiding Judge'),
(4, 4, 4, '2025-04-18', NULL, 'Presiding Judge'),
(5, 5, 1, '2025-05-20', '2025-12-15', 'Presiding Judge'),
(6, 6, 4, '2025-06-11', NULL, 'Presiding Judge'),
(7, 7, 2, '2025-07-09', NULL, 'Presiding Judge'),
(8, 8, 3, '2025-08-14', NULL, 'Presiding Judge'),
(9, 9, 5, '2025-09-02', NULL, 'Presiding Judge'),
(10, 10, 5, '2025-10-15', NULL, 'Presiding Judge');

-- 11. EVIDENCE
INSERT INTO evidence
(evidence_id, case_id, submitted_by_user_id, evidence_type, description, submission_date, status, storage_location, integrity_hash, is_sensitive)
VALUES
(1, 1, 2, 'Digital', 'Fictional transaction log extract.', '2025-01-20 10:30:00', 'Verified', 'Vault/A1/E001', REPEAT('a', 64), TRUE),
(2, 1, 2, 'Document', 'Fictional signed transaction statement.', '2025-01-22 11:00:00', 'Verified', 'Vault/A1/E002', REPEAT('b', 64), TRUE),
(3, 2, 3, 'Document', 'Fictional commercial agreement copy.', '2025-02-15 09:30:00', 'Under Review', 'Vault/B1/E003', REPEAT('c', 64), FALSE),
(4, 3, 2, 'Digital', 'Fictional corporate email records.', '2025-03-20 12:00:00', 'Verified', 'Vault/C1/E004', REPEAT('d', 64), TRUE),
(5, 4, 3, 'Document', 'Fictional property ownership papers.', '2025-04-25 14:00:00', 'Verified', 'Vault/D1/E005', REPEAT('e', 64), FALSE),
(6, 5, 2, 'Digital', 'Fictional device image for demonstration.', '2025-05-25 10:00:00', 'Archived', 'Vault/E1/E006', REPEAT('f', 64), TRUE),
(7, 6, 3, 'Document', 'Fictional settlement proposal.', '2025-06-18 11:30:00', 'Under Review', 'Vault/F1/E007', REPEAT('1', 64), TRUE),
(8, 7, 2, 'Financial', 'Fictional payment ledger.', '2025-07-15 13:00:00', 'Verified', 'Vault/G1/E008', REPEAT('2', 64), TRUE),
(9, 8, 3, 'Photograph', 'Fictional site photographs.', '2025-08-20 09:00:00', 'Verified', 'Vault/H1/E009', REPEAT('3', 64), FALSE),
(10, 9, 2, 'Document', 'Fictional petition supporting records.', '2025-09-10 10:15:00', 'Verified', 'Vault/I1/E010', REPEAT('4', 64), FALSE),
(11, 10, 3, 'Document', 'Fictional lower court order copy.', '2025-10-20 15:00:00', 'Verified', 'Vault/J1/E011', REPEAT('5', 64), FALSE),
(12, 2, 2, 'Photograph', 'Fictional inspection photographs.', '2025-02-20 10:00:00', 'Under Review', 'Vault/B1/E012', REPEAT('6', 64), FALSE);

-- 12. DOCUMENTS
INSERT INTO documents
(document_id, case_id, uploaded_by_user_id, document_type, title, uploaded_date, file_reference, version, status)
VALUES
(1, 1, 3, 'FIR', 'Sample FIR Record', '2025-01-10 11:00:00', 'documents/case001/fir.pdf', 1, 'Approved'),
(2, 1, 3, 'Evidence Report', 'Sample Evidence Report', '2025-01-25 12:00:00', 'documents/case001/evidence_report.pdf', 1, 'Approved'),
(3, 2, 3, 'Agreement', 'Sample Commercial Agreement', '2025-02-05 10:00:00', 'documents/case002/agreement.pdf', 1, 'Approved'),
(4, 3, 4, 'Contract', 'Sample Corporate Contract', '2025-03-12 12:00:00', 'documents/case003/contract.pdf', 1, 'Approved'),
(5, 4, 3, 'Property Record', 'Sample Property Record', '2025-04-18 09:00:00', 'documents/case004/property.pdf', 1, 'Approved'),
(6, 5, 4, 'Final Order', 'Sample Final Order', '2025-12-15 14:00:00', 'documents/case005/final_order.pdf', 1, 'Approved'),
(7, 6, 3, 'Petition', 'Sample Family Petition', '2025-06-11 10:00:00', 'documents/case006/petition.pdf', 1, 'Under Review'),
(8, 7, 3, 'Financial Statement', 'Sample Financial Statement', '2025-07-09 11:00:00', 'documents/case007/financials.pdf', 1, 'Approved'),
(9, 8, 4, 'Claim Report', 'Sample Compensation Claim', '2025-08-14 13:00:00', 'documents/case008/claim.pdf', 1, 'Approved'),
(10, 9, 4, 'Petition', 'Sample Constitutional Petition', '2025-09-02 09:00:00', 'documents/case009/petition.pdf', 1, 'Approved'),
(11, 10, 4, 'Appeal', 'Sample Appeal Document', '2025-10-15 10:00:00', 'documents/case010/appeal.pdf', 1, 'Under Review');

-- 13. DEADLINES
INSERT INTO deadlines
(deadline_id, case_id, deadline_type, due_date, responsible_user_id, status, description)
VALUES
(1, 1, 'Evidence Submission', '2026-11-20 17:00:00', 2, 'Pending', 'Submit remaining evidence.'),
(2, 2, 'Document Filing', '2026-11-25 17:00:00', 3, 'Pending', 'File supporting commercial documents.'),
(3, 3, 'Written Arguments', '2026-12-01 17:00:00', 3, 'Pending', 'Submit written arguments.'),
(4, 4, 'Property Verification', '2026-10-15 17:00:00', 2, 'Completed', 'Complete property record verification.'),
(5, 5, 'Final Documentation', '2025-12-10 17:00:00', 4, 'Completed', 'Complete final case documentation.'),
(6, 6, 'Response Filing', '2026-11-28 17:00:00', 3, 'Pending', 'File response to application.'),
(7, 7, 'Financial Records', '2026-12-05 17:00:00', 2, 'Pending', 'Submit financial records.'),
(8, 8, 'Final Submissions', '2026-10-20 17:00:00', 4, 'Completed', 'Submit final written arguments.'),
(9, 9, 'Affidavit Filing', '2026-12-10 17:00:00', 4, 'Pending', 'File supporting affidavit.'),
(10, 10, 'Appeal Documents', '2026-12-15 17:00:00', 3, 'Pending', 'Complete appeal documentation.');

-- 14. HEARINGS
INSERT INTO hearings
(hearing_id, case_id, judge_id, hearing_date, start_time, end_time, hearing_type, purpose, outcome, status, courtroom, next_hearing_date, notes)
VALUES
(1, 1, 1, '2025-02-10', '10:00:00', '10:45:00', 'Preliminary', 'Initial case review.', 'Matter adjourned.', 'Completed', 'Courtroom 1', '2025-03-10', 'Fictional sample hearing.'),
(2, 1, 1, '2025-03-10', '11:00:00', '11:45:00', 'Evidence', 'Review submitted evidence.', 'Further evidence requested.', 'Completed', 'Courtroom 1', '2026-11-18', 'Fictional sample hearing.'),
(3, 2, 2, '2025-03-15', '10:30:00', '11:15:00', 'Preliminary', 'Review commercial dispute.', 'Reply requested.', 'Completed', 'Courtroom 2', '2026-11-22', 'Fictional sample hearing.'),
(4, 3, 3, '2025-04-20', '12:00:00', '12:45:00', 'Arguments', 'Hear corporate submissions.', 'Arguments continued.', 'Completed', 'Courtroom 3', '2026-11-25', 'Fictional sample hearing.'),
(5, 4, 4, '2025-06-01', '10:00:00', '10:40:00', 'Evidence', 'Examine property records.', 'Evidence concluded.', 'Completed', 'Courtroom 4', '2026-11-20', 'Fictional sample hearing.'),
(6, 5, 1, '2025-12-15', '11:00:00', '11:50:00', 'Final', 'Deliver final order.', 'Matter disposed.', 'Completed', 'Courtroom 1', NULL, 'Fictional sample hearing.'),
(7, 6, 4, '2025-07-15', '10:15:00', '11:00:00', 'Preliminary', 'Review family petition.', 'Mediation suggested.', 'Completed', 'Courtroom 4', '2026-11-27', 'Fictional sample hearing.'),
(8, 7, 2, '2025-08-10', '12:00:00', '12:45:00', 'Evidence', 'Review payment records.', 'Additional records requested.', 'Completed', 'Courtroom 2', '2026-11-29', 'Fictional sample hearing.'),
(9, 8, 3, '2025-09-20', '10:30:00', '11:15:00', 'Arguments', 'Hear compensation claim.', 'Reserved for judgment.', 'Completed', 'Courtroom 3', NULL, 'Fictional sample hearing.'),
(10, 9, 5, '2025-10-10', '11:00:00', '11:45:00', 'Constitutional', 'Review constitutional petition.', 'Notice issued.', 'Completed', 'High Court Room 1', '2026-12-05', 'Fictional sample hearing.'),
(11, 10, 5, '2025-11-10', '12:00:00', '12:45:00', 'Appeal', 'Review appeal documents.', 'Further hearing scheduled.', 'Completed', 'High Court Room 2', '2026-12-12', 'Fictional sample hearing.');

-- 15. JUDGMENTS
-- document_id values refer to documents inserted above.
INSERT INTO judgments
(judgment_id, case_id, document_id, judgment_type, judgment_date, decision, penalties, status, notes)
VALUES
(1, 5, 6, 'Final Judgment', '2025-12-15', 'Fictional sample decision: matter disposed after review of submitted records.', 'As specified in the fictional final order.', 'Delivered', 'Demonstration record only.'),
(2, 4, 5, 'Interim Order', '2025-10-01', 'Fictional sample interim direction concerning property records.', NULL, 'Delivered', 'Demonstration record only.'),
(3, 8, 9, 'Reserved Judgment', '2025-09-20', 'Fictional sample matter reserved for judgment.', NULL, 'Reserved', 'Demonstration record only.');

-- 16. CASE WITNESSES
INSERT INTO case_witnesses
(case_witness_id, case_id, witness_id, witness_role, statement_date, status, notes)
VALUES
(1, 1, 1, 'Eyewitness', '2025-01-15', 'Examined', 'Fictional witness record.'),
(2, 1, 3, 'Expert Witness', '2025-03-05', 'Summoned', 'Digital evidence expert.'),
(3, 2, 2, 'Witness', '2025-02-10', 'Examined', 'Fictional witness record.'),
(4, 3, 5, 'Expert Witness', '2025-05-18', 'Examined', 'Fictional corporate records expert.'),
(5, 4, 4, 'Witness', '2025-04-12', 'Examined', 'Fictional witness record.'),
(6, 5, 6, 'Eyewitness', '2025-06-20', 'Examined', 'Fictional witness record.'),
(7, 6, 7, 'Witness', '2025-07-08', 'Summoned', 'Fictional witness record.'),
(8, 7, 8, 'Expert Witness', '2025-08-14', 'Examined', 'Financial records expert.'),
(9, 8, 2, 'Witness', '2025-02-10', 'Examined', 'Fictional witness record.'),
(10, 9, 5, 'Expert Witness', '2025-05-18', 'Summoned', 'Fictional expert record.');

-- 17. EVIDENCE WITNESSES
INSERT INTO evidence_witnesses
(evidence_witness_id, evidence_id, witness_id, relationship_type, notes)
VALUES
(1, 1, 3, 'Verified By', 'Expert reviewed the digital transaction logs.'),
(2, 2, 1, 'Submitted By', 'Witness supplied the fictional statement.'),
(3, 3, 2, 'Witness To', 'Witness confirmed the fictional agreement.'),
(4, 4, 5, 'Verified By', 'Expert reviewed the email records.'),
(5, 5, 4, 'Witness To', 'Witness identified the fictional property record.'),
(6, 6, 6, 'Collected By', 'Witness assisted in fictional evidence collection.'),
(7, 7, 7, 'Submitted By', 'Witness supplied the fictional proposal.'),
(8, 8, 8, 'Verified By', 'Expert reviewed the fictional financial ledger.'),
(9, 9, 2, 'Witness To', 'Witness identified the fictional site photographs.'),
(10, 10, 5, 'Verified By', 'Expert reviewed supporting records.');

-- 18. CHAIN OF CUSTODY
INSERT INTO chain_of_custody
(custody_id, evidence_id, from_user_id, to_user_id, transfer_date, transfer_reason, location, remarks)
VALUES
(1, 1, 2, 3, '2025-01-21 10:00:00', 'Initial evidence review', 'Evidence Room A', 'Seal checked during transfer.'),
(2, 1, 3, 4, '2025-01-22 14:00:00', 'Secure archival storage', 'Digital Vault A', 'Integrity hash recorded.'),
(3, 2, 2, 3, '2025-01-23 11:00:00', 'Document verification', 'Records Room B', 'Document received in sealed condition.'),
(4, 3, 3, 2, '2025-02-16 12:00:00', 'Evidence examination', 'Evidence Room B', 'Fictional transfer record.'),
(5, 4, 2, 4, '2025-03-21 10:30:00', 'Digital evidence preservation', 'Digital Vault C', 'Integrity hash checked.'),
(6, 5, 3, 4, '2025-04-26 15:00:00', 'Document archival', 'Records Room D', 'Fictional transfer record.'),
(7, 6, 2, 3, '2025-05-26 10:00:00', 'Forensic review', 'Evidence Room E', 'Device seal verified.'),
(8, 8, 2, 4, '2025-07-16 13:30:00', 'Financial evidence review', 'Digital Vault G', 'Integrity hash checked.');

-- =============================================
-- END OF SAMPLE DATA
-- =============================================
