import json
import boto3
from PIL import Image
from io import BytesIO

# Initialize the S3 client
s3_client = boto3.client('s3')

def lambda_handler(event, context):
    """
    AWS Lambda function to remove EXIF metadata from .jpg images uploaded to S3.
    The images are then saved to another S3 bucket with the same path.
    """
    # Log the event received for debugging purposes
    print("Received event:", event)
    
    # Extract the bucket name and object key from the event
    try:
        records = event.get('Records', [])
        if not records:
            print("No records found in the event.")
            return {
                'statusCode': 400,
                'body': json.dumps("Error: No records found in the event.")
            }
        
        # Get the bucket name and the object key
        s3_event = records[0].get('s3', {})
        source_bucket = s3_event.get('bucket', {}).get('name', '')
        source_key = s3_event.get('object', {}).get('key', '')

        if not source_bucket or not source_key:
            print(f"Error: Missing bucket name or object key in event: {event}")
            return {
                'statusCode': 400,
                'body': json.dumps("Error: Missing bucket name or object key in event.")
            }
        
        print(f"Processing file {source_key} from bucket {source_bucket}")
        
        # Only process .jpg files
        if not source_key.lower().endswith('.jpg'):
            print(f"Skipping non-.jpg file: {source_key}")
            return {
                'statusCode': 200,
                'body': json.dumps(f"File is not a .jpg: {source_key}")
            }
        
        # Download the image from S3
        response = s3_client.get_object(Bucket=source_bucket, Key=source_key)
        image_data = response['Body'].read()

        # Open the image using Pillow
        image = Image.open(BytesIO(image_data))

        # Remove EXIF data if it exists
        if "exif" in image.info:
            del image.info["exif"]

        # Save the image to a buffer (without EXIF data)
        output_buffer = BytesIO()
        image.save(output_buffer, format='JPEG')
        output_buffer.seek(0)

        # Define the destination bucket and object key
        destination_bucket = 'your-destination-bucket'  # Replace with the name of Bucket B
        destination_key = source_key  # Preserve the original file path

        # Upload the processed image to Bucket B
        s3_client.put_object(Bucket=destination_bucket, Key=destination_key, Body=output_buffer)
        print(f"Image saved to {destination_bucket}/{destination_key}")

        return {
            'statusCode': 200,
            'body': json.dumps(f"Processed and saved image to {destination_bucket}/{destination_key}")
        }

    except Exception as e:
        print(f"Error processing event: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error processing event: {str(e)}")
        }
