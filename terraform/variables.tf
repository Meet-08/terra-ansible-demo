variable "ec2_instance_type" {
  default     = "t3.micro"
  type        = string
  description = "This is instance type use to create instance_type"
}

variable "ec2_ami_id" {
  default = "ami-02b8269d5e85954ef"
  type    = string
}