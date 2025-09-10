
# AWS Rekognition Image Processing Pipeline

This project is a full-stack cloud application that allows users to upload images via a frontend interface. The uploaded image is processed by an AWS Lambda function that performs the following tasks:

- Stores the original image in an S3 bucket
- Resizes the image to a thumbnail
- Runs Amazon Rekognition to detect labels and bounding boxes
- Annotates the image with labels and bounding boxes using Pillow
- Stores the annotated image in S3
- Saves metadata about the image in DynamoDB
- Returns the annotated image URL and metadata to the frontend

🧾 Files Included
main.tf, lambda.tf, iam.tf, s3.tf, outputs.tf
lambda.zip – zipped Python Lambda function
project write up– visual overview of the infrastructure
screenshots/ – AWS console screenshots for documentation

## Frontend

The `index.html` file provides a simple interface for users to upload images. It sends the image to an API Gateway endpoint using a POST request with base64-encoded image data.

## Backend (Lambda Function)

The Lambda function performs the following steps:

1. Decodes the base64 image from the request
2. Uploads the original image to S3
3. Resizes the image using Pillow
4. Uploads the resized image to S3
5. Calls Amazon Rekognition to detect labels
6. Annotates the image with bounding boxes and label text
7. Uploads the annotated image to S3
8. Stores metadata in DynamoDB
9. Returns the annotated image URL and metadata

## Environment Variables

Set the following environment variables in your Lambda function configuration:

- `DEST_BUCKET`: Name of the destination S3 bucket for storing images
- `DDB_TABLE`: Name of the DynamoDB table for storing image metadata

## API Gateway

Configure an API Gateway endpoint to trigger the Lambda function. Ensure CORS is enabled to allow requests from the frontend.

## Usage

1. Open `index.html` in a browser
2. Select an image file and click "Upload"
3. The image is sent to the API Gateway endpoint
4. The annotated image is displayed on the page

## Requirements

- AWS S3 bucket
- AWS DynamoDB table
- AWS Lambda function with Pillow layer
- API Gateway endpoint
- IAM role with permissions for S3, Rekognition, and DynamoDB

## Permissions

Ensure the Lambda execution role has the following permissions:

- `rekognition:DetectLabels`
- `s3:GetObject`
- `s3:PutObject`
- `dynamodb:PutItem`
- 
Access the Frontend

Visit the S3 static website endpoint (shown in Terraform output).
Upload an image and view the processed results.

## Output

The Lambda function returns a JSON response with:

- `message`: Status message
- `imageId`: Unique ID for the image
- `annotatedImageUrl`: S3 URL of the annotated image
- `metadata`: Metadata stored in DynamoDB


## 🚀 How to Deploy

### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform v1.3.0 or higher
- A zipped Lambda deployment package named `lambda.zip` in the root directory

### Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/<your-username>/rekognition-project.git
   cd rekognition-project
   ```
terraform init

terraform import aws_iam_role.lambda_execution_role rekognition-function-role-ghhd38td
terraform import aws_lambda_function.rekognition_function rekognition-function
terraform import aws_dynamodb_table.image_metadata image-resizer-database
terraform import aws_s3_bucket.image_bucket rekognition-project-target
terraform import aws_s3_bucket.frontend_bucket rekonitions3

terraform plan

terraform apply


## Author

Keith Salmon
