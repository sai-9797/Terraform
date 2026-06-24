resource "aws_instance" "name" {
    ami = "ami-08f44e8eca9095668" 
    instance_type = "t3.micro"
  
  tags = {
    Name = "sai"
  }

}