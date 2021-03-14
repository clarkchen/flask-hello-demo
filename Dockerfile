FROM python:3.8.5

WORKDIR /app/src
COPY requirements /app/requirements

# 更新 pip 和 apt 源地址
COPY docker/pip.conf /etc/pip.conf
COPY docker/sources.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y libmariadb-dev gcc\
    && export PYCURL_SSL_LIBRARY=openssl \
    && pip3 install --no-cache-dir -r /app/requirements/base.txt

RUN if [ "$FLASK_ENV" = "development" ] ; \
    then  pip3 install --no-cache-dir -r /app/requirements/base.txt ;\
    else pip3 install --no-cache-dir -r /app/requirements/prod.txt ; \
    fi

COPY src /app/src

CMD ["flask", "run", "-h","0.0.0.0"]