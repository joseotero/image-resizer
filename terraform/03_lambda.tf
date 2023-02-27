# Creation of lambda image-resizer
resource "aws_lambda_function" "image-resizer" {
  function_name = "image-resizer"
  handler       = "image-resizer/app.lambdaHandler"
  runtime       = "nodejs16.x"
  s3_bucket     = aws_s3_bucket.code_bucket.id
  s3_key        = aws_s3_object.lambda_object.key
  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.s3_bucket.id
    }
  }

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.lambda_role.arn

  tracing_config {
    mode = "Active"
  }

  tags = var.tags
}

# Create lambda url
resource "aws_lambda_function_url" "lambda_url" {
  function_name      = aws_lambda_function.image-resizer.function_name
  authorization_type = "NONE"
}

# Allow the integration of the lambda with AWS X-Ray
resource "aws_lambda_permission" "xray" {
  statement_id  = "AllowExecutionFromXRay"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.image-resizer.function_name
  principal     = "xray.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.ag_rest_api.id}/*/*/*"
}