# Terraform AWS Lambda Deployment

This Terraform project deploys a Node.js Lambda function to AWS, along with an API Gateway to trigger the function. The Lambda function resizes the image sent as multipart/form-data and writes it to an S3 bucket, which is specified via environment variable.

The code of the lambda has been instrumented with X-Ray module, and writes logs in Cloudwatch logs.

## Terraform Files

The following Terraform files are included in this project:

- `00_main.tf`: Contains the main configuration for the project, including the provider, data sources, and modules.
- `01_iam.tf`: Configures IAM roles and policies required for the Lambda function and API Gateway to operate.
- `02_s3.tf`: Creates an S3 bucket to be used by the Lambda function.
- `03_lambda.tf`: Defines the Lambda function, including the deployment package and environment variables.
- `04_apigateway.tf`: Configures the API Gateway, including routes, methods, and integrations with the Lambda function.
- `variables.tf`: Defines the input variables required by the project.
- `versions.tf`: Sets the required Terraform version and AWS provider version.
- `output.tf`: Defines the output variables exposed by the project.
- `terraform.tfvars`: Contains the values for the input variables used by the project.

## Prerequisites

- AWS account with appropriate permissions
- Terraform (>= 1.1) installed
- Serverless Framework installed (>= 2.0)
- Node.js (>= 16) installed
- AWS CLI installed and configured with credentials

## Usage

1. Clone this repository:
```
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
```
2. Navigate to the project directory:
```
cd terraform
```
3. Go to the terraform.tfvars file and replace with your configuration:
```
aws_region = "eu-west-1"
aws_account_id = "XXXXX"
s3_bucket_name = "image-resizer-XXXX"
s3_lambda_code = "lambda-code-XXXX"
```
4. Configure your AWS credentials in ~/.aws/credentials.yml
5. Initialize the terraform project
```
export AWS_PROFILE=<profilename>; terraform init
```
6. Run the following command to preview the changes that will be made
```
terraform plan
```
7. If you are satisfied with the changes, run the following command to apply them:
```
terraform apply
```
This will create the necessary AWS resources, including the S3 bucket, Lambda function, API Gateway endpoint, and IAM roles and policies.

8. Once the resources have been created, you can access the API Gateway endpoint by navigating to the following URL:
```
https://<API_GATEWAY_ID>.execute-api.<AWS_REGION>.amazonaws.com/image
```
Replace <API_GATEWAY_ID> with the ID of the API Gateway resource, and <AWS_REGION> with the AWS region where the resources were created.

9. To destroy the AWS resources created by this project, run the following command:
```
terraform destroy
```

## Author

This project was created by Jose Otero <jloteropena@gmail.com>