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
variable "public_subnet_id" {

}
variable "private_subnet_id" {

}
variable "public_ec2_sg_id" {

}
variable "private_ec2_sg_id" {

}
