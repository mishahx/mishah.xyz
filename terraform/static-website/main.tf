resource "aws_s3_bucket" "static_website_bucket" {
  bucket = var.bucket_name
  tags = var.tags
}

resource "aws_s3_bucket_ownership_controls" "static_website_ownership" {
  bucket = aws_s3_bucket.static_website_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "static_website_public_access_block" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "static_website_acl" {
  bucket = aws_s3_bucket.static_website_bucket.id
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_ownership_controls.static_website_ownership,
    aws_s3_bucket_public_access_block.static_website_public_access_block,
  ]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "static_website_sse" {
  bucket = aws_s3_bucket.static_website_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "static_website_cors" {
  bucket = aws_s3_bucket.static_website_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = [
      "http://${var.bucket_name}",
      "https://${var.bucket_name}"
    ]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_website_bucket.id

  index_document {
    suffix = var.index_page
  }

  error_document {
    key = var.error_page
  }
}


resource "null_resource" "upload_directory" {
  provisioner "local-exec" {
    command = "aws s3 sync $SOURCE_DIR s3://$WEBSITE_BUCKET --region $BUCKET_REGION --acl public-read"

    environment = {
      SOURCE_DIR     = "website/${var.website_dir}"
      WEBSITE_BUCKET = var.bucket_name
      BUCKET_REGION  = aws_s3_bucket.static_website_bucket.region
    }
  }

  triggers = {
    datetime = timestamp()
  }

  depends_on = [
    aws_s3_bucket.static_website_bucket,
    aws_s3_bucket_acl.static_website_acl,
    aws_s3_bucket_cors_configuration.static_website_cors,
    aws_s3_bucket_server_side_encryption_configuration.static_website_sse,
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_ownership_controls.static_website_ownership,
    aws_s3_bucket_public_access_block.static_website_public_access_block
  ]
}