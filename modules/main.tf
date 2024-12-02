module "asr" {
    source = "../day-1"
    ami = "ami-07b2fe5d6ba52171e"
    type = "t2.micro"
    key = "awskey"
    
  
}