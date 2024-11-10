variable "ami_id" {
  description = "AMI để tạo EC2 instance"
  type        = string
}
variable "iam_role" {
  type = string
  description = "Tên của IAM role"
}
variable "instance_type" {
  default     = "t2.micro"
  description = "Loại EC2 instance"
  type        = string
}
variable "public_subnet_id" {

}
variable "private_subnet_id" {

}
variable "device_ip" {
  description = "Địa chỉ IP của máy bạn/32"
  type        = string
}
variable "vpc_id" {

}
