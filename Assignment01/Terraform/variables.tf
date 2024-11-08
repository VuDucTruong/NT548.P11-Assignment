variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI để tạo EC2 instance"
  type        = string
  default     = "ami-06b21ccaeff8cd686"
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
