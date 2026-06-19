output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet1" {
  value = aws_subnet.public_az1.id
}

output "public_subnet_2" {
  value = aws_subnet.public_az2.id
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}
