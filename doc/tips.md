# Additonal tip and trick found from working

## Keep Terraform code DRY

* Using `.tfvars` and add keep cli arguments in `.hcl` file
* https://blog.gruntwork.io/terragrunt-how-to-keep-your-terraform-code-dry-and-maintainable-f61ae06959d8

## Multiple Provider for multi-region Resource

* Create a multiple provider with alias (non-alias is a default provider)
* For resource/module that need to be created in multiple region, add provider block with alias name to this resource/module
* see example on the source folder
* See more
  * https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly
  * https://medium.com/johnveldboom/terraform-multi-region-deployment-using-modules-4f94d7833b52
  * https://www.terraform.io/docs/cli/commands/state/pull.html
  * https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa
	

## For-Each resource block with Dynamic

* Enter an array or map value
* Create a dynamic block with name
* Add for-each = value
* Create a nest of content block with attribute
* https://www.terraform.io/docs/language/expressions/dynamic-blocks.html

__Example__

*Static*

```
replica {
  region_name = "ap-southeast-1"
}

replica {
  region_name = "us-east-1"
}

replica {
  region_name = "us-west-1"
}
```

*Dynamic*

```
variable "replica_region" {
  type    = list(string)
  default = ["ap-southeast-1","us-east-1","us-west-1"]
}

dynamic "replica" {
  for_each = var.replica_region
  content {
      region_name = replica.value
  }
}
```
___

## Powershell

### Use powershell regex to manage multiple state at once

* Use regex to get a list of require state
* Use ForEach-Object for iterating the command

`terraform state list | Select-String -Pattern "^REGEX_PATTERN?"  | ForEach-Object -Process {terraform COMMAND rm $_}`

Ex. Remove all iam state from module

```
terraform state list | Select-String -Pattern "^module.MODULE_NAME.aws_iam_*?"  | ForEach-Object -Process {terraform state rm $_}

terraform state list | Select-String -Pattern "^module.MODULE_NAME.data.aws_iam_*?"  | ForEach-Object -Process {terraform state rm $_}
```

Ex. Plan all the import datasources resource in MODULE_APPSYNC (already configured) at once

```
terraform state list | Select-String -Pattern "^module.MODULE_APPSYNC.aws_appsync_datasource.*?"  | ForEach-Object -Process {terraform state plan $_}  
```

## AWS CLI

### Get event source mapping UUID in order to import the event_source_mappings resource

* https://docs.aws.amazon.com/cli/latest/reference/lambda/list-event-source-mappings.html

  
  ```
  aws lambda list-event-source-mappings --region="REGION " --function-name="FUNCTION_NAME"
  
  aws lambda list-event-source-mappings --region="REGION " --event-source-arn-name="EVENT_SOURCE_ARN"
  ```

  For FUNCTION_NAME and EVENT_SOURCE_ARN can be checked from table stream arn or lambda function arn