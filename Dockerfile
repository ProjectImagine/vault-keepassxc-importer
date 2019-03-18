FROM alpine:3.9

ADD . /root/app

WORKDIR /root/app

RUN apk add --no-cache python3 && \
    cd /root/app && \
    python3 setup.py install

CMD vault_import --csv /tmp/kv.csv --base kv --url $VAULT_ADDR --token $TOKEN && \
    echo "Exit code $?"
