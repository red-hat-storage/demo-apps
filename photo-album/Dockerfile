FROM registry.redhat.io/ubi8/python-38

ADD ./app/requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt

COPY . /

ENV BUCKET_NAME "$BUCKET_NAME"
ENV ENDPOINT_URL "$ENDPOINT_URL"
ENV AWS_ACCESS_KEY_ID "$AWS_ACCESS_KEY_ID"
ENV AWS_SECRET_ACCESS_KEY "$AWS_SECRET_ACCESS_KEY"

EXPOSE 8081

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]

