# Issue / Problems found from using Terraform

## Contact AWS support
https://console.aws.amazon.com/support/home?#/
![image](https://user-images.githubusercontent.com/15243449/123042065-757b7800-d420-11eb-82f6-f5137e5abca9.png)

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

## DDB Global Table (v2017) must consist of an 'EMPTY' local table
* https://github.com/hashicorp/terraform-provider-aws/issues/11678
* Found that cannot create or update a global table if the local table has an item in it.
* Workaround -> Currently need to clear data in table that use as global table before deploy new resource
