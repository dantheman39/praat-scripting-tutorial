FROM public.ecr.aws/lambda/python:3.9

COPY send_contact_email.py ${LAMBDA_TASK_ROOT}

CMD ["send_contact_email.send_contact_email"]