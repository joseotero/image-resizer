# Create a bucket to store the images from lambda function
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name

  tags = var.tags
}

# Create a bucket to store the zip containing lambda function
resource "aws_s3_bucket" "code_bucket" {
  bucket = var.s3_lambda_code

  tags = var.tags
}

# Upload zip file containing lambda function to s3
resource "aws_s3_object" "lambda_object" {
  bucket      = aws_s3_bucket.code_bucket.id
  key         = "image-resizer.zip"
  source      = data.archive_file.lambda_zip.output_path
  source_hash = filemd5(data.archive_file.lambda_zip.output_path)
  tags        = var.tags
}

# Lambda file
data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "../build/image-resizer.zip"
  source_dir  = "../build/image"
}


