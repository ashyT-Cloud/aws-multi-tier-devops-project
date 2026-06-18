## --- ALB Security Group ---
resource "aws_security_group" "alb_sg" {

  name   = "alb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## --- Application Security Group ---
resource "aws_security_group" "app_sg" {

  name   = "app-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## --- Database Security Group ---
resource "aws_security_group" "rds_sg" {

  name   = "rds-sg"
  vpc_id = aws_vpc.main.id

  ingress {

    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    security_groups = [
      aws_security_group.app_sg.id
    ]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
