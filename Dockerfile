FROM alpine:3.9

ADD . /root/app

WORKDIR /root/app

RUN apk update

# Install base and dev packages
RUN apk add --no-cache --virtual .build-deps
RUN apk add bash

# Install build packages
RUN apk add make && apk add curl && apk add openssh

# Install git
RUN apk add git

# Install nodejs
RUN apk add nodejs

# Install yarn
RUN apk add yarn

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Install aws-cli
RUN apk -Uuv add groff less python py-pip
RUN pip install awscli
RUN apk --purge -v del py-pip
RUN rm /var/cache/apk/*

RUN apk add --no-cache python3 && \
    cd /root/app && \
    python3 setup.py install


CMD aws s3api get-object --bucket $VAULT_DATA_BUCKET --key $VAULT_DATA_FILE /tmp/kv.csv && vault_import --csv /tmp/kv.csv --base kv --url $VAULT_ADDR --token $TOKEN && \
    echo "Exit code $?"
