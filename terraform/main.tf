
provider "aws" {
  region = "eu-west-3"

}

module "react-bucket" {
  source      = "./modules/s3_bucket"
  path        = "/home/khaldoun/Documents/cloudCv/test-app/build"
  bucket_name = "test-bucket-react-cloudchallenge"
  env-prefix  = "dev"
  distr_arn   = module.cloudfront-module.distr_arn
}

module "cloudfront-module" {
  source             = "./modules/cloudfront_distr"
  domains            = ["www.khaldoun.tech", "khaldoun.tech"]
  OAC-name           = "firstt"
  domain_name_origin = module.react-bucket.domain_name
  origin_id          = module.react-bucket.origin_id
}

module "dynamodb_table" {
  source = "./modules/dynamodb"
  TableName = "ViewsTable"
}

module "lambda_funct" {
  source = "./modules/lambda_function"
filename = "../back/main.js"
function_name = "dynamoDB"
roleName = "arn:aws:iam::813382538170:role/service-role/lambdaDynamo"
handler = "index.handler"
runtime = "nodejs18.x"
}

resource "aws_api_gateway_rest_api" "api" {
  name          = "AddCounter"
}
resource "aws_api_gateway_resource" "resource" {
  rest_api_id = "${aws_api_gateway_rest_api.api.id}"
  parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
  path_part   = "dynamoDB"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = "${aws_api_gateway_rest_api.api.id}"
  resource_id   = "${aws_api_gateway_resource.resource.id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_funct.arn_lambda
}

# provider "aws" {
#   alias      = "acm_provider"
#   region     = "us-east-1"
# }

# resource "aws_acm_certificate" "my_cert" {
#   provider          = "aws.acm_provider" # because ACM needs to be used in the "us-east-1" region
#   domain_name       = "${var.my_domain_name}"
#   validation_method = "DNS"
# }
# resource "aws_s3_object" "upload_object" {
#   for_each      = fileset("../../test-app/build", "*")
#   bucket        = aws_s3_bucket.bucket.id
#   key           = each.value
#   source        = "../../test-app/build/${each.value}"
#   etag          = filemd5("html/${each.value}")

# }
