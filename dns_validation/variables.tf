variable "domain_name" {
  description = "Domain name to use as Route53 zone and ACM certificate"
  type        = string
  default     = "example-domain-name.com"
}
