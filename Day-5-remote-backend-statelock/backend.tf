terraform {
  backend "s3" {
    bucket = "statebucket128"
    key    = "terrraform.tfstate"
    dynamodb_table = "sai"
    encrypt = true
    #use_lockfile = true    #s3 native lacking process to prevent current state midifications
    region = "us-east-1"
  }
}
