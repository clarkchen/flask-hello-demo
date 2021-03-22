FROM python:3.8.5

WORKDIR /app/src
COPY requirements /app/requirements

# 是否是中文环境
ARG ENV_LANG
# 是否是flask测试环境
ARG COMPOSE_MODE

# 更新 pip 和 apt 源地址
COPY docker/pip.conf /etc/pip.conf_cn
COPY docker/sources.list /etc/apt/sources.list_cn

RUN if [ "$ENV_LANG" = "CN" ] ; \
    then mv /etc/pip.conf_cn /etc/pip.conf;\
    mv /etc/apt/sources.list_cn /etc/apt/sources.list;\
    else echo 'not hit'; \
    fi
RUN apt-get update

RUN apt-get install -y libmariadb-dev gcc\
    && export PYCURL_SSL_LIBRARY=openssl 
    # && pip3 install --no-cache-dir -r /app/requirements/base.txt


RUN if [ "$COMPOSE_MODE" = "DEBUG" ] ; \
    then \
        pip3 install --no-cache-dir -r /app/requirements/base.txt ;\
    else \
        pip3 install --no-cache-dir -r /app/requirements/prod.txt ; \
    fi

RUN echo $FLASK_RUN_PORT

COPY src /app/src

COPY etc /app/src/etc

CMD ["flask", "run", "-h","0.0.0.0"]
# CMD [ "/bin/bash"]