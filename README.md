# tfAnsibleVcenterAviController

## Goal of this repo

This repo spin up a full Avi environment in vCenter, it can be used for vCenter or TKGm use cases.
It leverages Terraform for the IaS and Ansible for IaC.

# Prerequisites
- terraform (https://learn.hashicorp.com/tutorials/terraform/install-cli)
- ansible (pip3 install ansible)
- jmespath (pip3 install jmespath)
- netaddr (pip3 install netaddr)
- dnspython(pip3 install dnspython)
- Avi ansible collection (sudo -u ubuntu ansible-galaxy collection install vmware.alb)

## clone this repo:

git clone https://github.com/tacobayle/tfAnsibleVcenterAviController

## Variables:

- environment variables (sensitive information):

| Variable names        | Description           | Mandatory  | Example  
| --------------------- |---------------------|:----------:|:--------|
| vsphere_username      | vsphere_username | true |administrator
| vsphere_password      | vsphere_password | true |******
| avi_password          | New Avi password | true |******
| avi_backup_passphrase | backup_passphrase| true |******
| avi_old_password      | avi_old_password | true |******
| avi_controller_url    | url to download Avi software | true |******

- variables in variables.tf (mainly for IaC)

- variables in avi.json (mainly for Avi Config)

