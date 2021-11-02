resource "aws_instance" "my_ubuntu" {
  count = 3
  ami = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
}

resource "aws_instance" "amazon_ubuntu" {
  ami = "ami-0f19d220602031aed"
  instance_type = "t2.micro"
}