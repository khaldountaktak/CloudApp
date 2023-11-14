output "domain_name" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
  
}

output "origin_id" {
    value = aws_s3_bucket.bucket.id
  
}

output s3_bucket_link {
    value = aws_s3_bucket_website_configuration.react-app.website_endpoint
}