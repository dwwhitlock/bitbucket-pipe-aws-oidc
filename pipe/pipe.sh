#!/usr/bin/env bash

# requires oidc: true in calling step
mkdir -p /.aws-oidc
AWS_WEB_IDENTITY_TOKEN_FILE=/.aws-oidc/web_identity_token
echo "${BITBUCKET_STEP_OIDC_TOKEN}" >> ${AWS_WEB_IDENTITY_TOKEN_FILE}
chmod 400 ${AWS_WEB_IDENTITY_TOKEN_FILE}
aws configure set web_identity_token_file ${AWS_WEB_IDENTITY_TOKEN_FILE}
aws configure set role_arn ${AWS_OIDC_ROLE_ARN}
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
