# download tfs
Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=2041267" -OutFile "C:\devopsserver2019.exe"

# make sure we can use the server manager commands
Import-Module ServerManager

# install AD
Install-WindowsFeature AD-Domain-Services

# import the module to set AD up
Import-Module ADDSDeployment

# set up AD 
# we will supply a generic password
# NEVER USE THIS SCRIPT FOR A PRODUCTION DEPLOYMENT !
Install-ADDSForest -DatabasePath "C:\Windows\NTDS" -DomainMode "Win2012R2" -DomainName "lab.local" -DomainNetbiosName "LAB" -ForestMode "Win2012R2" -InstallDns -LogPath "C:\Windows\NTDS" -SysvolPath "C:\Windows\SYSVOL" -SafeModeAdministratorPassword (ConvertTo-SecureString -String "abcd1234!!123abcd" -AsPlainText -Force) -Force

# the machine will restart at this point
