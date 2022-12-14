variable "general_config" {
  description = "Project and Environment name"
  default = {
    project     = "example"
    environment = "stg"
  }
}

variable "vpc" {
  description = "CIDR BLOCK for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "public_subnets" {
  default = ["10.0.10.0/24", "10.0.30.0/24"]
}

variable "private_subnets" {
  default = ["10.0.20.0/24", "10.0.40.0/24"]
}