import json


def send_contact_email(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps("Yay!"),
    }
