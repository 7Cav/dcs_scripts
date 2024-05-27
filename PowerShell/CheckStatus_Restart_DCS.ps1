$Process = "DCS_server.exe"
$CurrentTime = Get-Date -format "dd-MMM-yyyy HH:mm:ss"
$ProcessCom = Get-WmiObject Win32_Process -Filter "name = '$Process'" | Select-Object Commandline
$LogFilePath = "C:\Users\DCSGameStaff\Documents\dcs_scripts\PowerShell\Logs\CheckStatus_Restart_DCS.log"

$RestartFlag = 0

# - Create flags for each instance, which will be used to determine if the instance is running

# Tactical Realism 1
$MainServer1 = '"D:\Eagle Dynamics\DCS World Server\bin\DCS_server.exe"  --server --norender --webgui -w Main_Server_1'
$MainServer1Check = 0

# Tactical Realism 2
$MainServer2 = '"D:\Eagle Dynamics\DCS World Server\bin\DCS_server.exe"  --server --norender --webgui -w Main_Server_2'
$MainServer2Check = 0

# Training Server 1
$TrainingServer1 = '"D:\Eagle Dynamics\DCS World Server\bin\DCS_server.exe"  --server --norender --webgui -w Training_Server_1'
$TrainingServer1Check = 0

# Training Server 2
$TrainingServer2 = '"D:\Eagle Dynamics\DCS World Server\bin\DCS_server.exe"  --server --norender --webgui -w Training_Server_2'
$TrainingServer2Check = 0

# Training Server 3
$TrainingServer3 = '"D:\Eagle Dynamics\DCS World Server\bin\DCS_server.exe"  --server --norender --webgui -w Training_Server_3'
$TrainingServer3Check = 0

$LogHeader = "Restart Script is Starting. Start Time: " + $CurrentTime
Add-Content $LogFilePath  $LogHeader
# Add-Content $LogFilePath $ProcessCom
Add-Content $LogFilePath "-------------------------"



foreach ($line in $ProcessCom){

    $obj = [PSCustomObject]@{
        # Compare Main Server 1
        cms1 = $line.CommandLine -contains $MainServer1
        cms2 = $line.CommandLine -contains $MainServer2
    
        # Compare Training Server 1
        cts1 = $line.CommandLine -contains $TrainingServer1
        cts2 = $line.CommandLine -contains $TrainingServer2
        cts3 = $line.CommandLine -contains $TrainingServer3
    }
    
    Add-Content $LogFilePath ("Line: {0}" -f $line)

    # Add-Content $LogFilePath "Prepare to Check Processes"
    if ( $line.CommandLine -contains $MainServer1){
        $MainServer1Check = 1
        
        Add-Content $LogFilePath ("Expt: {0}" -f $MainServer1)
        Add-Content $LogFilePath ("Main Server 1 Check")
        Add-Content $LogFilePath "Main Server 1 is currently up"
    }
    if ( $line.CommandLine -contains $MainServer2){
        $MainServer2Check = 1

        Add-Content $LogFilePath ("Expt: {0}" -f $MainServer2)
        Add-Content $LogFilePath ("Main Server 2 Check")
        Add-Content $LogFilePath "Main Server 2 is currently up"
    }
    if ( $line.CommandLine -contains $TrainingServer1){
        $TrainingServer1Check = 1
        Add-Content $LogFilePath ("Expt: {0}" -f $TrainingServer1)
        Add-Content $LogFilePath ("Training Server 1 Check")
        Add-Content $LogFilePath "Training Server 1 is currently up"
    }
    if ( $line.CommandLine -contains $TrainingServer2){
        $TrainingServer2Check = 1
        
        Add-Content $LogFilePath ("Expt: {0}" -f $TrainingServer2)
        Add-Content $LogFilePath ("Training Server 2 Check")
        Add-Content $LogFilePath "Training Server 2 is currently up"
    }
    if ( $line.CommandLine -contains $TrainingServer3){
        $TrainingServer3Check = 1

        Add-Content $LogFilePath ("Expt: {0}" -f $TrainingServer3)
        Add-Content $LogFilePath ("Training Server 3 Check")
        Add-Content $LogFilePath "Training Server 3 is currently up"
    }    
    Add-Content $LogFilePath ("Compare Line with MainServer_1 {0}, MainServer_2 {1}, Training_Server_1 {2}, Training_Server_2 {3}, Training_Server_3 {4} " -f $obj.cms1, $obj.cms2, $obj.cts1, $obj.cts2, $obj.cts3)    
    Add-Content $LogFilePath "-------------------------"
    
}


if ($MainServer1Check -eq 0){
    Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\DCS\DCS_StartMainServer_1.bat"
    $RestartFlag = 1
    Add-Content $LogFilePath "Main Server 1 was down, and is being restarted"
}
if ($MainServer2Check -eq 0){
    $RestartFlag = 1
    Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\DCS\DCS_StartMainServer_2.bat"
    Add-Content $LogFilePath "Main Server 2 was down, and is being restarted"
}

if ($TrainingServer1Check -eq 0){
    $RestartFlag = 1
    Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\DCS\DCS_StartTrainingServer_1.bat"
    Add-Content $LogFilePath "Training Server 1 was down, and is being restarted"
}
if ($TrainingServer2Check -eq 0){
    $RestartFlag = 1
    Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\DCS\DCS_StartTrainingServer_2.bat"
    Add-Content $LogFilePath "Training Server 2 was down, and is being restarted"
}
# if ($TrainingServer3Check -eq 0){
    #     $RestartFlag = 1
    #     # Start-Process "C:\Users\DCSGameStaff\Saved Games\_-Startup_Scripts-_\DCS\DCS_StartTrainingServer_3.bat"
    #     Add-CONTENT $LogFilePath "Training Server 3 was down, and is being restarted"
    # }

    
if ($RestartFlag -eq 0){
    Add-Content $LogFilePath ("No Servers were restarted - {0}" -f $RestartFlag)
    Add-Content $LogFilePath "-------------------------"
}