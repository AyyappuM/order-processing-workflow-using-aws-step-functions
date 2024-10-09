resource "aws_iam_role" "eventbridge_pipe_role" {
  name = "eventbridge-pipe-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "pipes.amazonaws.com"
        }
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = local.account_id
            "aws:SourceArn"     = "arn:aws:pipes:${local.region}:${local.account_id}:pipe/example"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "eventbridge_pipe_policy" {
  name = "eventbridge-pipe-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:DescribeStream",
          "dynamodb:GetRecords",
          "dynamodb:GetShardIterator",
          "dynamodb:ListStreams"
        ]
        Effect = "Allow"
        Resource = aws_dynamodb_table.orders_dynamodb_table.stream_arn
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = "arn:aws:logs:${local.region}:${local.account_id}:log-group:example-log-group:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eventbridge_pipe_role_attachment" {
  role       = aws_iam_role.eventbridge_pipe_role.name
  policy_arn = aws_iam_policy.eventbridge_pipe_policy.arn
}
