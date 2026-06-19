## --- S3 Bucket ---
resource "aws_s3_bucket" "project_bucket" {

  bucket = "ashytcloud-fitness-project-bucket"

  tags = {
    Name = "FitnessProjectBucket"
  }
}


## --- Enable Versioning ---
resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.project_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

## --- Encryption ---
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {

  bucket = aws_s3_bucket.project_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
