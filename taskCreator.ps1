# script that allows user to add schedueld tasks that will run once every minute that stops after some time
function CreateTask{                                            
    #this function creates the task after validating task path and name
    param(                                                      
        [ValidateLength(1,32)]
        [Parameter(Mandatory)]
        [String]
        $TaskName 
        ,
        [Parameter(Mandatory)]
        [ValidateScript({
            if(-Not ($_ | Test-Path -PathType Leaf ) ) {
                throw "The path does not contain a file"
            }
            return $true
        })]
        $TaskPath 
    )
    #building the task from the user input and predetermined and the adding it to the task schedueler
    $Action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-NonInteractive -NoLogo -NoProfile -File $TaskPath" 
    $Trigger = New-ScheduledTaskTrigger -Once -At(Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1)  -RepetitionDuration (New-TimeSpan -Hours 23 -Minutes 55)
    $Settings = New-ScheduledTaskSettingsSet
    $Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings $Settings
    Register-ScheduledTask -TaskName $TaskName -InputObject $Task 
}

function ChangeTaskStatus { 
    #this function toggles the task status after some validation
    param(
        [ValidateLength(1,32)]
        [Parameter(Mandatory)]
        [String]
        $SearchTask
    )
    $FoundTask = Get-ScheduledTask -TaskName $SearchTask
        if ($FoundTask.State -eq "Ready"){
            Disable-ScheduledTask -taskname $SearchTask
        }
        else {
            Enable-ScheduledTask -taskname $SearchTask  
        }
    }

function GetAllTasks {
    #this function returns all tasks in a different format,this function wont run normally only if called specifically 
    $tasks = Get-ScheduledTask
    ForEach ($task in $tasks){ Write-Output $task.TaskName }
}

function TurnOffAfter {
    #this function adds a delay before changing task status
    param (
        [ValidateRange(1,500)]
        [uint32]
        $WaitTime
    )
    Start-Sleep -Seconds $WaitTime
}

#this is checking the 3rd commandline argument before running the functions 
if($args[2] -ge 1 -and $args[2] -le 500){
    CreateTask $args[0] $args[1]
    TurnOffAfter $args[2]
    ChangeTaskStatus $args[0]
}
else {
    throw "Wait time must be between 1-500"
}