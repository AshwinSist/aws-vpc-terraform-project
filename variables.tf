variable "vpc_cidr" {
  description = "CIDR block for our AWS VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "AWS VPC Infrastructure with Terraform"
  type        = string
  default     = "terraform-project"
}