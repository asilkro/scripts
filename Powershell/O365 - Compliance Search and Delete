###########################################################
# AUTHOR  : Andrew Silkroski 
# DATE    : 1 May 2017 
# EDIT    : 1 May 2017
# COMMENT : This is intended for use to purge emails that
# match a given criteria as defined in the Office365
# Security & Compliance admin page. Only applies to email.
# VERSION : 1.0
###########################################################

# CHANGELOG
# Version 1.0: First publicly usable version.
# ENHANCEMENTS
# -creation of searches is the next goal

#----------------------------------------------------------
# Create powershell session connectiong to the Security
# & Compliance center in Office 365
#----------------------------------------------------------
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid -Credential $UserCredential -Authentication Basic -AllowRedirection 
#----------------------------------------------------------
# Provide Search name matching that in Security page
#----------------------------------------------------------
$Search = Read-Host 'Please enter the name of the saved compliance search. This must match EXACTLY.' 
#----------------------------------------------------------
# Import the session to active window, loading modules.
# AllowClobber can be removed if there is already an
# existing session connected with modules imported.
#----------------------------------------------------------
Import-PSSession $Session -AllowClobber -DisableNameChecking 
$Host.UI.RawUI.WindowTitle = $UserCredential.UserName + " (Office 365 Security & Compliance Center)"
#----------------------------------------------------------
# Prompt for user interaction, can replace with Pause.
# Useful for reminding folks how to cancel if run in error.
#----------------------------------------------------------
Write-Host "When you're ready to proceed, press any key to continue. Ctrl+C to cancel."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")
New-ComplianceSearchAction -SearchName "$Search" -Purge -PurgeType SoftDelete -Verbose 
##
