provider "aws" {
  region = "ap-southeast-2"  # Set your desired AWS region
}

resource "aws_instance" "ec2" {
  ami           = "ami-04f5097681773b989"  # Specify the AMI ID for the desired Amazon Machine Image
  instance_type = "t2.micro"  # Specify the instance type

  tags = {
    Name = "ec2test-instance"
  }
}
