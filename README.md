# AWS-Rekognition-Image-Analyzer
AWS Rekognition Image Analyzer
AWS Image Processing & Recognition Pipeline
A serverless pipeline built on AWS that automatically resizes uploaded images, stores them, performs facial analysis using Amazon Rekognition, and logs all metadata to DynamoDB. The infrastructure is fully defined and deployed using Terraform (Infrastructure as Code).
🚀 Features
•	Serverless Image Upload: API endpoint using API Gateway and Lambda to receive images.
•	Automated Processing: Lambda function resizes images to a thumbnail format.
•	AWS Rekognition Integration: Automatically analyzes resized images for facial features, emotions, and other labels.
•	Metadata Storage: All image metadata (original size, resized size, S3 paths, Rekognition data) is stored in Amazon DynamoDB.
•	Infrastructure as Code: Entire AWS infrastructure is provisioned using Terraform.
•	Secure: IAM roles and policies ensure least-privilege access.
🏗️ Architecture

1.	Client uploads an image via a POST request to Amazon API Gateway.
2.	API Gateway triggers an AWS Lambda function.
3.	The Lambda function:
o	Decodes the base64 image.
o	Saves the original image to an Amazon S3 bucket.
o	Resizes the image to a 128x128px thumbnail.
o	Saves the thumbnail to another S3 prefix.
o	Uses Amazon Rekognition to detect labels (faces, objects, etc.) in the thumbnail.
o	Stores all metadata (file paths, sizes, Rekognition results) in Amazon DynamoDB.
4.	Returns a success response with the generated imageId.
📁 Project Structure
text
├── infrastructure/    # Terraform configuration files
│   ├── main.tf       # Defines AWS resources (Lambda, S3, DynamoDB, IAM)
│   ├── variables.tf  # Input variables for configuration
│   └── outputs.tf    # Outputs (e.g., API Gateway URL)
├── src/
│   └── lambda_function.py # Python code for the Lambda handler
├── README.md         # This file
└── .gitignore
⚙️ Technologies Used
•	Compute: AWS Lambda (Python 3.9)
•	Storage: Amazon S3
•	Database: Amazon DynamoDB
•	AI/ML: Amazon Rekognition
•	API Layer: Amazon API Gateway
•	Infrastructure Provisioning: Terraform
•	IAM: For security and permissions
🚀 Deployment (Terraform)
Prerequisites
•	AWS CLI configured with credentials
•	Terraform installed
Steps
1.	Clone the repository:
bash
git clone <your-repo-url>
cd aws-image-rekognition-pipeline
2.	Initialize and apply Terraform configuration:
bash
cd infrastructure
terraform init
terraform plan
terraform apply
3.	Note the API Gateway endpoint: Terraform will output the API URL after apply.
4.	Upload an image:
Use a tool like curl or Postman to POST a base64-encoded image to the endpoint.
bash
curl -X POST <API_GATEWAY_URL> \
-H "Content-Type: application/json" \
-d '{"image": "<base64-encoded-image-data>"}'
📸 Example Usage
Response:
json
{
  "message": "Image uploaded, resized, and metadata stored",
  "imageId": "a1b2c3d4-5678-90ef-abcd-1234567890",
  "rekognitionLabels": [
    {
      "Name": "Person",
      "Confidence": 99.5
    },
    {
      "Name": "Face",
      "Confidence": 99.5
    },
    {
      "Name": "Happy",
      "Confidence": 95.0
    }
  ]
}
📊 What This Project Demonstrates
•	Serverless Architecture: Building scalable, cost-efficient applications without managing servers.
•	AWS Core Services: Hands-on experience with Lambda, S3, DynamoDB, API Gateway, and Rekognition.
•	Infrastructure as Code (IaC): Using Terraform to automate, version, and reproduce cloud infrastructure.
•	Event-Driven Processing: Automating workflows in response to events.
•	Python Development for Cloud: Writing clean, efficient Lambda function code in Python.
________________________________________
This README tells a complete story: you didn't just write code, you designed a system, built it with modern tools, and understood the underlying cloud principles. This is exactly what impresses interviewers.

