provider "aws" {

}

resource "aws_instance" "my_webserver1" {
  ami = "ami-0f19d220602031aed" //amazon lin ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  tags = {
      Name = "WEb Server Security Group"
      Owner = "dmitriy_smolskiy"
  }

    depends_on = [
    aws_instance.my_server_db,aws_instance.my_server_app,
  ]
}


resource "aws_instance" "my_server_app" {
  ami = "ami-0f19d220602031aed" //amazon lin ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  tags = {
      Name = "Application"
      Owner = "dmitriy_smolskiy"
  }

  depends_on = [
    aws_instance.my_server_db, 
  ]
}

resource "aws_instance" "my_server_db" {
  ami = "ami-0f19d220602031aed" //amazon lin ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  tags = {
      Name = "DataBase"
      Owner = "dmitriy_smolskiy"
  }

  depends_on = [
    
  ]
}

resource "aws_security_group" "my_webserver1" {
  name        = "DynamicSecurityGroup"
  description = "My First Security Group"

  dynamic "ingress" {
    for_each = ["80","443","8080","1541","9092", "22"]
    content {
      description      = "VPC for webserver port 80"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  }


  egress = [
    {
      description      = "TLS from VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  tags = {
    Name = "DynamicSecurityGroup"
    Owner = "dmitriy_smolskiy"
  }
}