# Image Resizing Project

This project is designed to resize images using the Sharp library and deploy it to AWS Lambda using Serverless Framework.

## Requirements

- Node.js >= 16.x
- Serverless Framework

## Installation

1. Clone this repository
2. Run `npm install`
3. Run `npm install -g serverless`
4. Configure your aws credentials and your aws_profile in Makefile
3. Run `make build` to build the application or `make deploy` to build and deploy the application to AWS Lambda

## Usage

Once the application is deployed to AWS Lambda, it can be accessed via an API Gateway. The endpoint path is `/image` and accepts `multipart/form` requests with the following fields:

- `file`: the image to be resized
- `idkey`: the name of the image

To send a request to the endpoint, you can use the following cURL command:

curl --location --request POST 'https://API_GATEWAY_URL/image'
--form 'file=@path/to/image.jpg'
--form 'idkey=image.jpg'


## Deployment

To deploy the application to AWS Lambda, you can use the following command:

```make deploy```


This command uses the `serverless.yaml` file to create and configure the necessary resources in AWS Lambda and API Gateway.

## Clean up

To remove all resources created in AWS Lambda and API Gateway, you can use the following command:

```make clean```

This command removes all resources created by Serverless Framework in AWS.
