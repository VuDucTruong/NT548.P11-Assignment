run "create_vpc" {
    command = apply
    
    assert {
        condition = module.vpc.aws_vpc_id != ""
        error_message = "Fail to create vpc"
    }
}

run "create_public_subnet" {
    command = apply
    
    assert {
        condition = module.vpc.public_subnet_id != ""
        error_message = "Fail to create public subnet"
    }
}

run "create_private_subnet" {
    command = apply
    
    assert {
        condition = module.vpc.private_subnet_id != ""
        error_message = "Fail to create private subnet"
    }
}

run "create_igw" {
    command = apply
    
    assert {
        condition = module.vpc.igw_id != ""
        error_message = "Fail to create internet gateway"
    }
}