$Process = "SR-Server.exe"
$CurrentTime = Get-Date -format "dd-MMM-yyyy HH:mm:ss"
$ProcessCom = Get-WmiObject Win32_Process -Filter "name = '$Process'" | Select-Object Commandline
$LogFilePath = "C:\Users\DCSGameStaff\Documents\dcs_scripts\PowerShell\Logs\CheckStatus_Restart_SRS.log"

$RestartFlag = 0

# - Create flags for each instance, which will be used to determine if the instance is running

# Tactical Realism 1
$MainSRS1 = '"C:\Program Files\DCS-SimpleRadio-Standalone\SR-Server.exe"  -cfg="C:\Users\DCSGameStaff\Saved Games\__SRS_Config_Files\server_Main1.cfg"'
$MainSRS1Check = 0

# Tactical Realism 1
$MainSRS2 = '"C:\Program Files\DCS-SimpleRadio-Standalone\SR-Server.exe"  -cfg="C:\Users\DCSGameStaff\Saved Games\__SRS_Config_Files\server_Main2.cfg"'
$MainSRS2Check = 0

# Training Server 1
$TrainingSRS1 = '"C:\Program Files\DCS-SimpleRadio-Standalone\SR-Server.exe"  -cfg="C:\Users\DCSGameStaff\Saved Games\__SRS_Config_Files\server_Training1.cfg"'
$TrainingSRS1Check = 0

# Training Server 2
$TrainingSRS2 = '"C:\Program Files\DCS-SimpleRadio-Standalone\SR-Server.exe"  -cfg="C:\Users\DCSGameStaff\Saved Games\__SRS_Config_Files\server_Training2.cfg"'
$TrainingSRS2Check = 0

# Training Server 3
$TrainingSRS3 = '"C:\Program Files\DCS-SimpleRadio-Standalone\SR-Server.exe"  -cfg="C:\Users\DCSGameStaff\Saved Games\__SRS_Config_Files\server_Training3.cfg"'
$TrainingSRS3Check = 0

# Operation Server
$OperationSRS = '"C:\Program Files\DCS-SimpleRadio-Standalone\SR-Server.exe"  -cfg="C:\Users\DCSGameStaff\Saved Games\__SRS_Config_Files\server_Operations.cfg"'
$OperationSRSCheck = 0

$LogHeader = "Restart Script is Starting. Start Time: " + $CurrentTime
Add-Content $LogFilePath  $LogHeader
Add-Content $LogFilePath $ProcessCom
Add-Content $LogFilePath "-------------------------"



foreach ($line in $ProcessCom){

    $obj = [PSCustomObject]@{
        # Compare Main Server 1
        cms1 = $line.CommandLine -contains $MainSRS1
        cms2 = $line.CommandLine -contains $MainSRS2
    
        # Compare Training Server 1
        cts1 = $line.CommandLine -contains $TrainingSRS1
        cts2 = $line.CommandLine -contains $TrainingSRS2
        cts3 = $line.CommandLine -contains $TrainingSRS3
        
        # Compare Operation Server
        cops = $line.CommandLine -contains $OperationSRS
    }
    
    Add-Content $LogFilePath ("Line: {0}" -f $line)

    Add-Content $LogFilePath "Prepare to Check Processes"
   
    if ( $line.CommandLine -contains $MainSRS1){
        $MainSRS1Check = 1
        
        Add-Content $LogFilePath ("Expt: {0}" -f $MainSRS1)
        Add-Content $LogFilePath ("Main SRS 1 Check")
        Add-Content $LogFilePath "Main SRS 1 is currently up"
    }
    if ( $line.CommandLine -contains $MainSRS2){
        $MainSRS2Check = 1

        Add-Content $LogFilePath ("Expt: {0}" -f $MainSRS2)
        Add-Content $LogFilePath ("Main Server 2 Check")
        Add-Content $LogFilePath "Main Server 2 is currently up"
    }
    if ( $line.CommandLine -contains $TrainingSRS1){
        $TrainingSRS1Check = 1
        Add-Content $LogFilePath ("Expt: {0}" -f $TrainingSRS1)
        Add-Content $LogFilePath ("Training Server 1 Check")
        Add-Content $LogFilePath "Training Server 1 is currently up"
    }
    if ( $line.CommandLine -contains $TrainingSRS2){
        $TrainingSRS2Check = 1

        Add-Content $LogFilePath ("Expt: {0}" -f $TrainingSRS2)
        Add-Content $LogFilePath ("Training Server 2 Check")
        Add-Content $LogFilePath "Training Server 2 is currently up"
    }    
    if ( $line.CommandLine -contains $TrainingSRS3){
        $TrainingSRS3Check = 1
        
        Add-Content $LogFilePath ("Expt: {0}" -f $TrainingSRS3)
        Add-Content $LogFilePath ("Training Server 3 Check")
        Add-Content $LogFilePath "Training Server 3 is currently up"
    }
    if ( $line.CommandLine -contains $OperationSRS){
        $OperationSRSCheck = 1

        Add-Content $LogFilePath ("Expt: {0}" -f $OperationSRS)
        Add-Content $LogFilePath ("Operation SRS Check")
        Add-Content $LogFilePath "Operation SRS is currently up"
    }    
    Add-Content $LogFilePath ("Compare Line with MainSRS_1 {0}, MainSRS_2 {1}, Training_SRS_1 {2}, Training_SRS_2 {3}, Training_SRS_3 {4}, Operation_SRS {5} " -f $obj.cms1, $obj.cms2, $obj.cts1, $obj.cts2, $obj.cts3, $obj.cops)    
    Add-Content $LogFilePath "-------------------------"
    
}


if ($MainSRS1Check -eq 0){
    # Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\SRS\SRS_Main1.bat"
    $RestartFlag = 1
    Add-Content $LogFilePath "Main SRS 1 was down, and is being restarted"
}
if ($MainSRS2Check -eq 0){
    $RestartFlag = 1
    # Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\SRS\SRS_Main2.bat"
    Add-Content $LogFilePath "Main SRS 2 was down, and is being restarted"
}

if ($TrainingSRS1Check -eq 0){
    $RestartFlag = 1
    # Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\SRS\SRS_Training1.bat"
    Add-Content $LogFilePath "Training SRS 1 was down, and is being restarted"
}
if ($TrainingSRS2Check -eq 0){
    $RestartFlag = 1
    # Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\SRS\SRS_Training2.bat"
    Add-Content $LogFilePath "Training SRS 2 was down, and is being restarted"
}
if ($TrainingSRS3Check -eq 0){
    $RestartFlag = 1
    # Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\SRS\SRS_Training3.bat"
    Add-CONTENT $LogFilePath "Training SRS 3 was down, and is being restarted"
}

if ($OperationSRSCheck -eq 0){
    $RestartFlag = 1
    Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\SRS\SRS_Operations.bat"
    Add-CONTENT $LogFilePath "Opeation SRS 3 was down, and is being restarted"
}


if ($RestartFlag -eq 0){
    Add-Content $LogFilePath ("No Servers were restarted - {0}" -f $RestartFlag)
    Add-Content $LogFilePath "-------------------------"
}