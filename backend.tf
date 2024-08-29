terraform {
  backend "s3"{
    bucket                 = "my-tfstate-bucket-d"
    region                 = "us-east-1"
    key                    = "terraform.tfstate"
    dynamodb_table         = "my-tfstate-lock-table"
  }
}