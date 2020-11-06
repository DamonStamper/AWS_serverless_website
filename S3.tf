resource "aws_s3_bucket" "bucket" {
  bucket = "www.${var.Website_Domain_Name}"
  acl    = "public-read"
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"AddPerm",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::www.${var.Website_Domain_Name}/*"]
    }
  ]
}
POLICY

  website {
    index_document = "index.html"
    error_document = "error.html"

#     routing_rules = <<EOF
# [{
#     "Condition": {
#         "KeyPrefixEquals": "docs/"
#     },
#     "Redirect": {
#         "ReplaceKeyPrefixWith": "documents/"
#     }
# }]
# EOF
  }
}

output "S3_Website" {
    value = "${aws_s3_bucket.bucket.website_endpoint}"
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.bucket.bucket
  key    = "index.html"
  source = "./website/index.html"
  acl    = "public-read"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.bucket.bucket
  key    = "error.html"
  source = "./website/error.html"
  acl    = "public-read"
  content_type = "text/html"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "AllowReadFromAll"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::www.${var.Website_Domain_Name}/",
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}