SELECT
    payer,
    claim_status,
    COUNT(*) AS total_claims,
    ROUND(SUM(billed_amount), 2) AS total_billed
FROM healthcare_claims_imported
GROUP BY payer, claim_status WITH ROLLUP;