locals {
    directory_names = toset([
        "csv-files",
        "parquet-files"
    ])
    file_names = toset([
        "tournaments-2023.csv"
    ])
}

resource "aws_s3_bucket" "glue_source_bucket" {
    bucket = var.glue_source_bucket_name
}

resource "aws_s3_bucket" "glue_scripts_bucket" {
    bucket = var.glue_scripts_bucket_name
}

resource "aws_s3_bucket" "athena_query_bucket" {
    bucket = var.athena_query_bucket_name
}

resource "aws_s3_object" "directories" {
    for_each = local.directory_names
    bucket   = aws_s3_bucket.glue_source_bucket.bucket
    key      = "${each.key}/"
}

resource "aws_s3_object" "spark_script" {
    bucket   = aws_s3_bucket.glue_scripts_bucket.bucket
    key      = "csv-to-parquet.py"
    source   = var.spark_script_path
}

resource "aws_s3_object" "csv_files" {
    for_each = local.file_names
    bucket   = aws_s3_bucket.glue_source_bucket.bucket
    key      = "csv-files/${each.key}"
    source   = var.csv_files_path
}

output "s3_out" {
    value = {
        "bucket": aws_s3_bucket.glue_source_bucket.bucket,
        "script-location": "${aws_s3_object.spark_script.bucket}/${aws_s3_object.spark_script.key}",
        "directories": local.directory_names
    }
}