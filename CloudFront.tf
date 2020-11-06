resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Some comment"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.website_endpoint
    # origin_id   = "S3-${aws_s3_bucket.bucket.bucket}"
    # origin_id   = "www.${var.Website_Domain_Name}"
    # origin_id   = "${var.Website_Domain_Name}"
    
    origin_id   = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    # origin_id   = aws_s3_bucket.bucket.bucket

    custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

#   logging_config {
#     include_cookies = false
#     bucket          = "mylogs.s3.amazonaws.com"
#     prefix          = "myprefix"
#   }

#   aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    # target_origin_id = "wwww.${var.Website_Domain_Name}"
    target_origin_id = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200" # PriceClass_100 | PriceClass_200 | PriceClass_All (https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PriceClass.html)

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

#   tags = {
#     Environment = "production"
#   }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "CloudFront_URL" {
    value = aws_cloudfront_distribution.s3_distribution.domain_name
}