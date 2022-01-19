FROM public.ecr.aws/lambda/python:3.9

COPY requirements.txt ${LAMBDA_TASK_ROOT}
RUN pip install -r requirements.txt

COPY send_contact_email.py ${LAMBDA_TASK_ROOT}

CMD ["send_contact_email.send_contact_email"]