# AWS-Layers-Concept
Terraform setup for Layers Concept

## Instructions

Makefile does all the dirty stuff for both Landing Zone and Application Stack deployments.
In order for this to work you need valid AWS credentials.

**Beware, do not run ANY command using Production AWS credentials.
You risk to change stuff you do not want to, stuff that cost money, jobs or lives.
You have been warned..**

Assuming you have a valid ~/.aws/credentials file and probably also a valid ~/.aws/config file with some profile you can use, select this profile:

```export AWS_PROFILE=personal```

Then you can run the following commands:

```make init ```
Initializes Terraform in the current folder.

```make fmt```
Formats all terraform files in current and all below subfolders.

```make validate```
Validates you have a proper terraform code.

```make plan```
Plans terraform changes and tells you what it should change.

```make apply```
Applies changes, without asking. Beware!

```make plan-destroy```
Tells you if you wanted to destroy stuff, what would it be. Finger in trigger.

```make destroy```
Boom!! You know what happens. It asks a last time before doing that.

Bonus:

```make connect```
Displays the bastion dns name to connect to.

```make ssh_key```
Since in the landing zone we create an ssh key to be used, this command stores it in your local ~/.ssh folder.

## Architecture

The basic idea for this project is to have a two-fold Layer approach in deploying a bunch of VMs in AWS.

- First step: Deploy a VPC and all it is needed to have a working setup. Subnets, routes, GWs you name it.
- Second step: Deploy one or more application "layers" on top of the Landing Zone. The Application Layers are essentially modules you can write that deploy on top of this LZ.

In this demo approach, Landing Zone just creates a simple VPC with basic stuff and a Bastion VM to access.
Then the Application Layers have an ALB, some VMS and some Security rules.
