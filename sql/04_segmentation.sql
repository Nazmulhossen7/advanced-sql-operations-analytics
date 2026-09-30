SELECT
    claim_id,
    patient_id,
    payer,
    billed_amount,
    NTILE(4) OVER (
        ORDER BY billed_amount DESC
    ) AS billing_quartile
FROM healthcare_claims_imported
ORDER BY billed_amount DESC;
WITH claim_segments AS (
    SELECT
        claim_id,
        patient_id,
        payer,
        billed_amount,
        NTILE(4) OVER (
            ORDER BY billed_amount DESC
        ) AS billing_quartile
    FROM healthcare_claims_imported
)

SELECT
    billing_quartile,
    COUNT(*) AS total_claims,
    ROUND(AVG(billed_amount), 2) AS avg_billed_amount,
    ROUND(MIN(billed_amount), 2) AS min_billed_amount,
    ROUND(MAX(billed_amount), 2) AS max_billed_amount
FROM claim_segments
GROUP BY billing_quartile
ORDER BY billing_quartile;