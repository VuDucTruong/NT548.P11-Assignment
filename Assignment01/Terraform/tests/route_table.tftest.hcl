run "create_public_route_table" {
    command = apply
    
    assert {
        condition = module.route_table.public_route_table_id != ""
        error_message = "Fail to create public route table"
    }
}
run "create_private_route_table" {
    command = apply
    
    assert {
        condition = module.route_table.private_route_table_id != ""
        error_message = "Fail to create private route table"
    }
}
run "associate_with_public_rt" {
    command = apply
    
    assert {
        condition = module.route_table.public_rt_assocication_id != ""
        error_message = "Fail to associate with public route table"
    }
}
run "associate_with_private_rt" {
    command = apply
    
    assert {
        condition = module.route_table.private_rt_assocication_id != ""
        error_message = "Fail to associate with private route table"
    }
}