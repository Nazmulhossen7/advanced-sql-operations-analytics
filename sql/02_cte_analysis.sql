WITH status_summary AS (
    SELECT
        claim_status,
        COUNT(*) AS total_claims,
        SUM(billed_amount) AS total_billed,
        SUM(paid_amount) AS total_paid
    FROM healthcare_claims_imported
    GROUP BY claim_status
)

SELECT
    claim_status,
    total_claims,
    ROUND(total_billed, 2) AS total_billed,
    ROUND(total_paid, 2) AS total_paid
FROM status_summary
ORDER BY total_claims DESC;


WITH payer_summary AS (
    SELECT
        payer,
        COUNT(*) AS total_claims,
        SUM(
            CASE
                WHEN claim_status = 'Denied' THEN 1
                ELSE 0
            END
        ) AS denied_claims
    FROM healthcare_claims_imported
    GROUP BY payer
)

SELECT
    payer,
    total_claims,
    denied_claims,
    ROUND(
        100.0 * denied_claims / total_claims,
        2
    ) AS denial_rate_percent
FROM payer_summary
ORDER BY denial_rate_percent DESC;