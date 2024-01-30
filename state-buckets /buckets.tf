#Do not rely on state file for the files in this folder
# Treat these resources as being created manually and state not being managed in terraform
# alternatively, you can just create bucket manually in aws console with desired settings
resource "aws_s3_bucket" "statebucket" {
  bucket = "project-phoenix-state-bucket-dev"

  tags = {
    Name        = "Terraform State bucker for Project Phoenix"
    Environment = "Dev"
  }
  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name         = "terraformlock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-lock-table"
    Environment = "dev"
  }
}
