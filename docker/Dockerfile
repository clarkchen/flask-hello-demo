FROM python:3.6-slim

WORKDIR /app/src

ADD requirements /app/requirements

# 更新 pip 和 apt 源地址
COPY docker/pip.conf /etc/pip.conf
COPY docker/sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y libmariadb-dev gcc\
    && export PYCURL_SSL_LIBRARY=openssl \
    && pip3 install --no-cache-dir -r /app/requirements/base.txt
ADD src /app/src
RUN mkdir -p /app/src/logs