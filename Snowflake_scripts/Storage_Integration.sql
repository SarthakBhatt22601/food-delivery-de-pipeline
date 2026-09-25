USE WAREHOUSE FOOD_DLV_WH;

-- >>> EDIT THESE TWO <<<
--   <ROLE_ARN> = arn:aws:iam::<your-account-id>:role/food-dlv-s3-role
--   <BUCKET>   = your bucket, e.g. food-delivery-intelligence-platform
CREATE OR REPLACE STORAGE INTEGRATION FOOD_DLV_S3_INT
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = '<IAM_ROLE_ARN>'
  STORAGE_ALLOWED_LOCATIONS = ('s3://<BUCKET>/');

GRANT USAGE ON INTEGRATION FOOD_DLV_S3_INT TO ROLE DBT_ROLE;

-- Run this, then copy the two values into the IAM role trust policy (Step D).
DESC INTEGRATION FOOD_DLV_S3_INT;
--   STORAGE_AWS_IAM_USER_ARN  ->  the "AWS": principal in the trust policy
--   STORAGE_AWS_EXTERNAL_ID   ->  the sts:ExternalId condition

