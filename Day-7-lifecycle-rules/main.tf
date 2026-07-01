resource "aws_instance" "name" {
    ami           = "ami-06067086cf86c58e6"
    instance_type = "t3.micro"
    
    tags = {
        Name = "test"
    }
  

  lifecycle {
    create_before_destroy = true
}
#  lifecycle {
#     ignore_changes = [ tags, ]
# }
# lifecycle {
#   prevent_destroy = true
# }
}

