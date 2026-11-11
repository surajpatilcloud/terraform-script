resource "aws_vpc" "practice" {
  cidr_block = var.practice.vpc_cidr
  tags = {
    Name = var.practice.vpc_name
  }
}
resource "aws_subnet" "subnet" {
  count             = length(var.practice.subnet_name)
  vpc_id            = aws_vpc.practice.id
  cidr_block        = var.practice.subnet_cidr[count.index]
  availability_zone = var.practice.subnet_az[count.index]
  tags = {
    Name = var.practice.subnet_name[count.index]
  }
  depends_on = [aws_vpc.practice]
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.practice.id
  tags = {
    Name = var.practice.internet_gateway_name
  }
  depends_on = [aws_subnet.subnet]
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.practice.id
  route {
    cidr_block = var.practice.route_table_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.practice.route_table_name
  }
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_route_table_association" "rta" {
  count          = length(var.practice.subnet_name)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.rt.id
  depends_on     = [aws_route_table.rt]
}
resource "aws_security_group" "sg" {
  name        = var.practice.security_group_name
  description = "Security group for ${var.practice.vpc_name}"
  vpc_id      = aws_vpc.practice.id

  ingress {
    from_port   = var.practice.security_group_ingress_rules.from_port
    to_port     = var.practice.security_group_ingress_rules.to_port
    protocol    = var.practice.security_group_ingress_rules.protocol
    cidr_blocks = var.practice.security_group_ingress_rules.cidr_blocks
  }
  egress {
    from_port   = var.practice.security_group_egress_rules.from_port
    to_port     = var.practice.security_group_egress_rules.to_port
    protocol    = var.practice.security_group_egress_rules.protocol
    cidr_blocks = var.practice.security_group_egress_rules.cidr_blocks
  }

  tags = {
    Name = var.practice.security_group_name
  }
}
resource "aws_instance" "ec2" {
  ami                         = var.practice.ami
  instance_type               = var.practice.instance_type
  key_name                    = var.practice.key_name
  subnet_id                   = aws_subnet.subnet[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  depends_on                  = [aws_route_table_association.rta]

  root_block_device {
    volume_size = var.practice.root_volume_size
    volume_type = var.practice.root_volume_type
  }
  tags = {
    Name = var.practice.ec2_instance_name
  }
}
resource "null_resource" "provisioner" {
  triggers = {
    build_id = 1.2
  }
  connection {
    type        = "ssh"
    host        = aws_instance.ec2.public_ip
    user        = "ubuntu"
    private_key = file("C:/Users/suraj/Downloads/sun.pem")
    timeout     = "2m"
  }
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
}