package main

import (
	"context"
	"fmt"
	"io"
	"net/http"

	"github.com/aws/aws-lambda-go/lambda"
)

// handler -> Lambda handler
func handler(ctx context.Context, url string) (string, error) {
	return sendReq("GET", url)
}

// sendReq -> Utils func
func sendReq(method, url string) (string, error) {
	client := &http.Client{}
	req, err := http.NewRequest(method, url, nil)

	if err != nil {
		fmt.Println(err)
		return "", err
	}
	res, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
		return "", err
	}
	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)
	if err != nil {
		fmt.Println(err)
		return "", err
	}

	return string(body), nil
}

// main -> Main entry point
func main() {
	lambda.Start(handler)
}
