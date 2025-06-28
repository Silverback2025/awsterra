## ✅ Prerequisites

Before using this Terraform configuration, ensure the following prerequisites are in place:

### 1. **Terraform & AWS CLI**

* [Terraform v1.4+](https://developer.hashicorp.com/terraform/downloads) installed
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configured:

  ```bash
  aws configure
  ```

---

### 2. **S3 Bucket & DynamoDB Table (for remote state)**

Create these manually or via Terraform:

```bash
aws s3api create-bucket --bucket my-terraform-state-bucket --region us-east-1

aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

Update `backend.tf` with your bucket and table name.

---

### 3. **VPC and Subnets**

You must have an existing VPC with public/private subnets in at least two availability zones.

Alternatively, use the official [`terraform-aws-modules/vpc`](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) module to create a new VPC.

---

### 4. **IAM Permissions**

The Terraform user or role must have permissions including:

* `eks:*`
* `ec2:*`
* `iam:*`
* `autoscaling:*`
* `cloudwatch:*`
* `s3:*` and `dynamodb:*` (for remote state)

> You can temporarily use `AdministratorAccess` in development.

---

### 5. **GitHub Actions (Optional: CI/CD)**

To deploy from GitHub Actions using OpenID Connect (OIDC):

* Create an IAM role with this trust relationship:

```json
{
  "Effect": "Allow",
  "Principal": {
    "Federated": "arn:aws:iam::<account-id>:oidc-provider/token.actions.githubusercontent.com"
  },
  "Action": "sts:AssumeRoleWithWebIdentity",
  "Condition": {
    "StringEquals": {
      "token.actions.githubusercontent.com:sub": "repo:<owner>/<repo>:ref:refs/heads/main"
    }
  }
}
```

* Add the role ARN to your GitHub Actions workflow using `role-to-assume`.

---

### 6. **Initialize and Plan**

Once everything is set up:

```bash
terraform init
terraform validate
terraform plan -var-file="terraform.tfvars"
```


