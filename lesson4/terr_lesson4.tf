provider "aws" {

}

resource "aws_instance" "my_webserver" {
  ami = "ami-0f19d220602031aed" //amazon lin ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver1.id]
  user_data = templatefile("user_data.tpl", {
    f_name = "Dmitriy",
    l_name = "Smolskiy",
    names1 = ["Vasya", "Kolya", "John", "Masha"]
  })

    tags = {
        Name = "WEb Server Security Group"
        Owner = "dmitriy_smolskiy"
    }
}
resource "aws_security_group" "my_webserver1" {
  name        = "WebServer Security Group"
  description = "My First Security Group"

  ingress = [
    {
      description      = "VPC for webserver port 80"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }

  ]


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
    Name = "WEb Server Security Group"
    Owner = "dmitriy_smolskiy"
  }
}