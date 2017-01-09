Write-Host
Write-Host -ForegroundColor Cyan '--------------------------------------------------'
Write-Host
Write-Host -ForegroundColor Yellow 'This script requires you to have Administrator access to your Exchange online environment.'
Write-Host -ForegroundColor Yellow 'If you need assistance, please contact the System Administrator.'
Write-Host
Write-Host -ForegroundColor Red 'Press Ctrl-C to exit this script at any time.'
Write-Host
Write-Host -ForegroundColor Cyan '--------------------------------------------------'
Pause
$UserCredential = Get-Credential -Message 'Please enter your Exchange Online/Office 365 credentials. This must be an administrator account.'
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
##Adding pause to make sure the session is connected before importing  - there is probably a better way to do it.##
Pause
Import-PSSession $Session
$User = Read-Host -Prompt 'Enter the O365 Username you wish to check'
Write-Host 'Running. Outputting to C:\Temp\List.csv'
Write-Host -ForegroundColor Red -BackgroundColor Black 'Press Enter once this finishes to clean up the session.'
##ResultSize will add additional time but permit checking more than a thousand items and stop the error message. The path can also be modified for the CSV.
##the previous version just showed in a list which wasn't useful for more than a quick look.
Get-Mailbox -ResultSize Unlimited | Get-MailboxPermission -User $User | Where {$_.user.tostring() -ne "NT AUTHORITY\SELF" -and $_.IsInherited -eq $false} | Select-Object Identity,AccessRights,InheritanceType,IsValid,Deny,User,ObjectState | Export-CSV -path 'C:\Temp\List.csv'
Pause
Remove-PSSession $Session
Write-Host 'Clean up complete. Please close this window.'
