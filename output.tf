output "hostname" {
  value = "http://${aws_instance.ec2.public_ip}"
}