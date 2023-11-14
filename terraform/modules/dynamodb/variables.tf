variable "TableName" {
  type = string
}

variable "billing_mode" {
  type = string
  default = "PROVISIONED"
}

variable "read_capacity" {
  type = string
  default = "1"
}

variable "write_capacity" {
  type = string
  default = "1"
}