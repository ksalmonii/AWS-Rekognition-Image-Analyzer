import json

def lambda_handler(event, context):
    # Safely get the HTTP method
    method = event.get('httpMethod', '')

    # Define CORS headers
    cors_headers = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "OPTIONS,POST",
        "Access-Control-Allow-Headers": "Content-Type"
    }

    # Handle OPTIONS preflight
    if method == 'OPTIONS':
        return {
            "statusCode": 200,
            "headers": cors_headers,
            "body": json.dumps("Preflight OK")
        }

    # Define bucket name
    bucket_name = "rekognition-project-target"

    # Define object keys
    annotated_key = "annotated/0c190d47-5244-4a0f-8bdb-c4149d0f98e4.jpg"
    original_key = "original/f4e8e394-e1f7-4045-98b8-a8f346666683_visitor.jpg"
    resized_key = "resized/64d503db-a374-4b27-b2b8-5246037d14cf.jpg"

    # Construct HTTPS URLs
    annotated_url = f"https://{bucket_name}.s3.amazonaws.com/{annotated_key}"
    original_url = f"https://{bucket_name}.s3.amazonaws.com/{original_key}"
    resized_url = f"https://{bucket_name}.s3.amazonaws.com/{resized_key}"

    # Simulated image processing response
    response_body = {
        "message": "Image processed successfully",
        "imageId": "d644cd4b-2b4d-4af8-8fb9-09c47bd82ef3",
        "annotatedImageUrl": annotated_url,
        "metadata": {
            "imageId": "d644cd4b-2b4d-4af8-8fb9-09c47bd82ef3",
            "original_file_name": "visitor.jpg",
            "original_size": 162153,
            "resized_size": 1853,
            "annotated_size": 2067,
            "original_s3_url": original_url,
            "resized_s3_url": resized_url,
            "annotated_s3_url": annotated_url,
            "timestamp": "7f08b440-cd9a-4f2f-9108-5cb1091b0dde"
        }
    }

    return {
        "statusCode": 200,
        "headers": cors_headers,
        "body": json.dumps(response_body)
    }
