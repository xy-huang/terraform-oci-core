# terraform-oci-core
This repository contains Terraform scripts for creating and managing Oracle Cloud Infrastructure (OCI) resources, which includes:

- A free domain whose name is defined by terraform variable `domain` or environment variable `TF_VAR_domain`
- A group defined by terraform variable `group` or environment variable `TF_VAR_group`
- An account defined by terraform variable `group` or environment variable `TF_VAR_group`
- Necessary tag resources
- Necsssary policy resources

## Prerequisites
### Install terraform
To get started with this repository, you will need to have Terraform installed on your machine. You can download Terraform from the [official website](https://www.terraform.io/downloads.html).

set terraform_version as environment variable (to be used in resource tag `Operation-Tags.TerraformVersion`)
```shell
export TF_VAR_terraform_version=`terraform version | grep 'Terraform v' | sed -E 's/Terraform v(.*)/\1/'`
```

### Create OCI Object Storage & Archive Storage Bucket
By default the terraform state file defined in `[backend.tf](backend.tf)` will be stored in OCI Object Storage & Archive Storage Bucket, and terraform will use this bucket as AWS S3 compatible backend.

Navigate to `Nevigation menu -> Object Storage -> Buckets`, click on `Create Bucket`, and then fill in the required information to create the bucket `bucket_name`. ***You can also use existing bucket.***

After that, click the bucket and get the `Namespace` value.

### Configure OCI credentials

Assuming you are using account named `{domain_name}\{username}`.

To generate `secret key`, navigate to `Nevigation menu -> Identity & Security -> Domains`, in `{domain_name} -> Users`, click on `{username}` and then `Customer secret keys`, and then click on the `Generate secret key` to generate a new `secret key`. 

***The `Secret Key` value won't be shown again, so you should save the secret key to an appropriate location.***

After that, you will see a new record in `Customer secret keys` section, get the `Access Key`.

To generate `API key`, navigate to `Nevigation menu -> Identity & Security -> Domains`, in `{domain_name} -> Users`, click on `{username}` and then `API keys`, and then click on the `Add API key` to generate a new `API key pair` (of course you can use existing API key pair if you have one). 

***The `private key` value won't be shown again, so you should download the key files to an appropriate location, for example: `~/.oci/keys/<username>@<domain>.pem`.***

After that, you will see a new record in `API keys` section, get the `Fingerprint`. 

Make sure your credential configuration files have the correct permissions (600) and the correct owner (your user account).
```shell
chmod -R 600 ~/.oci/*
```

Now, let's set environment variables to your shell for backend settings:

```shell
export AWS_DEFAULT_REGION=<Region>
export AWS_ACCESS_KEY_ID=<Access Key>
export AWS_SECRET_ACCESS_KEY=<Secret Key>
export AWS_ENDPOINT_URL_S3=https://<Namespace>.compat.objectstorage.<Region>.oraclecloud.com
export AWS_DEFAULT_OUTPUT=json
```

And then for provider credentials:

```shell
TF_VAR_tenancy_ocid=<profile_tenancy_ocid>
TF_VAR_user_ocid=<domain_user_ocid>
TF_VAR_region=<Region>
TF_VAR_fingerprint=<Fingerprint>
TF_VAR_private_key_path=<path_to_private_key>
```

## Quick Start

To get started with this repository, you will need to have Terraform installed on your machine. You can download Terraform from the [official website](https://www.terraform.io/downloads.html).

Once you have Terraform installed, you can fork this repository to your github account and clone it to your local machine, then navigate to the cloned repository directory:

```
cd terraform-oci-core
```

create a file called `s3.tfbackend`

```shell
cat > s3.tfbackend << EOF
bucket = "<bucket_name>"
key = "<path_to_terraform_state_file, for_example: default/terraform-core.tfstate>"
skip_region_validation = true
skip_credentials_validation = true
skip_requesting_account_id = true
use_path_style = true
skip_metadata_api_check = true
skip_s3_checksum = true
EOF
```

create a file called `.tfvars`, if you don't provide `domain`, `group`, `user_name`, they will use default values (`domain=Automation`, `group`=`Command_Line_Interface_Operators`, `user_name=terraform`).

```shell
cat > .tfvars << EOF
compartment_id = "<compartment_ocid>"
domain = "Automation"
group = "Command_Line_Interface_Operators"
user_name = "terraform"
user_email = "<account_email>"
user_recovery_email = "<recovery_email>"
excluding_bucket = "<bucket_name>"
```

Set terraform version as environment variable

```shell
export TF_VAR_terraform_version=`terraform version | grep 'Terraform v' | sed -E 's/Terraform v(.*)/\1/'`
```

Or you can simpliy run

```shell
source pre_init.sh
```

Initialize the Terraform configuration

```shell
terraform init -backend-config=.s3.tfbackend -var-file=.tfvars
```

Plan the changes

```shell
terraform plan -var-file=.tfvars
```

Create the resources

```shell
terraform apply -var-file=.tfvars
```

## Usage

You can use the Terraform commands to manage the OCI resources. For example, to initialize the Terraform configuration, run:

```shell
terraform init -backend-config=.s3.tfbackend -var-file=.tfvars
```

To reinitialize the Terraform configuration, run:

```shell
terraform init -backend-config=.s3.tfbackend -var-file=.tfvars -reconfigure
```

To upgrade providers and plugins, run:

```shell
terraform init -backend-config=.s3.tfbackend -var-file=.tfvars -upgrade
```

To plan the changes, run:

```shell
terraform plan -var-file=.tfvars
```

To create the resources, run:

```shell
terraform apply -var-file=.tfvars
```

To destroy the resources, run:

```shell
terraform destroy -var-file=.tfvars
```

For more information on using Terraform with OCI, please refer to the [Terraform official documentation](https://www.terraform.io/docs/index.html) and the [OCI provider official documentation](https://www.terraform.io/docs/providers/oci/index.html).