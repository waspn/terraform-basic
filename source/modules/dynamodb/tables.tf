resource "aws_dynamodb_table" "example_table" {
  name           = "my-example-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }
}