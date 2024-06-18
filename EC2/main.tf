provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "poc_ec_server" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.poc_server_security_group.id]    
    user_data = <<-EOF
                #!/bin/bash
                echo "Hola mundo! estoy expuesto desde aws server" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
    tags = {
      Name = "poc-app-1"
    }
}

resource "aws_security_group" "poc_server_security_group" {
    name = "poc-server-sg"
    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Acceso al puerto 8080 desde el exterior"
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
    }
}