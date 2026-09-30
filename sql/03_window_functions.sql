-- ROW_NUMBER: sequence claims per patient
SELECT
    claim_id,
    patient_id,
    submission_date,
    billed_amount,
    ROW_NUMBER() OVER (
        PARTITION BY patient_id
        ORDER BY submission_date DESC
    ) AS claim_sequence
FROM healthcare_claims_imported
ORDER BY patient_id, claim_sequence;
-- Latest claim for each patient
WITH ranked_claims AS (
    SELECT
        claim_id,
        patient_id,
        payer,
        submission_date,
        claim_status,
        billed_amount,
        ROW_NUMBER() OVER (
            PARTITION BY patient_id
            ORDER BY submission_date DESC
        ) AS rn
    FROM healthcare_claims_imported
)

SELECT
    claim_id,
    patient_id,
    payer,
    submission_date,
    claim_status,
    billed_amount
FROM ranked_claims
WHERE rn = 1
ORDER BY patient_id;
WITH provider_summary AS (
    SELECT
        provider_id,
        COUNT(*) AS total_claims,
        SUM(paid_amount) AS total_paid
    FROM healthcare_claims_imported
    GROUP BY provider_id
)

SELECT
    provider_id,
    total_claims,
    ROUND(total_paid, 2) AS total_paid,

    RANK() OVER (
        ORDER BY total_paid DESC
    ) AS provider_rank,

    DENSE_RANK() OVER (
        ORDER BY total_paid DESC
    ) AS provider_dense_rank

FROM provider_summary
ORDER BY total_paid DESC;
WITH monthly_claims AS (
    SELECT
        DATE_FORMAT(submission_date, '%Y-%m') AS month,
        COUNT(*) AS total_claims
    FROM healthcare_claims_imported
    GROUP BY DATE_FORMAT(submission_date, '%Y-%m')
)

SELECT
    month,
    total_claims,
    LAG(total_claims) OVER (
        ORDER BY month
    ) AS previous_month_claims,
    total_claims -
    LAG(total_claims) OVER (
        ORDER BY month
    ) AS month_to_month_change
FROM monthly_claims
ORDER BY month;