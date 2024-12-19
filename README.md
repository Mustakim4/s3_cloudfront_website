# s3_cloudfront_website
Host a static website using Amazon S3 for storage and Amazon CloudFront for content delivery.

## This repository contains the source code for a static website hosted on an Amazon S3 bucket. 

### The following steps were implemented to ensure secure and scalable delivery:

## 1. The website files were uploaded to an S3 bucket.
## 2. A CloudFront distribution was created and configured for the S3 bucket.
## 3. Origin Access Control (OAC) was established and linked to the CloudFront distribution.
## 4. An S3 bucket policy was created to restrict access to the website, allowing only CloudFront to serve the content.
## 5. This setup provides secure, fast, and scalable access to the website.

# imp always save id's