variable "OAC-name" {
  type = string
}

variable "OAC-description" {
  type = string
  default = "Example Policy"
}

variable "domains" {
  type = list(string)
}

variable "domain_name_origin" {
  type = string
}
variable "origin_id" {
  
}