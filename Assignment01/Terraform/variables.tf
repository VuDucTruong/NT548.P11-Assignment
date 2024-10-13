variable "region" {
  default = "us-east-1"
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}

variable "ami_id" {
  description = "AMI để tạo EC2 instance"
  type        = string
  default     = "ami-0fff1b9a61dec8a5f"
}
variable "instance_type" {
  default     = "t2.micro"
  description = "Loại EC2 instance"
  type        = string
}

variable "device_ip" {
  description = "Địa chỉ IP của máy bạn/32"
  type        = string
}
