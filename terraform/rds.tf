resource "aws_db_subnet_group" "db_subnet_group" {

  name = "db-subnet-group"

  subnet_ids = [
    aws_subnet.private_az1.id,
    aws_subnet.private_az2.id
  ]

  tags = {
    Name = "DBSubnetGroup"
  }
}

## --- RDS Instance ---
resource "aws_db_instance" "mysql" {

  identifier = "fitness-db"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name = "fitnessdb"

  username = "admin"
  password = "ChangeMe123!"

  multi_az = true

  publicly_accessible = false

  skip_final_snapshot = true

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}
