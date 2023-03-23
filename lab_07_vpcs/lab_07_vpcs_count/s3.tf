resource "aws_s3_bucket" "test-bucket" {
  bucket = "test-bucket-jal"

  tags = {
    Name        = "test-bucket-jal"
    Environment = "Dev"
  }
}
