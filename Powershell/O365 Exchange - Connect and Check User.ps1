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
Import-PSSession $Session
$User = Read-Host -Prompt 'Enter the O365 Username you wish to check'
Write-Host 'Running. You should see your results shortly.'
Write-Host -ForegroundColor Red -BackgroundColor Black 'Press Enter once this finishes to clean up the session.'
Get-Mailbox | Get-MailboxPermission -User $User | Where {$_.user.tostring() -ne "NT AUTHORITY\SELF" -and $_.IsInherited -eq $false} | Format-List
Pause
Remove-PSSession $Session
Write-Host 'Clean up complete. Please close this window.'