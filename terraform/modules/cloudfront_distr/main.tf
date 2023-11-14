resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = var.OAC-name
  description                       = var.OAC-description
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  default_root_object = "index.html"
  origin {
    domain_name              = var.domain_name_origin
    origin_id                = var.origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.origin_id
    viewer_protocol_policy = "redirect-to-https"
    # cache_policy_id="forwarded_values"
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }


  }
  provisioner "local-exec" {
    command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.s3_distribution.id} --paths '/*'"
  }
  aliases = var.domains
  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.my_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

}


provider "aws" {
  alias = "acm_provider"

  region = "us-east-1"
}

data "aws_acm_certificate" "my_cert" {
  provider = "aws.acm_provider"
  domain   = var.domains[1]

}


