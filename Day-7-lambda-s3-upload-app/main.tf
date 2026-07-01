# ==========================
# IAM ROLE
# ==========================

resource "aws_iam_role" "lambda_role_1" {

  name = "lambda_execution_role-1"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = "sts:AssumeRole"

        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# ==========================
# ATTACH POLICY
# ==========================

resource "aws_iam_role_policy_attachment" "lambda_policy_1" {

  role = aws_iam_role.lambda_role_1.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

# ==========================
# S3 BUCKET
# ==========================

resource "aws_s3_bucket" "lambda_bucket_1" {

  bucket = "sai-lambda-code-bucket-123456-1"

}

# ==========================
# UPLOAD ZIP TO S3
# ==========================

resource "aws_s3_object" "lambda_zip_1" {

  bucket = aws_s3_bucket.lambda_bucket_1.id

  key = "lambda_function.zip"

  source = "lambda_function.zip"

  etag = filemd5("lambda_function.zip")

}

# ==========================
# CREATE LAMBDA
# ==========================

resource "aws_lambda_function" "my_lambda_1" {

  function_name = "my_lambda_function-1"

  role = aws_iam_role.lambda_role_1.arn


  # KEEP THIS SAME
  handler = "lambda_function.lambda_handler"

  runtime = "python3.12"

  timeout = 900

  memory_size = 128


  s3_bucket = aws_s3_bucket.lambda_bucket_1.id

  s3_key = aws_s3_object.lambda_zip_1.key


  source_code_hash = filebase64sha256("lambda_function.zip")


  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy_1,
    aws_s3_object.lambda_zip_1
  ]
}