resource "aws_dynamodb_table" "ViewsTable" {
  name = var.TableName
  hash_key = "ViewName"
  billing_mode = var.billing_mode
  read_capacity = var.read_capacity
  write_capacity = var.write_capacity
    attribute {
    name = "ViewName"
    type = "S"
  }

}