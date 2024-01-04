CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main lambda/main.go #go into lambda folder and run
zip deployment.zip main
terraform init #go into lambda folder and run
terraform plan  #go into lambda folder and run
terraform apply #go into lambda folder and run

