resource "aws_dynamodb_table" "orders_dynamodb_table" {
	name = "Orders"
	hash_key = "order_id"
	billing_mode = "PAY_PER_REQUEST"

	attribute {
		name = "order_id"
		type = "N"
	}

	stream_enabled   = true
  	stream_view_type = "NEW_IMAGE"

	tags = {
		Name = "OrdersTable"
	}
}
