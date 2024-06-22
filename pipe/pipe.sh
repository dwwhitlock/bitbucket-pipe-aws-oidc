#!/usr/bin/env bash

# run if AWS_OIDC_ROLE_ARN is set
if [ -z "${AWS_OIDC_ROLE_ARN}" ]; then
  echo "AWS_OIDC_ROLE_ARN is not set. Skipping..."
  exit 0
fi

mkdir -p /.aws-oidc
AWS_WEB_IDENTITY_TOKEN_FILE=/.aws-oidc/web_identity_token
echo "${BITBUCKET_STEP_OIDC_TOKEN}" >> ${AWS_WEB_IDENTITY_TOKEN_FILE}

# https://support.atlassian.com/bitbucket-cloud/docs/write-a-pipe-for-bitbucket-pipelines/#Advanced-tips-and-secrets
chmod 444 ${AWS_WEB_IDENTITY_TOKEN_FILE}
aws configure set web_identity_token_file ${AWS_WEB_IDENTITY_TOKEN_FILE}
aws configure set role_arn ${AWS_OIDC_ROLE_ARN}

# test the configuration
aws sts get-caller-identity

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
