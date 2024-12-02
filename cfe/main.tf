resource "aws_instance" "sandboxes" {
    ami = var.ami
    key_name = var.key
    instance_type = var.instance_type

    tags = {
        Name = "var.sandboxes[count.index]"
      
    }
}
