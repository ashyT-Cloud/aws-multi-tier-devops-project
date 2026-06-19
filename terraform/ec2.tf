data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

## --- Launch Template ---
resource "aws_launch_template" "app_lt" {

  name_prefix = "app-template"

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  user_data = base64encode(<<-EOF
#!/bin/bash
dnf update -y
dnf install -y docker
systemctl enable docker
systemctl start docker

docker pull ashytcloud/fitness-app:v2

docker run -d -p 3000:3000 ashytcloud/fitness-app:v2
EOF
  )

  tags = {
    Name = "AppLaunchTemplate"
  }
}

