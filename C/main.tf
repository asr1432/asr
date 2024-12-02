resource "aws_instance" "example" {
  count = 0
  ami           = "ami-0e577819b2a6cc996"
  instance_type = "t2.micro"

}
