resource "aws_apigatewayv2_api" "api" {
  name          = "${var.function_name}_api"
  protocol_type = "HTTP"
  tags = {
    project_key = "${var.project_key}"
  }
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id        = aws_apigatewayv2_api.api.id
  name          = "${var.function_name}_api_stage"
  auto_deploy   = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn
    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }

  tags = {
    project_key = "${var.project_key}"
  }
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                = aws_apigatewayv2_api.api.id
  integration_uri       = aws_lambda_function.the_function.invoke_arn
  integration_type      = "AWS_PROXY"
  integration_method    = "POST"
}

resource "aws_apigatewayv2_route" "api_route" {
  api_id            = aws_apigatewayv2_api.api.id
  route_key         = "ANY /{proxy+}"
  target            = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name              = "/aws/api_gw/${aws_apigatewayv2_api.api.name}"
  retention_in_days = 30
}

resource "aws_apigatewayv2_api_mapping" "api_mapping" {
  api_id      = aws_apigatewayv2_api.api.id
  domain_name = aws_apigatewayv2_domain_name.dns.id
  stage       = aws_apigatewayv2_stage.lambda.id
}