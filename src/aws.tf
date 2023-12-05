# S3 Bucket for Actions data
resource "aws_s3_bucket" "this" {
  bucket = random_string.unique_name.result
}
