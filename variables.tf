##General Config
variable "general_config" {
  description = "Project and Environment name"
  default = {
    project     = "example"
    environment = "stg"
  }
}

##Network
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

##EC2
variable "ami" {
  description = "ID of AMI to use for ec2 instance"
  default = "ami-0bba69335379e17f8"
}

variable "instance_type" {
  description = "The type of instance"
  type = string
  default = "t3.micro"
}

variable "key_name" {
  description = "key name of the key pair"
  type = string
  default = "example"
}