# Azure Function deployments with Terraform and GitHub Actions

Testing Azure Function deployments

## Testing locally

1. Install Terraform
1. Provide required variables
1. Initialize Terraform with custom state settings
1. Makes changes and apply

## Install Terraform

TODO

## Provide required variables

To provide the required variable we can use environment variables or a variable file (.tfvars)

### Set values using environment variables

Create environment variables with `TF_VAR_` prefix. In PowerShell:

```plain
$env:TF_VAR_name_prefix="<naming prefix>"
$env:TF_VAR_location="<azure region>"
$env:TF_VAR_secret_1="my_secret_value_1"
$env:TF_VAR_secret_2="my_secret_value_2"
```

### Set values using tfvars file

Create a tfvars file with contents:

```plain
name_prefix = "<naming prefix>"
location    = "<azure region>"
secret_1    = "my_secret_value_1"
secret_2    = "my_secret_value_2"
```

## Initialize Terraform with custom state settings

The resource group and the storage account must pre-exist. Ensure the storage account has a container named `deployments`

### Using environment variables

```plain
$env:TFStateResourceGroup="<existing tf state resource group>"
$env:TFStateStorageAccountName="<existing tf state resource group>"
terraform init -backend-config="resource_group_name=$env:TFStateResourceGroup" -backend-config="storage_account_name=$env:TFStateStorageAccountName"
```

### Using configuration files

Create a .tfbackend file (recommended file extension) such as:

```plain
resource_group_name  = "<existing tf state resource group>"
storage_account_name = "<existing tf state resource group>"
```

Then initialize it:

```plain
terraform init -backend-config="stage.tfbackend"
```

```plain
terraform init -backend-config="storage_account_name=$env:TFStateStorageAccountName" -backend-config="stage.tfbackend"
```

### Makes changes and apply

To plan changes:

```plain
terraform plan
OR
terraform plan -var-file="my_file.tfvars"
```

To apply changes:

```plain
terraform apply -auto-approve
```

## Troubleshooting

### Error: Backend configuration changed

This error happens if already have a ./terraform folder and change the backend configuration. For development purposes deleting the `.terraform` folder and the `.terraform.lock.hcl` do the trick.
