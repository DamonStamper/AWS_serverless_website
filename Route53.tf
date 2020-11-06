resource "aws_route53_zone" "zone" {
  name = var.Website_Domain_Name
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "www.${var.Website_Domain_Name}"
  type    = "A"

  alias {
    # name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# output "www" {
#     value = aws_route53_record.www.
# }