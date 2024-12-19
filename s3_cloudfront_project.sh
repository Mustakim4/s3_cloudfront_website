# VARIABLES
BUCKET_NAME=<bucket-name>
REGION_NAME=<region-name>


# CREATE S3 BUCKET
aws s3api create-bucket --bucket $BUCKET_NAME

# UPLOAD AN OBJECT OR FILES AND FOLDERS
aws s3 cp <your-website-code>/ s3://$BUCKET_NAME --recursive

# CREATE CLOUDFRONT DISTRIBUTION AND ADD S3 BUCKET AS ORIGIN DOMAIN NAME
aws cloudfront create-distribution --origin-domain-name $BUCKET_NAME.s3.$REGION_NAME.amazonaws.com --default-root-object index.html

# generate origin access control skeleton
aws cloudfront create-origin-access-control --generate-cli-skeleton > oac_config.json

# add name and SigningBehavior=always
# to create actual origin access control
# save oac id
aws cloudfront create-origin-access-control --cli-input-json file://oac_config.json

# LIST DISTRIBUTION
aws cloudfront list-distributions

# GET DISTRIBUTION
aws cloudfront get-distribution --id <DISTRIBUTION_ID>

# GET DISTRIBUTION CONFIG TO LOCAL_FILE
aws cloudfront get-distribution-config --id <DISTRIBUTION_ID> > cloudfront_dist_config.json
# add oac id to OriginAccessId
# and delete CustomOriginConfig and add "S3OriginConfig" : { "OriginAccessIdentity": "" } in palce of that

# GET DISTRIBUTION
aws cloudfront get-distribution --id <DISTRIBUTION_ID>
# save etag value and paste in down below --if-match value

# UPDATING CONFIGURATION FILE TO CLOUDFRONT AFTER CHANGING
aws cloudfront update-distribution --id <distribution-id> --if-match <ETag> --distribution-config file://cloudfront_dist_config.json


## s3 cloudfront policy (IMP)
# now the important thing comes in picture create a policy or paste my policy file name is 
cloudfront_s3_policy.json

# update bucket policy
aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy file://cloudfront_s3_policy.json


# GET DISTRIBUTION
aws cloudfront get-distribution --id <DISTRIBUTION_ID>
# in that from distribution COPY DomainName and paste in your browser




## CLEAN UP

# DELETE OBJECT OF BUCKET
aws s3 rm s3://$BUCKET_NAME --recursive

# DELETE BUCKET
aws s3api delete-bucket --bucket $BUCKET_NAME

# GET DISTRIBUTION
aws cloudfront get-distribution --id <DISTRIBUTION_ID>
# remember ETag is changing every time so you have to get new etag you always have to run above line

# after this in your cloudfront config file cloudfront_dist_config.json EDIT the value of Enabled to false and update it
aws cloudfront update-distribution --id <distribution-id> --if-match <ETag> --distribution-config file://cloudfront_dist_config.json

# wait for few minutes
# DELETE DISTRIBUTION before deleting disabled it
aws cloudfront delete-distribution --id <id> --if-match <ETAG>

# list Origin access control 
aws cloudfront list-origin-access-controls

# get origin access control
aws cloudfront get-origin-access-control --id <id>

# DELETE Origin access control 
aws cloudfront delete-origin-access-control --id <id> --if-match <ETAG>