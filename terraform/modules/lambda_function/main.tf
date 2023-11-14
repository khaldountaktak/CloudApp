resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = var.filename
  function_name = var.function_name
  role          = var.roleName
  handler       = var.handler

  runtime = var.runtime

}