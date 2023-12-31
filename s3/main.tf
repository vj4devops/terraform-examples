provider "aws" {
  region = "ap-southeast-2"  # Set your desired AWS region
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "flaskapp-vj-test"  # Replace with your desired bucket name

  acl    = "private"

  # Enable versioning for the bucket
  versioning {
    enabled = true
  }

  # Configure CORS (Cross-Origin Resource Sharing) policy
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# Create a folder named "images" within the S3 bucket
resource "aws_s3_bucket_object" "images_folder" {
  bucket = aws_s3_bucket.example_bucket.bucket
  key    = "images/"  # The trailing slash indicates a folder
  acl    = "private"
  source = "/dev/null"  # Creating an empty file to represent the folder
}
