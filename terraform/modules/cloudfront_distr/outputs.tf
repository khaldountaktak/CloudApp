output "s3_distribution_link" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cert_arn" {
  value= data.aws_acm_certificate.my_cert.arn
}

output "distr_arn" {
  value = aws_cloudfront_distribution.s3_distribution.arn
}