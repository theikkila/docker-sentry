FROM dockerfile/python
RUN apt-get update
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get install -y openssh-server git-core libxml2-dev curl python build-essential make gcc python-dev wget libffi-dev
RUN apt-get install -y mysql-client
RUN apt-get install -y libmysqlclient-dev

RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py 
RUN python get-pip.py

RUN pip install sentry
RUN pip install sentry-slack
RUN pip install MySQL-python

EXPOSE 9000

ADD sentry.conf.py /sentry.conf.py
ADD admin_user.json /initial_data.json

ENTRYPOINT ["/usr/local/bin/sentry", "--config=/sentry.conf.py"]

CMD ["start"]
