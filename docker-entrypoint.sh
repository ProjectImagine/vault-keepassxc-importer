#!/bin/bash
#set -e

if [ -f ./tmp/kv.csv ] 
then
    echo "File exists locally"
    if [ -s ./tmp/kv.csv ]
    then
       echo "Skipping downloading kv file from S3"
    else
        
        echo "Downloading kv file from S3"
        aws s3api get-object --bucket $VAULT_DATA_BUCKET --key $VAULT_DATA_FILE /tmp/kv.csv
    fi
else
    echo "File doesn't exist locally"
    echo "Downloading kv file from S3"
    aws s3api get-object --bucket $VAULT_DATA_BUCKET --key $VAULT_DATA_FILE /tmp/kv.csv
fi
exec "$@"