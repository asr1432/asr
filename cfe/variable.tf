variable "ami" {
    description = "inserting ami value"
    type = string
    default = "ami-1215dhjbhbdf"
  
}
variable "instance_type" {
    description = "inserting value for instance type"
    type = string
    default = "t2.micro"

}
variable "key" {
    description = "inserting value for key"
    type = string
    default = "awskey"
}
variable "sandboxes" {
    type = list(string)
    default = [ "one","two" ]
  
}