terraform {
  backend "s3" {
    bucket = "statebucket128"
    key    = "terrraform.tfstate"
    region = "us-east-1"
  }
}
