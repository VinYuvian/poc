terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "vin1711-s3-backend"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-1"
    access_key     = $access_key
    secret_key     = $secret_key
    # Replace this with your DynamoDB table name!
    dynamodb_table = "s3-backend-lock"
    encrypt        = true
    #profile = "kubernetes"
  }
}
