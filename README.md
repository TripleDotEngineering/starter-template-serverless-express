# Starter Template: Serverless Express

This repository contains a boilerplate starter template for a Node.js Express /
Typescript application that can be deployed to AWS Lambda using 
serverless express.

The application is designed to be run standalone as an Express application, which
is particularly useful for development, or deployed to AWS Lambda.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org) v18+
- [Terraform](https://terraform.io)
- An [AWS](https://aws.amazon.com) account

### AWS Setup

- Create an S3 bucket to store deployment packages
- Create a TLS certificate in AWS Certificate Manager for your domain

### Defining Terraform Variables

Create a file in the `infr` directory called `terraform.tfvars`. 
[Per the docs](https://developer.hashicorp.com/terraform/language/values/variables),
Terraform will automatically load a file named `terraform.tfvars`.

Add your variable configuration to this file. For example:

```terraform
project_key               = "demo-lambda-service"
deploy_packages_bucket    = "your-lambda-bucket-name"
function_name             = "MyLambdaService"
domain_name               = "example.mydomain.com" 
tls_certificate_arn       = "Your TLS Certificate ARN"
```

### Do a Dry Run

This project has configured several NPM scripts (see `[package.json](./package.json)`) 
to streamline the Terraform commands. 

To do a dry run of the Terraform deployment, run:

```bash
npm run infr:plan
```

This will enter the `infr` directory and run `terraform init` and `terraform plan`.

### Live Deployment

To deploy the application to AWS, run:

```bash
npm run infr:deploy
```

This will enter the `infr` directory and run `terraform init` and `terraform apply -auto-approve`.

### Testing the Application

Go to your domain in a web browser and check the `/healthcheck` URL. 
You should see a JSON response with an okay message and 200 status.

### Teardown the Infrastructure

To tear down the infrastructure, run:

```bash
npm run infr:destroy
```
