resource "aws_cloudwatch_log_group" "example" {
  name = "example-log-group"
}

resource "aws_cloudwatch_log_stream" "example" {
  name           = "example-log-stream"
  log_group_name = aws_cloudwatch_log_group.example.name
}
