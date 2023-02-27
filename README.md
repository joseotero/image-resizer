# Dockerized Image Resizer Application

This is an image resizer application that resizes images using Node.js 16. The application includes two JavaScript files, app.js and parse.js, and a package.json file.

## Building and Deploying the Application

### Build

To build the application, run the following command:
```
bash ./build.sh
```

### Terraform Deploy

To deploy the application using Terraform, navigate to the `terraform` directory and run the following commands:

```
terraform init
terraform apply
```

### Serverless Deploy

To build and deploy the application using the Serverless Framework, navigate to the `serverless` directory and run the following commands:

```
make deploy
```

## Modifying the Application

This application has been instrumented to send traces to the AWS X-Ray service.

## License

This project is licensed under the MIT License.
