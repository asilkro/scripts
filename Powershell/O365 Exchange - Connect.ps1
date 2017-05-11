###########################################################
# AUTHOR  : Andrew Silkroski 
# DATE    : 1 May 2017 
# EDIT    : 1 May 2017
# COMMENT : This is a simple script combining three commands
# located on the technet article to connect to Exchange Online.
# Added a couple comments for clarification. 
# VERSION : 1.0
###########################################################
## Uncomment the execution policy and run as administrator if you get this error:
## Files cannot be loaded because running scripts is disabled on this system.
## Provide a valid certificate with which to sign the files.

#Set-ExecutionPolicy RemoteSigned -Verbose

#####
## This part is useful but useful for those not familiar with Powershell.
#####
$UserCredential = Get-Credential -Message 'Please enter your Exchange Online/Office 365 credentials. This must be an administrator account.'
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
#####
## This is all formatting for formatting's sake. I think it looks nice, but you can comment or cut as desired.
#####
Write-Host -ForegroundColor Cyan '--------------------------------------------------'
Write-Host -ForegroundColor Cyan 'You are now connected to Exchange Online.' 
#####
## This part is optional but useful for those not familiar with Powershell.
#####
#Write-Host -ForegroundColor Cyan 'To disconnect, run the following command:'
#Write-Host -ForegroundColor Red 'Remove-PSSession $Session'
#####
Write-Host -ForegroundColor Cyan '--------------------------------------------------'
