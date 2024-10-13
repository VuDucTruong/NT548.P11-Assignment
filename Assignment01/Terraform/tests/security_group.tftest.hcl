run "create_public_security_group" {
    command = apply
    
    assert {
        condition = module.security_group.public_ec2_sg_id != ""
        error_message = "Fail to create public security group"
    }
}
run "create_private_security_group" {
    command = apply
    
    assert {
        condition = module.security_group.private_ec2_sg_id != ""
        error_message = "Fail to create private security group"
    }
}