run "create_public_ec2" {
    command = apply
    
    assert {
        condition = module.ec2.public_ec2_id != ""
        error_message = "Fail to create public EC2 instance"
    }
}

run "create_nat_gateway" {
    command = apply
    
    assert {
        condition = module.ec2.private_ec2_id != ""
        error_message = "Fail to create private EC2 instance"
    }
}
