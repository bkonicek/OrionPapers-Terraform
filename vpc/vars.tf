variable "vpc_cidr_block" {
  description = "CIDR Block for VPC"
  default     = "10.30.0.0/16"
}

variable "subnet_public_cidr" {
  description = "Public Subnet CIDR Block"
  default     = "10.30.10.0/24"
}

variable "subnet_private_cidr" {
  description = "Private Subnet CIDR Block"
  default     = "10.30.20.0/24"
}

variable "region" {
  default = "us-east-1"
}
