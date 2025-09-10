terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-1"
}

# S3 Buckets
resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "rekonitions3"
}

resource "aws_s3_bucket_website_configuration" "frontend_website" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket" "image_bucket" {
  bucket = "rekognition-project-target"
}

# DynamoDB Table
resource "aws_dynamodb_table" "image_metadata" {
  name         = "image-resizer-database"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "imageId"

  attribute {
    name = "imageId"
    type = "S"
  }
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_execution_role" {
  name = "rekognition-lambda-role-ghhd38td"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaBasicExecutionRole"
}

# Lambda Function
resource "aws_lambda_function" "rekognition_function" {
  function_name = "rekognition-function"
  role          = aws_iam_role.lambda_execution_role.arn
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.image_bucket.bucket
      TABLE_NAME  = aws_dynamodb_table.image_metadata.name
    }
  }
}
