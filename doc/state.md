# Terraform state

## State Management

|State Command | |
|-|-|
|Move state (from resource / module to desired destination)|https://www.terraform.io/docs/cli/state/move.html|
|Refresh state to update (sync) resource info with the remote|https://www.terraform.io/docs/commands/refresh.html|
|Inspecting state|https://www.terraform.io/docs/cli/state/inspect.html|
|Moving resource|https://www.terraform.io/docs/cli/state/move.html|
|Recover resource|https://www.terraform.io/docs/cli/state/recover.html|
|Show resource state|https://www.terraform.io/docs/commands/state/show.html#example-show-a-resource|

## Remote State for working with team

* Uploading the state file on S3
* Create a remote backend block with configuration value
* Run terraform init to initialize and copy the state value to the remote file
* Add State Locking to prevent conflict when run apply from multiple user

|Terraform Remote State | |
|-|-|
|Best practice guide|https://github.com/ozbillwang/terraform-best-practices#manage-s3-backend-for-tfstate-files|
|Remote state with S3|https://www.terraform.io/docs/language/settings/backends/s3.html|
|Backend and remote state|https://www.youtube.com/watch?v=RBW253A4SvY|
|Learn Terraform State|https://www.youtube.com/watch?v=yhLrH0Q-kq4|

## Error TF State file

* https://github.com/cloudposse/docs/issues/358
* If there is an error while applying. The applied state will not be updated to the state file. These state will be store in `errored.tfstate`
* To update this state use `terraform state push errored.tfstate`
