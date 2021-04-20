# Issue / Problems found from using Terraform

## Terraform cannot import lambda function due to 'Code Signing'

* From https://github.com/hashicorp/terraform-provider-aws/issues/16398
* Cannot import or create lambda function with terraform due to code signing configuration is not exist
* Code signing profile -> must be used from aws v3.17.0 
(currently is 3.23.0)
* Can create signing profile but cannot config create configuration on lambda console (unauthorized)
* Solution : Use aws version 3.16.0 instead
  * https://github.com/hashicorp/terraform-provider-aws/issues/16398#issuecomment-732688717

## Terraform output doesn't work with module

* Output doesn't show when plan or apply with module structure
* For TF version since 0.12 (command  -module for output is deprecated)
* Solution : Need to create an output block with module's output value on root file
  * https://stackoverflow.com/a/52503759
  * https://stackoverflow.com/a/60112145
