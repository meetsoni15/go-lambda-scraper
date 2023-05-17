# Define the targets
.PHONY:clean all terraform

# Default target
all: goapp terraform 

# Clean up build artifacts
clean:
	rm -f main

# Build Terraform module
terraform:
	cd terraform && terraform init && terraform plan && terraform apply -auto-approve

# Build Go application
goapp:
	GOOS=linux GOARCH=amd64 go build -o main

terraform-destroy:
	cd terraform && terraform destroy -auto-approve