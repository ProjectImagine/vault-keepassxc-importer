#!/bin/bash
#set -e

if [ -f /tmp/kv.csv ] 
then
    if [ -s /tmp/kv.csv ] 
    then
        echo "Downloading kv file from S3"
        aws s3api get-object --bucket $VAULT_DATA_BUCKET --key $VAULT_DATA_FILE /tmp/kv.csv
    else
        echo "Skipping downloading kv file from S3"
    fi
else
    echo "Downloading kv file from S3"
    aws s3api get-object --bucket $VAULT_DATA_BUCKET --key $VAULT_DATA_FILE /tmp/kv.csv
fi
exec "$@"