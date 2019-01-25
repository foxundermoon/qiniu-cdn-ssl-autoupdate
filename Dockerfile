FROM python:3.5.6-alpine3.8
WORKDIR /app

USER root
ENV RELEASE_URL=https://github.com/qiniu/python-sdk/archive
ENV MASTER=https://github.com/qiniu/python-sdk/archive/master.zip
ENV SDK_VERSION=7.2.2
#install acme.sh
# pip install qiniu   failed

RUN apk add --no-cache  socat openssl  && \
    wget -O -  https://get.acme.sh | sh && \
    wget -qO-  -O qiniu.zip  "${MASTER}"  && \
    unzip qiniu.zip  && \
    rm -f qiniu.zip && \
    cd python-sdk-master && \
    python setup.py install && \
    cd .. && \
    rm -rf python-sdk-master

COPY . /app

VOLUME [ "/ssl" ]

CMD ["sh", "startup.sh"]
