CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main lambda/main.go #go into lambda folder and run
zip deployment.zip main
terraform init #go into lambda folder and run
terraform plan  #go into lambda folder and run
terraform apply #go into lambda folder and run

create aws SQS queues from terraform
create aws postgres rdbms using terraform
if bucket is arleady existing terraform apply is failing - research 
