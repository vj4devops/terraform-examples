provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_sqs_queue" "my_queue" {
  name                      = "my-queue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  max_message_size          = 2048
  delay_seconds             = 0
  receive_wait_time_seconds = 0
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter.arn,
    maxReceiveCount      = 5,
  })
}

resource "aws_sqs_queue" "dead_letter" {
  name = "my-queue-dead-letter"
}

