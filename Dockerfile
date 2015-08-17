FROM python:2.7
RUN apt-get update

RUN pip install -U wheel pip setuptools

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q libxslt1-dev libxml2-dev libpq-dev expect libsasl2-dev libssl-dev

RUN apt-get install -y mysql-client
RUN apt-get install -y libmysqlclient-dev
RUN apt-get install -y wget
RUN apt-get install -y supervisor


RUN pip install sentry
RUN pip install sentry-slack
RUN pip install MySQL-python

EXPOSE 9000

ADD sentry.conf.py /sentry.conf.py
ADD supervisor-app.conf /etc/supervisor/conf.d/supervisor-app.conf
RUN useradd sentry
#ADD admin_user.json /initial_data.json

CMD ["supervisord", "-n"]
