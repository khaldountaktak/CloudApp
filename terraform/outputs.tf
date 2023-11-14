output "s3_bucket_id" {
  value = module.react-bucket.s3_bucket_link
}

output "s3_distribution_link" {
  value= module.cloudfront-module.s3_distribution_link
}

output "cert_arn" {
  value= module.cloudfront-module.cert_arn
}

# output "api_id" {
#   value = aws_api_gateway_rest_api.counter.id
# }