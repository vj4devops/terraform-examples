provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_db_instance" "my_postgres_db" {
  identifier           = "my-postgres-db"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "15.4" 
  instance_class       = "db.t3.micro"
  username             = "dbuser"
  password             = "dbpassword"
  parameter_group_name = "default.postgres"

  vpc_security_group_ids = ["sg-0d7de46e0c44d1560"]

}

