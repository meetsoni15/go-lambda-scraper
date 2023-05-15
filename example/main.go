package main

import (
	"fmt"
	"log"
	"time"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/lambda"
)

func main() {
	// Create a session using your AWS credentials and the desired region
	sess, err := session.NewSession(&aws.Config{
		Region: aws.String("us-east-1"), // Set your desired AWS region here
	})
	if err != nil {
		panic(err)
	}

	// Create a Lambda client using the session
	svc := lambda.New(sess)

	// Define the list of Lambda function names
	functionNames := []string{"proxy_0", "proxy_1", "proxy_2", "proxy_3", "proxy_4"}

	payload := fmt.Sprintf(`"%s"`, "https://ipinfo.io/ip")

	// Initialize a counter to keep track of the current function index
	counter := 0

	for i := 0; i < 10; i++ {
		// Get the current function name based on the counter
		functionName := functionNames[counter]
		// Define the input payload for the Lambda function
		input := &lambda.InvokeInput{
			FunctionName: aws.String(functionName),
			Payload:      []byte(payload), // Replace with your desired payload as a JSON string
		}
		log.Println("us-east-1", functionName)
		// Invoke the Lambda function
		result, err := svc.Invoke(input)
		if err != nil {
			panic(err)
		}
		log.Println(string(result.Payload))
		// Handle the response from the Lambda function
		if result.FunctionError != nil {
			log.Println("Function Error:", *result.FunctionError)
		} else {
			log.Println("Invocation Result:", string(result.Payload))
		}

		// Increment the counter to move to the next function
		counter = (counter + 1) % len(functionNames)

		// Sleep for a short duration to simulate the round-robin behavior
		time.Sleep(time.Second)
	}
}
