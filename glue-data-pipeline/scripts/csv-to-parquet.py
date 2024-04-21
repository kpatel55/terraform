import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

csv_loc = "s3://YOUR_BUCKET_NAME/csv-files/tournaments-2023.csv"
parquet_loc = "s3://YOUR_BUCKET_NAME/parquet-files/"

# Get the CSV file from Amazon S3
get_csv_source = glueContext.create_dynamic_frame.from_options(format_options={"quoteChar": "\"", "withHeader": True, "separator": ","}, connection_type="s3", format="csv", connection_options={"paths": [csv_loc]})

# Dropped uneeded fields
csv_source_updated = get_csv_source.drop_fields(paths=["year_tournament", "day_tournament", "rotation_name", "year_begin", "day_begin"])

# Convert to Parquet and place in Amazon S3
convert_to_parquet = glueContext.write_dynamic_frame.from_options(frame=csv_source_updated, connection_type="s3", format="glueparquet", connection_options={"path": parquet_loc, "partitionKeys": []}, format_options={"compression": "snappy"})

job.commit()