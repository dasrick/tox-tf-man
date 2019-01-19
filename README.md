[![pipeline status](https://gitlab.com/tox-aws-terraform/tox-tf-man/badges/master/pipeline.svg)](https://gitlab.com/tox-aws-terraform/tox-tf-man/commits/master)

***

# tox-tf-man

> playground of MAN ... terraform part

...

## the idea

How to get data from CSV file into AWS structure to read, transform, search etc. in it ...

available steps

* upload a CSV or GZipped CSV file into S3 Bucket (better use gzip because size matters)
* S3 notification to Lambda "importer"
* importer read the file line by line, uncompress if needed and push the data row into a SNS topic
* the lambda "transformer" has subscripted the SNS topic and read the event

next steps

* lambda "transformer" should transform and put the data row into one ore more DynamoDB tables
* "another lambda" to read from DynamoDB tables, generate and return a result
* API to call "another lambda"
* ... 

## internal hint 

This repo is mirrored to gitlab.org. There we use the CI/CD ... yes, i know travis.
This gitlab-ci will validate and roll out the infrastructure ... and destroy triggered via scheduler

***
