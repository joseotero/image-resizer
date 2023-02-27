variable "tags" {
  type = object({
    project     = string
    terraform   = string
    environment = string
    app         = string
  })
}

variable "aws_region" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "s3_lambda_code" {
  type = string
}