output "lambda_url" {
  description = "Lambda url"
  value       = aws_lambda_function_url.lambda_url.function_url
}

output "base_url" {
  value = aws_api_gateway_deployment.apideploy.invoke_url
}