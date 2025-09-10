

output "lambda_function_name" {
  value = aws_lambda_function.rekognition_function.function_name
}


output "s3_frontend_bucket" {
  value = aws_s3_bucket.frontend_bucket.bucket
}

