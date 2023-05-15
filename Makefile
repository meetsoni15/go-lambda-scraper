# Define the targets
.PHONY: all clean goapp terraform 

# Default target
all: goapp terraform 

# Clean up build artifacts
clean:
	rm -f main

# Build Terraform module
terraform:
	cd terraform && terraform init && terraform plan && terraform apply

# Build Go application
goapp:
	GOOS=linux GOARCH=amd64 go build -o main

