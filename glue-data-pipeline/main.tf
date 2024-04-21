provider "aws" {
  region = "us-east-1"
}

module "policy_module" {
  source = "./iam"
}

resource "aws_glue_catalog_database" "glue_database" {
  name = "s3-datasets"
}

resource "aws_iam_role" "glue_crawler_role" {
  name                = "glue-crawler-role"
  assume_role_policy  = data.aws_iam_policy_document.glue_assume_role_policy.json
  managed_policy_arns = module.policy_module.policy_out

  inline_policy {
    name   = "s3-inline-policy"
    policy = data.aws_iam_policy_document.s3_inline_policy.json
  }
}

resource "aws_glue_crawler" "glue_crawlers" {
  for_each      = module.bucket_module.s3_out["directories"]
  database_name = aws_glue_catalog_database.glue_database.name
  name          = "${each.key}-crawler"
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${module.bucket_module.s3_out["bucket"]}/${each.key}/"
  }
}

resource "aws_glue_job" "csv_to_parquet_job" {
  name     = "csv-to-parquet-job"
  role_arn = aws_iam_role.glue_crawler_role.arn
  worker_type = "G.1X"
  number_of_workers = "10"
  
  command {
    python_version = 3
    script_location = "s3://${module.bucket_module.s3_out["script-location"]}"
  }
}

output "glue_pipeline_out" {
  value = {
    "job": aws_glue_job.csv_to_parquet_job.arn,
    "crawlers": [
      for v in aws_glue_crawler.glue_crawlers :
      v.arn
    ]
  }
}