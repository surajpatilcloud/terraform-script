variable "practice" {
  type = object({
    vpc_name              = string
    vpc_cidr              = string
    subnet_name           = list(string)
    subnet_cidr           = list(string)
    subnet_az             = list(string)
    internet_gateway_name = string
    route_table_name      = string
    route_table_cidr      = string
    security_group_name   = string
    security_group_ingress_rules = object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })
    security_group_egress_rules = object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    })
    ec2_instance_name = string
    ami               = string
    instance_type     = string
    key_name          = string
    root_volume_size  = number
    root_volume_type  = string
  })
}