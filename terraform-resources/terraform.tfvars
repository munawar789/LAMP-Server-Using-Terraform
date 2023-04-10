subscription_id = "28cfc8db-2888-49e8-9e6b-8xxxxxxx4fe"
## Pre Defined KV for storing secret
devKV_Name = "mediawiki-kv" #### change this
## VNET - SUBNET
rg_Name            = "mediawiki_rg" ## change this
location           = "eastus"
vnet_Name          = "vnet-terraform-modulesdev-eus"
vnet_Address       = "192.168.0.0/20"
subnet_NameList    = ["snet-vm-terraform-modulesdev-eus", "snet-shared-terraform-modulesdev-eus"]
subnet_AddressList = ["192.168.0.0/26", "192.168.0.64/26"]
wiki_pass          = "wiki-pass"
mysql_root_pass    = "mysql-root-pass"

### Linux Virtual Machine Deployment

virtual_machine_Usr    = "virtual-machine-user"
virtual_machine_Passwd = "virtual-machine-passwd"
vm_pip                 = "public_ip_linux"
pip_allocation         = "Dynamic"
vm_nic                 = "linux_vm_nic"
ip_configuration       = "ip_config"
vm_name                = "MediaWiki-Ubuntu-LAMP-Server"
vm_size                = "Standard_B2s"
vm_username            = "" ## Fetched from KV.
vm_password            = "" ## Fetched from KV.
vm_image_publisher     = "Canonical"
vm_image_offer         = "0001-com-ubuntu-server-focal"
vm_image_sku           = "20_04-lts-gen2"
vm_image_version       = "20.04.202010140"
vm_os_disk_strg_type   = "Standard_LRS"
vm_os_disk_caching     = "ReadWrite"
