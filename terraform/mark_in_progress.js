const AWS = require('aws-sdk');
const dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
	const orderId = event.order_id; // assuming the order_id is passed in the event
	const params = {
		TableName: process.env.DYNAMODB_TABLE,
		Key: { order_id: orderId },
		UpdateExpression: "set order_status = :status",
		ExpressionAttributeValue = {
			":status": "in progress"
		}
	};

	try {
		await dynamodb.update(params).promise();
		console.log(`Order ${orderId} marked as in progress`);
		return {
			status: 'SUCCESS',
			message: `Order ${orderId} is now in progress`
		}
	} catch (error) {
		console.error(error);
		return {
			status: 'ERROR',
			message: `Failed to mark order ${orderId} as in progress`
		}
	}
}
