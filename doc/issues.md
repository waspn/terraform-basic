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

## Terraform cannot create data source with authorization config
* https://github.com/hashicorp/terraform/issues/22321
* https://github.com/hashicorp/terraform-provider-aws/pull/13080
* From the document and opened issue on githib, Terraform doesn't support the authorization config block on HTTP data source (currently support only HTTP endpoint)
* Workaround: use [cloudformation_stack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) to create this instead
* Step to create the resource by cloudformation_stack
  * Create a resource `aws_cloudformation_stack` with attribute `name` and `template_body`
  ```
  resource "aws_cloudformation_stack" "datasource_with_auth_config" {
   name = "DatasourceAuthConfig"
   template_body = file("../assets/template/datasource_auth_config.json")
  }
  ```
  * For the `template_body`, use the path of JSON file consist of configuration value
  ```
  {
   "Resources": {
     "DatasourceAuthConfig": { // <- use the same name as config in the tf file
       "Type": "AWS::AppSync::DataSource",
       "Properties": {
         "ApiId": "APPSYNC_API_ID",
         "HttpConfig": {
           "AuthorizationConfig": {
            "AuthorizationType": "AWS_IAM",
            "AwsIamConfig": {
              "SigningRegion": "APPSYNC_REGION",
              "SigningServiceName": "sns"
           }
         },
         "Endpoint": "SNS_ENDPOINT"
        },
        "Name": "HTTP_SNS_IAM",
        "ServiceRoleArn": "ROLE_ARN",
        "Type": "HTTP"
      }
    }
  }
  ```
 * The configuration value can be seen on the document
   * [AppSync Datasource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-appsync-datasource.html)
   * [HTTP Config](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-appsync-datasource-httpconfig.html)
   * [Authorization Config](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-appsync-datasource-authorizationconfig.html)
 * Reference: [Dmitry Lozitskiy - Publish messages to SNS Topic using AppSync resolvers with HTTP datasources](https://dlozitskiy.medium.com/publish-messages-to-sns-topic-using-appsync-resolvers-with-http-datasources-7291cb040dab)
