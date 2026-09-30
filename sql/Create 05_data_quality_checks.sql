###Create 05_data_quality_checks
-- Duplicate claim IDs
SELECT
    claim_id,
    COUNT(*) AS duplicate_count
FROM healthcare_claims_imported
GROUP BY claim_id
HAVING COUNT(*) > 1;

-- Missing payer
SELECT
    COUNT(*) AS missing_payer_count
FROM healthcare_claims_imported
WHERE payer IS NULL
   OR TRIM(payer) = '';

-- Paid greater than allowed
SELECT
    claim_id,
    allowed_amount,
    paid_amount
FROM healthcare_claims_imported
WHERE paid_amount > allowed_amount;

-- Submission before service date
SELECT
    claim_id,
    service_date,
    submission_date
FROM healthcare_claims_imported
WHERE submission_date < service_date;

-- Denied claims with missing denial reason
SELECT
    claim_id,
    claim_status,
    denial_reason
FROM healthcare_claims_imported
WHERE claim_status = 'Denied'
  AND (
      denial_reason IS NULL
      OR TRIM(denial_reason) = ''
  );

-- Negative financial values
SELECT
    claim_id,
    billed_amount,
    allowed_amount,
    paid_amount
FROM healthcare_claims_imported
WHERE billed_amount < 0
   OR allowed_amount < 0
   OR paid_amount < 0;
   SELECT
    'Duplicate Claim IDs' AS issue_type,
    COUNT(*) AS issue_count
FROM (
    SELECT claim_id
    FROM healthcare_claims_imported
    GROUP BY claim_id
    HAVING COUNT(*) > 1
) d

UNION ALL

SELECT
    'Missing Payer',
    COUNT(*)
FROM healthcare_claims_imported
WHERE payer IS NULL
   OR TRIM(payer) = ''

UNION ALL

SELECT
    'Paid > Allowed Amount',
    COUNT(*)
FROM healthcare_claims_imported
WHERE paid_amount > allowed_amount

UNION ALL

SELECT
    'Submission Before Service Date',
    COUNT(*)
FROM healthcare_claims_imported
WHERE submission_date < service_date

UNION ALL

SELECT
    'Denied Claim Missing Denial Reason',
    COUNT(*)
FROM healthcare_claims_imported
WHERE claim_status = 'Denied'
  AND (
      denial_reason IS NULL
      OR TRIM(denial_reason) = ''
  )

UNION ALL

SELECT
    'Negative Financial Values',
    COUNT(*)
FROM healthcare_claims_imported
WHERE billed_amount < 0
   OR allowed_amount < 0
   OR paid_amount < 0;