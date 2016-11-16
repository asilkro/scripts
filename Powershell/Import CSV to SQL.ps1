################################################################################
#     Author: Vikas Sukhija - Modified by Andrew Silkroski
#     Date: 07/17/2015 - Updated 7/22/2016
#     Reviewer: 
#     Desc : Import Message Tracking Log to SQL from CSV
#
################################################################################# 
########################Load SQL Snapin########################################## 
 
If ((Get-PSSnapin | where {$_.Name -match "SqlServerCmdletSnapin100"}) -eq $null) 
{ 
  Add-PSSnapin SqlServerCmdletSnapin100 
} 
 
If ((Get-PSSnapin | where {$_.Name -match "SqlServerProviderSnapin100"}) -eq $null) 
{ 
  Add-PSSnapin SqlServerProviderSnapin100 
} 

##SQL Server 2012 uses modules so may need to be Import-Module sqlps; haven't tested yet##
$sql_instance_name = 'SERVERNAME' 
$db_name = 'DB_NAME' 
 
$impcsv = ".\$FILE.csv"
 
$data = import-csv $impcsv 
 
$count = 1 
 
foreach($i in $data){ 
 
$MessageId = $i.MessageId 
$MessageTraceId = $i.MessageTraceId 
$Received = $i.Received 
$SenderAddress = $i.SenderAddress 
$RecipientAddress = $i.RecipientAddress  
$ToIP = $i.ToIP
$FromIP = $i.FromIP
$Subject = $i.Subject
$Status = $i.Status
$Size = $i.Size 
 
##O365MtLog is the name format I've used for the DB so I can easily decipher it after the fact.##
$query = "INSERT INTO O365MtLog (MessageId, MessageTraceId, Received, SenderAddress, RecipientAddress, ToIP, FromIP, Subject, Status, Size) 
             VALUES ('$MessageId','$MessageTraceId','$Received','$SenderAddress','$RecipientAddress','$ToIP','$FromIP','$Subject','$Status','$Size')" 
 
$impcsv = invoke-sqlcmd -Database $db_name -Query $query  -serverinstance $sql_instance_name  
 
write-host "Processing row ..........$count" -foregroundcolor green 
 
$count  = $count + 1 
 
} 
 
###################################################################
