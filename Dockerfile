FROM python:3.5.6
WORKDIR /app

USER root
ENV RELEASE_URL=https://github.com/qiniu/python-sdk/archive
ENV MASTER=https://github.com/qiniu/python-sdk/archive/master.zip
ENV SDK_VERSION=7.2.2
#install acme.sh
# pip install qiniu   failed

RUN apt-get -y update && \
    apt-get install -y cron socat && \
    wget -O -  https://get.acme.sh | sh && \
    wget -qO-  -O qiniu.zip  "${RELEASE_URL}/v${SDK_VERSION}.zip"  && \
    unzip qiniu.zip  && \
    rm -f qiniu.zip && \
    cd "python-sdk-${SDK_VERSION}" && \
    python setup.py install 

COPY . /app

CMD ["bash","startup.sh"]
