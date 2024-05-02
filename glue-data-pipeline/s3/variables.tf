variable "glue_source_bucket_name" {
  description = "S3 Bucket name for the data"
}

variable "glue_scripts_bucket_name" {
  description = "S3 Bucket name for the PySpark ETL script"
}

variable "athena_query_bucket_name" {
  description = "S3 Bucket Name for the Athena queries"
}

variable "spark_script_path" {
  description = "Path to the PySpark ETL script"
}

variable "csv_files_path" {
  description = "Path to the csv file containing raw data"
}