# download tfs
Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=2041267" -OutFile "C:\devopsserver2019rc1.exe"

# make sure we can use the server manager commands
Import-Module ServerManager

# install AD
Install-WindowsFeature AD-Domain-Services

# import the module to set AD up
Import-Module ADDSDeployment

# set up AD 
Install-ADDSForest -CreateDnsDelegation $false -DatabasePath "C:\Windows\NTDS" -DomainMode "Win2012R2" -DomainName "lab.local" -DomainNetbiosName "LAB" -ForestMode "Win2012R2" -InstallDns $true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion $false -SysvolPath "C:\Windows\SYSVOL" -Force

# the machine will restart at this point