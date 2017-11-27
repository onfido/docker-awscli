#!/bin/sh

# Assume Role if define as ENV_VAR
if [ ! -z "$AWS_ASSUME_ROLE" ] && [ ! -z "$AWS_ROLE_SESSION_NAME" ]; then
  AWS_CREDENTIAL_FILE=$(mktemp)
  aws sts assume-role \
    --role-arn $AWS_ASSUME_ROLE \
    --role-session-name $AWS_ROLE_SESSION_NAME \
  | grep -E 'AccessKeyId|SecretAccessKey|SessionToken' \
  | awk  '{print $2}' \
  | sed  's/"//g;s/,//' > $AWS_CREDENTIAL_FILE
                        
  export AWS_ACCESS_KEY_ID=`sed -n '3p' $AWS_CREDENTIAL_FILE`
  export AWS_SECRET_ACCESS_KEY=`sed -n '1p' $AWS_CREDENTIAL_FILE`
  export AWS_SECURITY_TOKEN=`sed -n '2p' $AWS_CREDENTIAL_FILE`
  rm $AWS_CREDENTIAL_FILE
fi

/usr/bin/aws "$@"
