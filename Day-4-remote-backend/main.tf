resource "aws_vpc" "Name" {
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "sai-vpc"
    }
}