terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.25"
    }
  }

  # This is where the Terraform state files get stored. It should have been
  # created manually.
  backend "s3" {
    bucket = "tde-snap-tfstates"
    key    = "states/demo-lambda-service.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  // profile = "default"
  region  = "us-east-2"
}

module "lambda_service" {
    source = "./modules/lambda-service"
    
    project_key               = "${var.project_key}"
    deploy_packages_bucket    = "${var.deploy_packages_bucket}"
    function_name             = "${var.function_name}"
    domain_name               = "${var.domain_name}" 
    tls_certificate_arn       = "${var.tls_certificate_arn}"
}