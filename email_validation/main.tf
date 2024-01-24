
data "aws_route53_zone" "route53_zone" {
  name         = var.route53_zone_name
  private_zone = false
}


module "acm" {
  source = "github.com/terraform-aws-modules/terraform-aws-acm"

  domain_name = var.domain_name
  zone_id     = data.aws_route53_zone.route53_zone.id

  subject_alternative_names = [
    var.domain_name,
  ]

  validation_method = "EMAIL"

  tags = {
    Name = local.domain_name
  }
}