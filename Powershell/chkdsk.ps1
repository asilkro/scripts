$driveletter = Read-Host "Enter Drive Letter"
$disk = Get-WmiObject -Class Win32_LogicalDisk -Filter  ("DeviceID='" + $driveletter+":'")

if ($disk){
    $FixErrors          = $false    # does not fix errors 
    $VigorousIndexCheck = $true     # performs a vigorous check of the indexes
    $SkipFolderCycle    = $false    # does not skip folder cycle checking.
    $ForceDismount      = $false    # will not force a dismount (to enable errors to be   fixed)
    $RecoverBadSecors   = $false    # does not recover bad sectors
    $OKToRunAtBootup    = $false    # runs now, vs at next bootup
    $res = $disk.chkdsk($FixErrors, 
                    $VigorousIndexCheck, 
                    $SkipFolderCycle, 
                    $ForceDismount,
                     $RecoverBadSecors, 
                   $OKToRunAtBootup)
     #bonus from http://msdn.microsoft.com/en-us/library/aa384915(v=vs.85).aspx     
     $char=$res.returnvalue
     If ($char -ge 0 -and $char -le 5) {
        switch ($char) {
            0{"00-Success"}
            1{"01-sUCCESS (volume locked and chkdsk scheduled for reboot"}
            2{"02-unsupported file system"}
            3{"03-Unknown file system"}
            4{"04-No Media in drive"}
            5{"05-Unknown Error"}
        }
    }

    Else {
        "{0} - *Invalid Result Code*" -f $char
    }
}

Else
{
    "Drive letter does not exist"
}