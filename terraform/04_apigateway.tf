# Create an API Gateway
resource "aws_api_gateway_rest_api" "ag_rest_api" {
  name        = "lambda_ag"
  description = "API Gateway for our lambda"
  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = var.tags
}

# Create a resource for the endpoint
resource "aws_api_gateway_resource" "ag_resource" {
  rest_api_id = aws_api_gateway_rest_api.ag_rest_api.id
  parent_id   = aws_api_gateway_rest_api.ag_rest_api.root_resource_id
  path_part   = "image"
}

# create POST method for the resource
resource "aws_api_gateway_method" "ag_method" {
  rest_api_id   = aws_api_gateway_rest_api.ag_rest_api.id
  resource_id   = aws_api_gateway_resource.ag_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# Configure HTTP response
resource "aws_api_gateway_method_response" "ag_method_response" {
  rest_api_id = aws_api_gateway_rest_api.ag_rest_api.id
  resource_id = aws_api_gateway_resource.ag_resource.id
  http_method = aws_api_gateway_method.ag_method.http_method
  status_code = "200"
}

# Configure integration response
resource "aws_api_gateway_integration_response" "ag_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.ag_rest_api.id
  resource_id = aws_api_gateway_resource.ag_resource.id
  http_method = aws_api_gateway_method.ag_method.http_method
  status_code = aws_api_gateway_method_response.ag_method_response.status_code

  response_templates = {
    "application/json" = ""
  }

  depends_on = [aws_lambda_permission.lambda_permission, aws_lambda_permission.xray]

  content_handling = "CONVERT_TO_TEXT"


}

# Allow the integration of the function with API Gateway
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.image-resizer.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${aws_api_gateway_rest_api.ag_rest_api.id}/*/*/*"
}


# Allow the upload of form data
resource "aws_api_gateway_integration" "ag_form_data" {
  rest_api_id = aws_api_gateway_rest_api.ag_rest_api.id
  resource_id = aws_api_gateway_resource.ag_resource.id
  http_method = aws_api_gateway_method.ag_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.image-resizer.invoke_arn

  request_parameters = {
    "integration.request.header.Content-Type" = "'multipart/form-data'"
  }

  request_templates = {
    "multipart/form-data" = <<EOF
      {
<<EOF
{
  "body": "$util.base64Encode($input.body)",
  "s3Key": "$input.params('s3Key')"
}
EOF
  }
}

resource "aws_api_gateway_deployment" "apideploy" {
  depends_on = [
    aws_api_gateway_integration.ag_form_data
  ]

  rest_api_id = aws_api_gateway_rest_api.ag_rest_api.id
  stage_name  = "test"
}