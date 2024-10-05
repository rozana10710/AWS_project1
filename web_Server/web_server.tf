resource "aws_security_group" "web_sg" {
  vpc_id ="vpc-0199b25f378d48ce8"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH only from your IP (for testing I'll allow all)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami                         = "ami-097c5c21a18dc59ea"  # Amazon Linux 2 AMI
  instance_type               = "t3.micro"
  subnet_id                   = "subnet-0f8372851f216c6e2"
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  key_name                    = "my_first_key"
  associate_public_ip_address = true

  tags = {
    Name = "WebServer"
  }

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "Welcome to My Web Server!" > /var/www/html/index.html
              EOF
}
