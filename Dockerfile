FROM python:3
RUN apt-get update

RUN apt-get install -y openssh-server git-core libxml2-dev curl python build-essential make gcc python-dev wget libffi-dev libssl-dev
RUN apt-get install -y mysql-client
RUN apt-get install -y libmysqlclient-dev
RUN apt-get install -y libxml2-dev libxslt1-dev

RUN pip install sentry
RUN pip install sentry-slack
RUN pip install MySQL-python

EXPOSE 9000

ADD sentry.conf.py /sentry.conf.py
#ADD admin_user.json /initial_data.json

ENTRYPOINT ["/usr/local/bin/sentry", "--config=/sentry.conf.py"]

CMD ["start"]
