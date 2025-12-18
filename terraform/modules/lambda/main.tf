resource "aws_lambda_function" "stop_ec2" {
  function_name = "stop-dev-ec2"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  handler       = "stop_ec2.lambda_handler"
  filename      = "${path.module}/lambda/stop_ec2.zip"
}

resource "aws_lambda_function" "cleanup_snapshots" {
  function_name = "cleanup-old-snapshots"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  handler       = "cleanup_snapshots.lambda_handler"
  filename      = "${path.module}/lambda/cleanup_snapshots.zip"
}
resource "aws_cloudwatch_event_rule" "night_shutdown" {
  name                = "night-ec2-shutdown"
  schedule_expression = "cron(0 22 * * ? *)" # 10 PM IST
}

resource "aws_cloudwatch_event_target" "stop_ec2_target" {  
  rule      = aws_cloudwatch_event_rule.night_shutdown.name
  target_id = "stop-ec2"
  arn       = aws_lambda_function.stop_ec2.arn
}

resource "aws_lambda_permission" "allow_event" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_ec2.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.night_shutdown.arn
}


#IMPORTANT
#You must zip Python files:

#cd terraform/modules/lambda/lambda
#zip stop_ec2.zip stop_ec2.py
#zip cleanup_snapshots.zip cleanup_snapshots.py
