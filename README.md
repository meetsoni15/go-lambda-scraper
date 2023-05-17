# GO AWS LAMBDA SCRAPER

go-lambda-scraper is a powerful tool designed to anonymize your internet traffic by rotating IP addresses. It is especially beneficial for web scraping and other applications that require a high level of anonymity. This tool leverages AWS Lambda functions written in Go to automatically rotate IP addresses.

By utilizing AWS Lambda functions as proxies, you can efficiently retrieve web pages while enjoying the benefits of a diverse range of IP addresses. The solution is cost-effective and offers access to a wide variety of IPs. You can easily configure the number of Lambda functions, AWS account, and deployment region by adjusting the variables in the variables.tf file.

With the automatic IP address rotation mechanism, each Lambda function switches to a new IP address after approximately 6 minutes of inactivity. Imagine having 100 Lambda functions and cycling through them at a rate of one function per second. This enables you to make a significant number of requests while leveraging different IP addresses for each function. However, it's important to note that AWS may occasionally assign the same IP address to multiple Lambda functions, so it's advisable to consider this when utilizing the setup.

By following the steps outlined in the installation guide, you can quickly set up go-lambda-scraper and start benefiting from its IP rotation capabilities. Enjoy enhanced anonymity and efficient web scraping with this powerful tool.

### Prerequisites

- Go installed on your machine
- Terraform installed on your machine
- AWS CLI configured with your AWS credentials

### NOTE: Using main.tf, you can create multiple Lambdas in multiple regions. The example provided covers creating Lambdas in the `us-east-1` and `eu-west-2` regions.

To create Lambdas in additional regions, follow these steps:

1. Open the `main.tf` file in the project directory.

2. Locate the section where the provider configurations are defined. Each provider block starts with `provider "aws" {` and specifies the region using the `region` attribute.

3. To add a new region, copy one of the existing provider blocks and modify the `region` attribute to specify the desired region. For example:

   ```terraform
   ###########################################################
   # AWS init for region 3
   ###########################################################
   provider "aws" {
     ...
     region     = "us-west-2"
     alias      = "us-west-2"
     ...
   }


### Installing

1. Clone the repository:

```bash
git clone https://github.com/meetsoni15/go-lambda-scraper.git
```

2. Change into the project directory:

```bash
cd go-lambda-scraper
```

3. Add AWS Access, Secret & Region in variables.tf

```bash
variable "access_key" {
  #Add AWS access key here
  default = ""
}

variable "secret_key" {
  #Add AWS secret key here
  default = ""
}

# Default region
variable "region" {
  default = "us-east-1"
}
```

4. Add another region where you want to create same lambdas in, Update main.tf
```bash
###########################################################
# AWS init for region 2
###########################################################
provider "aws" {
  ...
  region     = "eu-west-2"
  alias      = "eu-west-2"
  ...
}
``` 

5. Build the Go application & deploy it using Terraform:

```bash
   make
```

### Makefile Instructions
The following commands are available in the Makefile:

- `make goapp`: Builds the Go application for Linux.
- `make terraform`: Initializes Terraform, performs a plan, and applies the changes.
- `make clean`: Removes the built application (main).


### Running the Example
To run the example from Golang, follow these steps:

1. Change into the example directory:

```bash
cd example
```

2. Run the example:

```bash
go run .
```

This will execute the example and display the invocation results with different IP addresses.

Please refer to the example code in example/main.go to see how to utilize the IP rotation functionality in your own Go application.

Feel free to customize the content and sections according to your project's needs.

#### Results
The example will output the following results:

```bash
2023/05/14 23:42:44 us-east-1 proxy_0
2023/05/14 23:42:46 "3.234.182.135"
2023/05/14 23:42:46 Invocation Result: "3.234.182.135"
2023/05/14 23:42:47 us-east-1 proxy_1
2023/05/14 23:42:48 "54.92.248.236"
2023/05/14 23:42:48 Invocation Result: "54.92.248.236"
2023/05/14 23:42:49 us-east-1 proxy_2
2023/05/14 23:42:51 "54.224.168.219"
2023/05/14 23:42:51 Invocation Result: "54.224.168.219"
2023/05/14 23:42:52 us-east-1 proxy_3
2023/05/14 23:42:53 "3.237.232.32"
2023/05/14 23:42:53 Invocation Result: "3.237.232.32"
2023/05/14 23:42:54 us-east-1 proxy_4
2023/05/14 23:42:55 "184.73.151.52"
2023/05/14 23:42:55 Invocation Result: "184.73.151.52"
```

### TODO: Different Region-wise Rotation Example

To demonstrate the rotation of IP addresses in different regions, follow these steps:

1. DONE: Add instructions for creating additional Lambda functions in a different region.
2. TODO: Modify the example code to invoke Lambda functions in multiple regions.
3. TODO: Run the modified example code to observe the rotation of IP addresses across different regions.
