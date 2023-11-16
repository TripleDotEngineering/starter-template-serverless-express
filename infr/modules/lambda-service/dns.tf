/**
 * This file contains the mapping of the DNS record to API Gateway
 */

resource "aws_apigatewayv2_domain_name" "dns" {
  domain_name = "${var.domain_name}"
  domain_name_configuration {
    certificate_arn = "${var.tls_certificate_arn}"
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_route53_record" "dns_record" {
  name    = aws_apigatewayv2_domain_name.dns.domain_name
  type    = "A"
  zone_id = "Z00983702P8R9770PC701"

  alias {
    name                   = aws_apigatewayv2_domain_name.dns.domain_name_configuration[0].target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.dns.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}
