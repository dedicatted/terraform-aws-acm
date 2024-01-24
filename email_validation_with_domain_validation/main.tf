data "aws_route53_zone" "route53_zone" {
  name         = var.route53_zone_name
  private_zone = false
}


module "acm" {
  source = "github.com/terraform-aws-modules/terraform-aws-acm"

  domain_name = var.domain_name
  zone_id     = data.aws_route53_zone.route53_zone.id

  # The key is the domain name which you want to change the validation domain for.
  # Validation emails will be send to a fixed list of recipients:
  # admin@VALIDATION_DOMAIN, administrator@VALIDATION_DOMAIN, hostmaster@VALIDATION_DOMAIN, postmaster@VALIDATION_DOMAIN, webmaster@VALIDATION_DOMAIN
  # validation_domain has to be a top-level domain of the actual domain
  validation_option = {
    (var.domain_name) = {
      validation_domain = var.domain_name
    }
  }

  validation_method   = "EMAIL"
  wait_for_validation = false

}