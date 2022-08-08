# Data Engineering - RDS, EC2, S3, Lambda

This repository contains code where I query data from RDS and select a small dataset to then load into S3 as a json file.
The S3 load triggers a lambda function that further retrieves information from RDS based on keys in the json file.