# AWS OIDC Bitbucket Pipe

This Bitbucket pipe enables your CI/CD pipeline to assume an AWS role using OIDC (OpenID Connect) and build and publish Docker images to a public Docker Hub repository.

## Prerequisites

- Bitbucket repository [with OIDC enabled](https://support.atlassian.com/bitbucket-cloud/docs/deploy-on-aws-using-bitbucket-pipelines-openid-connect/) for your pipelines.
- AWS account with IAM role configured for OIDC.

## Configuration

### Bitbucket Repository Settings

1. **Enable OIDC in your pipeline**:
    Ensure your Bitbucket pipeline step has `oidc: true` enabled.

2. **Set up repository variables**:
    - `AWS_OIDC_ROLE_ARN`: The ARN of the AWS IAM role to assume.
    - `AWS_DEFAULT_REGION`: The default AWS region to use.

### AWS IAM Role Configuration

1. Create an IAM role in AWS with the necessary permissions for your tasks.
2. Configure the role for OIDC by adding the Bitbucket OIDC provider to the trust policy.

### Bitbucket Pipeline Configuration

Create a file named `bitbucket-pipelines.yml` in the root of your repository with the following content:

```yaml
pipelines:
  default:
    - step:
        name: Do something after authenticating to AWS via OIDC
        oidc: true
        script:
          - pipe: docker://dwightwhitlock1/aws-oidc-bitbucket-pipe:sha-1d105b4
            variables:
              AWS_OIDC_ROLE_ARN: arn:aws:iam::0000000000:role/bitbucket-oidc-role
              AWS_DEFAULT_REGION: us-east-1
            
```