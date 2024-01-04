provider "aws" {
  region = "ap-southeast-2"  # Replace with your desired AWS region
}

resource "aws_lambda_function" "lambda_function" {
  depends_on = ["aws_s3_bucket_object.lambda_object"]
  function_name    = "s3lambda"
  runtime          = "go1.x"
  handler          = "main"
  s3_key           = "development-codes/deployment.zip"
  s3_bucket        = "flaskapp-vj-test"
  source_code_hash = filebase64sha256("deployment.zip")
  role             = "arn:aws:iam::517534892847:role/app-lambda"  # Replace with your IAM role ARN

  environment {
    variables = {
      # Add any environment variables needed by your Go Lambda function
    }
  }
}

data "aws_s3_bucket" "lambda_bucket" {
  bucket = "flaskapp-vj-test"  # Replace with a globally unique bucket name
}

resource "aws_s3_bucket_object" "lambda_object" {
  depends_on = ["data.aws_s3_bucket.lambda_bucket"]
  bucket = data.aws_s3_bucket.lambda_bucket.bucket
  key    = "development-codes/deployment.zip"
  source = "deployment.zip"
  acl    = "private"
}

resource "aws_lambda_permission" "s3_trigger_permission" {
  depends_on = ["aws_lambda_function.lambda_function"]
  statement_id  = "s3-trigger"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.arn
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.lambda_bucket.arn
}

resource "aws_s3_bucket_notification" "s3_event_trigger" {
  depends_on = ["aws_lambda_permission.s3_trigger_permission"]
  bucket = data.aws_s3_bucket.lambda_bucket.bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_function.arn
    events             = ["s3:ObjectCreated:*"]
  }
}


#development-codes/deployment.zip from local machine which has executable file, is uploaded to s3 - ln9
#creating the bucket which is done in another pipeline
#builiding the main.go and zipping the same and uploading the deployment.zip to s3 bucket in ln 25
#ln 5 - creata a lambda function and pick the soruce code from s3 bucket 
#from file path - development-codes/deployment.zip
 