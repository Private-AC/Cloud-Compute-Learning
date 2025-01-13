# In the Project we have kept all the files seperately so that the code can be reused.
# This block is to generate a random id of 8 byte hexadecimal to generate a unique bucket name.

resource "random_id" "random_bucket_name" {
  byte_length = 8
}

# Creating Bucket

resource "aws_s3_bucket" "static-website" {
    bucket = "my-s3-static-website-${random_id.random_bucket_name.hex}"
}

# Bucket access on public ip 

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.static-website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket Policy to allow website access 

resource "aws_s3_bucket_policy" "webaccess" {
  bucket = aws_s3_bucket.static-website.id
  policy = jsonencode(
    {
    Version =  "2012-10-17",
    Statement = [
        {
            Sid =  "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action = "s3:GetObject",
            Resource = "arn:aws:s3:::${aws_s3_bucket.static-website.id}/*"
        }
    ]
}
  )
}

# To enable routing to be visible on public internet

resource "aws_s3_bucket_website_configuration" "webapp" {
  bucket = aws_s3_bucket.static-website.id

  index_document {
    suffix = "index.html"
  }
}

# uploading files 

resource "aws_s3_object" "index-html" {
    bucket = aws_s3_bucket.static-website.bucket
    source = "./index.html"
    key = "index.html" 
    content_type = "text/html"  # by default if this line is not added it will download the file
}

resource "aws_s3_object" "styles-css" {
    bucket = aws_s3_bucket.static-website.bucket
    source = "./styles.css"
    key = "styles.css" 
    content_type = "text/css"  # by default if this line is not added it will download the file
}

# Output of the final url to verify without going to S3

output "name" {
  value = aws_s3_bucket_website_configuration.webapp.website_endpoint
}