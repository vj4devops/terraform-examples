package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context, event events.S3Event) {
	for _, record := range event.Records {
		bucket := record.S3.Bucket.Name
		key := record.S3.Object.Key
		size := record.S3.Object.Size

		fmt.Printf("New object created in bucket '%s' with key '%s' and size %d bytes\n", bucket, key, size)
		// Add your processing logic here
	}
}

func main() {
	lambda.Start(handler)
}
