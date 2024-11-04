# 1. Tạo VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_vpc"
  }
}

# Tạo Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

# Tạo Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "public-subnet"
  }
}

# Tạo Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private-subnet"
  }
}


# Tạo default security group
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.my_vpc.id # ID của VPC bạn muốn áp dụng

  tags = {
    Name = "Default security group"
  }
}


# IAM Role for VPC Flow Logs
resource "aws_iam_role" "vpc_flow_logs_role" {
  name = "vpc_flow_logs_role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "sts:AssumeRole"
        ],
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "transitgateway.amazonaws.com"
          ]
        }
      }
    ]
  })
}

# VPC Flow Log with correct IAM Role ARN
resource "aws_flow_log" "log_destination" {
  log_destination_type = "cloud-watch-logs"
  vpc_id               = aws_vpc.my_vpc.id
  iam_role_arn         = aws_iam_role.vpc_flow_logs_role.arn # Correct ARN

  tags = {
    Name = "vpc_flow_logs"
  }
}

# Attach a policy to allow logs to be written to CloudWatch Logs
resource "aws_iam_role_policy" "vpc_flow_logs_policy" {
  name = "vpc_flow_logs_policy"
  role = aws_iam_role.vpc_flow_logs_role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "IPAMDiscoveryDescribeActions",
        "Effect" : "Allow",
        "Action" : [
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAddresses",
          "ec2:DescribeByoipCidrs",
          "ec2:DescribeIpv6Pools",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribePublicIpv4Pools",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSecurityGroupRules",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpnConnections",
          "ec2:GetIpamDiscoveredAccounts",
          "ec2:GetIpamDiscoveredPublicAddresses",
          "ec2:GetIpamDiscoveredResourceCidrs",
          "globalaccelerator:ListAccelerators",
          "globalaccelerator:ListByoipCidrs",
          "organizations:DescribeAccount",
          "organizations:DescribeOrganization",
          "organizations:ListAccounts",
          "organizations:ListDelegatedAdministrators"
        ],
      },
      {
        "Sid" : "CloudWatchMetricsPublishActions",
        "Effect" : "Allow",
        "Action" : "cloudwatch:PutMetricData",
        "Condition" : {
          "StringEquals" : {
            "cloudwatch:namespace" : "AWS/IPAM"
          }
        }
      }
    ]
  })
}



