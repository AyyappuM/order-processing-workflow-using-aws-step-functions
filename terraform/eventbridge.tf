resource "aws_pipes_pipe" "example" {
  name = "example"
  role_arn = aws_iam_role.eventbridge_pipe_role.arn

  source = aws_dynamodb_table.orders_dynamodb_table.stream_arn

  source_parameters {
    dynamodb_stream_parameters {
      batch_size = 1
      maximum_record_age_in_seconds = -1
      maximum_retry_attempts = -1
      starting_position = "LATEST"
    }
  }

  target = aws_cloudwatch_log_group.example.arn

  target_parameters {
    cloudwatch_logs_parameters {
      log_stream_name = "example-log-stream"
    }
  }
}