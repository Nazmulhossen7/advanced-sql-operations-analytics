USE advanced_sql_operations;

SELECT COUNT(*) AS total_claims
FROM healthcare_claims_imported;


SELECT
    COUNT(*) AS total_claims,
    COUNT(DISTINCT patient_id) AS unique_patients,
    COUNT(DISTINCT provider_id) AS unique_providers,
    COUNT(DISTINCT payer) AS unique_payers
FROM healthcare_claims_imported;


SELECT
    claim_status,
    COUNT(*) AS total_claims
FROM healthcare_claims_imported
GROUP BY claim_status
ORDER BY total_claims DESC;