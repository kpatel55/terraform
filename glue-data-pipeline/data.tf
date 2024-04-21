module "bucket_module" {
  source = "./s3"
}

data "aws_iam_policy_document" "glue_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_inline_policy" {
  statement {
    actions   = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
      "s3:GetBucketAcl"
    ]
    resources = [
      "arn:aws:s3:::${module.bucket_module.s3_out["bucket"]}",
      "arn:aws:s3:::${module.bucket_module.s3_out["bucket"]}/*",
      "arn:aws:s3:::${module.bucket_module.s3_out["script-location"]}"
    ]
  }
}
