# LAMP-Server-Using-Terraform
Purpose of this code is to automate LAMP deployment using terraform and ansible. 
I will be deploying MediaWiki Application on Ubuntu.

Reference: https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Debian_or_Ubuntu

Assumptions :

You are using Azure cloud for your deployment.

The host machine where this code needs to be run is Linux. Since Ansible can't be installed on Windows. And WSL isn't offically supported.

Terraform module deploys Ubuntu 20.04 machine. This can be easily changed using terraform.tfvars file, since we are using variables for this deployment. 

This is explained in detail later.

Requirements :

Linux Machine where we will install Terraform, Ansible and Azure CLI.

Basic familarity with command line interface.

Root privileges on this host machine.

Usage :

terraform-resources directory contains the actual terraform and ansible code. terraform-modules directory is used to write or define terraform modules. 

Which means you will be dealing with only terraform-resources folder most of the times. 

All the files I explain further are under terraform-resources unless otherwise mentioned.

main.tf -> Main terraform file, that will eventually call required terraform modules defined in module section. You have to modify the backend configuration in this file.

terraform.tfvars -> Terraform Variable input file. Update all the variable values in the file before initiating the deployment.

Install_Loop.yml -> Ansible playbook to define the packages we want to be installed. This playbook also has the firewall configuration and rules.

mysql_secure -> Ansible playbook to setup mysql secure installation and make all the required changes regarding new database, user.

apacheconfig.yml -> Ansible playbook to make Apache configuration changes. This includes downloading or editing any config files.

restart_services.yml -> Ansible playbook to restart any service required to ensure changes are implemented.

Prerequisites :

We are using Azure BLOB as backend configuration, so you need to ensure the storage account and container mentioned in the backend configuration exists. 

![image](https://user-images.githubusercontent.com/86006803/230807525-e4b981dd-c612-4797-8615-e2111a990289.png)


This is updated under backend section of main.tf file located in terraform-resources directory.

![image](https://user-images.githubusercontent.com/86006803/230807242-0b83db98-7cbd-4e6d-90d1-e43c4e647e2e.png)


To ensure this configuration is secure. We are using Key Vault to store all our sensitive information. 

Since we are using data block to fetch key vault secrets, The key vault and the secrets should already exist.

![image](https://user-images.githubusercontent.com/86006803/230807434-81a823f0-7c01-48e9-9b01-02d0a5086dbe.png)


wiki_pass refers to the secret storing the password for the wiki MySQL user created as part of this process.

mysql_root_pass refers to the secret storing the password for the root MySQL user created as part of this MySQL secure installation.

virtual_machine_Usr refers to the secret storing the username for the Virtual Machine user.

virtual_machine_Passwd refers to the secret storing the password for the Virtual Machine user.

This deployment is using password authentication.

We are using Terraform modules and variables to ensure this code is scalable. 

Before you start the deployment you need to update the required values in "terraform.tfvars" file under terraform-resources folder. 

![image](https://user-images.githubusercontent.com/86006803/230807292-b6b12236-90a7-47a0-9cca-5d0bbb73f0b9.png)



I have used conditionals in the terraform variables file to ensure we are performing error handling. 

You can edit or modify these conditionals if you have any specific custom requirements.

Install_Loop.yaml file contains the list of packages which needs to be installed. If you are planning to install anything additional. 

Just append the list and loop will take care of the setup.

To run this example, simply follow to steps below:

First you need to install Terraform, Ansible and Az cli on your machine. You can use ubuntu_installation.sh located under terraform-resources.

Run 'az login' to login Azure Subscription where these resources need to be deployed.

Run below command in your machine 

export ANSIBLE_HOST_KEY_CHECKING=False   (mandatory)

Otherwise you will see an error during the ansible task "Using a SSH password instead of a key is not possible because Host Key checking is enabled"

Perform git clone of the repo

Navigate to terraform-resources folder, use :

  1) cd terraform-resources
  
  2) terraform init
  
  3) terraform plan
  
  4) terraform apply

Explanation :

Terraform init -> It initializes the directory and downloads required provider along with configuring the module.

Terraform plan -> This helps you verify the code is going to deploy the resources as expected. This also ensures we don't face any unwanted surprise. 

This isn't mandatory, but a recommended step.

Terraform apply -> This step creates/destroys the resources specified in this code. We can skip manual approval by using --auto-approve parameter.

Output :

Navigate your browser to http://server_ip_address/mediawiki-1.39.3/index.php

![image](https://user-images.githubusercontent.com/86006803/230806777-10b4fcca-1084-44b5-9901-02704702ba0e.png)
