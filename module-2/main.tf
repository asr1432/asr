module "asr" {
    source = "../day-A"
    ami = "ami-0e577819b2a6cc996"
    instance_type = "t2.micro"
    key_name = "awskey"
  
}