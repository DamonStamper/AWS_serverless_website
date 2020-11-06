This repository is focused on standing up a serverless website on AWS utilizing S3, CloudFront, and AWS Lambda.

Tooling used is 'Terraform' and 'make'.

You can open the makefile to determine what commands to run if you don't want to use make as a taskrunner.

Modify the Vars.tfvar file to fit your needs. Please note that you must manually register the domain in Route53 due to a Terraform limitation. Routes will be handled by Terraform--but it cannot commit to the 12 months minimum for registering a domain.