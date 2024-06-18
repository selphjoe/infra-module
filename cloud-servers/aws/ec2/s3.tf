resource "aws_s3_bucket" "tf_state_bucket" {
  bucket  =var.tf_state_bucket_name
  tags    = {
	Name          = var.tf_state_bucket_tag_name
	Environment    = var.env
  }
}


resource "aws_s3_object" "tf_state_bucket_object" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  key    = var.tf_state_bucket_key
}