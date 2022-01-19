import json
import os

import boto3


EMAIL = os.environ["EMAIL_ADDRESS"]
REGION = os.environ["AWS_REGION"]


def send_contact_email(event, context):
    body_text = (
        "Test from yourself\n"
        "If this works the first time, you deserve an extra beer."
    )
    body_html = """
    <html>
      <head></head>
      <body>
        <h1>Test from yourself</h1>
        <p>If this works the first time, you deserve an extra beer.</p>
      </body>
    </html>
    """
    client = boto3.client("ses", region_name=REGION)
    response = client.send_email(
        Destination={
            "ToAddresses": [
                EMAIL,
            ],
        },
        Message={
            "Body": {
                "Html": {
                    "Charset": "UTF-8",
                    "Data": body_html,
                },
                "Text": {
                    "Charset": "UTF-8",
                    "Data": body_text,
                },
            },
            "Subject": {
                "Charset": "UTF-8",
                "Data": "Test email from yourself",
            },
        },
        Source=EMAIL,
    )
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Yay!",
            "ResponseMetadata": response.get("ResponseMetadata")
        }),
    }
