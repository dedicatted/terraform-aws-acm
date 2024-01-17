resource "aws_route53_zone" "this" {
  name = var.domain_name
}

module "acm" {
  source = "github.com/terraform-aws-modules/terraform-aws-acm"

  domain_name = aws_route53_zone.this.name
  zone_id     = aws_route53_zone.this.zone_id

  subject_alternative_names = [
    aws_route53_zone.this.name,
  ]

  validation_method = "EMAIL"

  tags = {
    Name = aws_route53_zone.this.name
  }
}