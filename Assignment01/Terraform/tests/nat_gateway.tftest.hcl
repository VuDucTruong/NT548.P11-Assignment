run "create_nat_gateway" {
    command = apply
    
    assert {
        condition = module.nat_gateway.nat_gateway_id != ""
        error_message = "Fail to create nat gateway"
    }
}