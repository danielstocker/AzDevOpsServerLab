# Azure DevOps Server Lab
This repo contains the following artifacts.

- ARM template
- PowerShell deployment script (used to place machine script)
- PowerShell machine script

These need to be run in order.

The ARM template creates
- An application tier machine that will also hosts AD Domain Services 
- An Azure AD managed identity extension that is placed on the target VM (for interaction with the SQL DBs later)
- Two Azure SQL databases (Configuration & Collection database) on a managed server (DBaaS)
- A storage account (where the machine script will be stored)

The deployment script places the machine script on the storage account and creates a customer script extension on the target VM.

The machine script is run on the application tier (target) machine using a custom script extension
- It will install AD Domain Services (default domain name will be LAB and lab.internal) 
- Download the Azure DevOps server setup to the C:\ drive

Once the machine script has run you should be able to RDP to the machine and install Azure DevOps Server 2019. 
The installer will be located on the C: drive. 

When configuring the database connection, please follow the instructions in this article: https://docs.microsoft.com/en-us/tfs/server/install/install-azure-sql 
The managed service identity will have already been created for you.

All that is left to do is to:
- Enable Azure AD authentication for the Azure SQL server
- Connect to the server
- Run the scripts to give the MSI access as per the article
