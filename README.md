Mini-Finance Deployment — Terraform + Ansible (Azure):


This project demonstrates a full DevOps workflow to deploy a static Mini Finance web application on Microsoft Azure using:

- Terraform for infrastructure provisioning

- Ansible for configuration management and application deployment

The goal is to automate the full deployment process, from network setup and VM creation to installing Nginx and serving a static website.

Project Objectives: 

-Provision Azure infrastructure via Terraform

- Configure passwordless SSH authentication using public key

- Install and configure Nginx using Ansible

- Clone a static web application from GitHub

- Deploy application files to /var/www/html

-Ensure Nginx reloads gracefully after deployment

- Validate application availability over HTTP

Folder Structure
mini-finance/
├─ terraform/
│  ├─ providers.tf
│  ├─ main.tf
│  ├─ variables.tf
│  └─ terraform.tfvars
├─ ansible/
│  ├─ inventory.ini
│  └─ site.yml
└─ README.md

Infrastructure Provisioned

Component	Description:
- Resource Group	Logical container for Azure resources
- Virtual Network	Address space 10.0.0.0/16
- Subnet	Address range 10.0.1.0/24
- Network Security Group	With inbound rules for SSH (22) and HTTP (80)
- Public IP	Static assigned public IP
- Network Interface	Attached to VM
- Virtual Machine	Ubuntu VM with SSH key access
- Nginx	Installed and configured using Ansible
- Tools Used
- Tool	Purpose
- Terraform	Infrastructure as Code
- Azure	Cloud provider
- Ansible	Configuration automation
- Git	Version control
- Nginx	Web server
- Deployment Instructions

  
1. Provision Infrastructure with Terraform
cd terraform
terraform init
terraform apply -auto-approve


After completion, note the public IP output.

2. Configure and Deploy with Ansible

Update ansible/inventory.ini with the Terraform-generated public IP.

Then run:

cd ../ansible
ansible-playbook -i inventory.ini site.yml

Access the Application

Open a browser and navigate to:

http://<PUBLIC_IP>


Validation	Command
- Verify SSH connectivity	ssh azureuser@<public_ip>
- Ping VM using Ansible	ansible -i inventory.ini web -m ping
- Check Nginx locally on VM	curl http://localhost
- Browser access	Visit VM public IP in browser
- Reflection

This project strengthened my hands-on understanding of Infrastructure as Code and automation principles. 
I learned how to integrate Terraform for provisioning and Ansible for configuration, while resolving real-world issues such as SSH key setup, NSG rules, and application deployment paths.

Real-World Application

- This workflow can be adapted for:

- Demo or staging environments

- Automated VM provisioning and configuration

- Static or lightweight application hosting

- Cloud learning and DevOps practice environments

Future Enhancements

- Add CI/CD pipeline (GitHub Actions or Azure DevOps)

- Use remote state backend for Terraform with state locking

- Deploy TLS/SSL with Let's Encrypt

- Convert Ansible playbook into reusable roles

- Add monitoring and logging
