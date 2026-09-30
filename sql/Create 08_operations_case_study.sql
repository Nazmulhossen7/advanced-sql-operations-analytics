WITH payer_monthly AS (
    SELECT
        payer,
        DATE_FORMAT(submission_date, '%Y-%m') AS month,
        COUNT(*) AS total_claims,
        SUM(
            CASE
                WHEN claim_status = 'Denied' THEN 1
                ELSE 0
            END
        ) AS denied_claims
    FROM healthcare_claims_imported
    WHERE payer IS NOT NULL
      AND TRIM(payer) <> ''
    GROUP BY
        payer,
        DATE_FORMAT(submission_date, '%Y-%m')
),

rates AS (
    SELECT
        payer,
        month,
        total_claims,
        denied_claims,
        ROUND(
            100.0 * denied_claims /
            NULLIF(total_claims, 0),
            2
        ) AS denial_rate
    FROM payer_monthly
)

SELECT
    payer,
    month,
    total_claims,
    denied_claims,
    denial_rate,

    LAG(denial_rate) OVER (
        PARTITION BY payer
        ORDER BY month
    ) AS previous_month_denial_rate,

    ROUND(
        denial_rate -
        LAG(denial_rate) OVER (
            PARTITION BY payer
            ORDER BY month
        ),
        2
    ) AS denial_rate_change,

    RANK() OVER (
        PARTITION BY month
        ORDER BY denial_rate DESC
    ) AS monthly_denial_rank

FROM rates
ORDER BY month, monthly_denial_rank;