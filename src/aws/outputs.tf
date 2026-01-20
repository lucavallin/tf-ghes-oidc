output "aws_s3_bucket" {
  value = aws_s3_bucket.this.bucket
}
output "aws_role" {
  value = aws_iam_role.this.arn
}
output "aws_region" {
  value = data.aws_region.this.name
}
output "aws_sts_endpoint" {
  value = local.aws_sts_endpoint
}
