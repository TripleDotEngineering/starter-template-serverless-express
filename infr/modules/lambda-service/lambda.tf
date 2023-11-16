
resource "aws_lambda_function" "the_function" {
  function_name     = "${var.function_name}"
  s3_bucket         = var.deploy_packages_bucket
  s3_key            = aws_s3_object.deployment_package.key
  runtime           = "${var.runtime}"
  handler           = "${var.entrypoint}"
  timeout           = var.timeout
  memory_size       = var.memory_size
  source_code_hash  = data.archive_file.package_archive.output_base64sha256
  role              = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      LOG_LEVEL = var.log_level
    }
  }

  tags = {
    project_key = "${var.project_key}"
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name                = "/aws/lambda/${aws_lambda_function.the_function.function_name}"
  retention_in_days   = 90
}

resource "aws_lambda_permission" "lambda_api_permission" {
  statement_id      = "AllowExecutionFromAPIGateway"
  action            = "lambda:InvokeFunction"
  function_name     = aws_lambda_function.the_function.function_name
  principal         = "apigateway.amazonaws.com"
  source_arn        = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}




