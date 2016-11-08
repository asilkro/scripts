Write-Host
Write-Host -ForegroundColor Cyan '--------------------------------------------------'
$UserCredential = Get-Credential -Message 'Please enter your Exchange Online/Office 365 credentials. This must be an administrator account.'
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session
Write-Host
Write-Host 'Grabbing your Message Trace data now.'
Get-MessageTrace -StartDate ([DateTime]::Today.AddDays(-1)) -EndDate ([DateTime]::Today) | Select MessageID,Received,*Address,*IP,Subject,Status,Size | Export-Csv "$((get-date ([DateTime]::Today.AddDays(-1)) -Format yyyyMMdd)).csv" -NoTypeInformation
Write-Host
Write-Host 'Export Completed.'
Remove-PSSession $Session
Write-Host 'Clean up complete. Please close this window.'