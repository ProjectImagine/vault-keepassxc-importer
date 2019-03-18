FROM alpine:3.9

#VOLUME kv.csv /root/kv.csv

RUN apk add --no-cache python3 && \
    cd /root \
    python3 setup.py install

CMD vault_import --csv /root/kv.csv --base kv --url $VAULT_ADDR --token $TOKEN \
    echo "Exit code $?"
