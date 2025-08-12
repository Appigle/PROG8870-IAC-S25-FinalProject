# S3 Buckets
resource "aws_s3_bucket" "ray_buckets" {
  count  = 4
  bucket = "${var.ray_project_name}-bucket-${count.index + 1}-${var.ray_environment}"
}

resource "aws_s3_bucket_versioning" "ray_bucket_versioning" {
  count  = 4
  bucket = aws_s3_bucket.ray_buckets[count.index].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "ray_bucket_public_access_block" {
  count  = 4
  bucket = aws_s3_bucket.ray_buckets[count.index].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
} 