provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "this" {
  provider                = aws.us_east_1
  domain_name             = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method       = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "this" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = var.zone_id
  ttl             = 60
}
