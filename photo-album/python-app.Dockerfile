FROM registry.redhat.io/ubi8/python-38

ADD ./src/requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
