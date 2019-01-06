# Azure DevOps Server Lab
This repo contains the following artifacts.

- ARM template
- PowerShell deployment script (used to place machine script)
- PowerShell machine script

The ARM template creates
- An application tier machine that will also hosts AD Domain Services 
- An Azure SQL database and server (DBaaS)
- A storage account (where the machine script will be stored)

The deployment script places the machine script on the storage account

The deployment script is run on the application tier machine using a custom script extension
- It will install AD Domain Services (default domain name will be LAB and lab.internal) 
- Download the Azure DevOps server setup to the C:\ drive

Once the deployment script has run you should be able to log onto the machine and install Azure DevOps Server 2019. 
The installer will be located on the C: drive. 
