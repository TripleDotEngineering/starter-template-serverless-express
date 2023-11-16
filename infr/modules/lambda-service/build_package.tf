/**
 * Creates the zip archive of the lambda function.
 */

data "archive_file" "package_archive" {
  type        = "zip"
  source_dir  = "${path.module}/../../../dist"
  output_path = "${path.module}/../../../dist-lambda-service.zip"
}

resource "aws_s3_object" "deployment_package" {
  bucket  = var.deploy_packages_bucket
  key     = "lambda-dist.zip"
  source  = data.archive_file.package_archive.output_path
  etag    = filemd5(data.archive_file.package_archive.output_path)
}
