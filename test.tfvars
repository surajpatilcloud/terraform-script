practice = {
  vpc_name              = "krishna"
  vpc_cidr              = "10.0.0.0/16"
  subnet_name           = ["subnet1", "subnet2", "subnet3"]
  subnet_cidr           = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_az             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  internet_gateway_name = "sun-igw"
  route_table_name      = "sun-rt"
  route_table_cidr      = "0.0.0.0/0"
  security_group_name   = "sun-sg"
  security_group_ingress_rules = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  security_group_egress_rules = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ec2_instance_name = "sun-ec2"
  ami               = "ami-0c7632fb77f35db43"
  instance_type     = "t3.micro"
  key_name          = "sun"
  root_volume_size  = 8
  root_volume_type  = "gp3"
  #key_pair_path     = "C:/Users/suraj/Downloads/sun.pem"
}