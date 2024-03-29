<#
.SYNOPSIS
    Start Plex on homelab VM

.DESCRIPTION
    This script is designecd to be run at initial start up on plextorvm01 and 
    will start the  Plex Media Server process.

.PARAMETER Path
    Path of plex server .exe, defaults to the current path on plextorvm01

.NOTES
    Written by Joe Delaney - 2/28/2024... its my first script on my personal 
    repo.... this is so long overdue

.LINK
    ObnoxiousJoe github repo: https://github.com/joedel94/ObnoxiousJoe
#>
#region Parameters

    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$Path = 'C:\Program Files (x86)\Plex\Plex Media Server\Plex Media Server.exe'
    )

    $ErrorActionPreference = 'Stop'

#endregion

#region proc start

    #checks if proc is already running
    $currentProcs = Get-Process
    if('Plex Media Server' -in $currentProcs.ProcessName) {
        Write-Warning 'Plex process already running, move along'
        return
    }

    try {
        Start-Process -FilePath $path 
    }
    catch {
        Write-Error "Issue encountered attempting to start plex service, see full output below`n$_"
    }

    #checks if Plex server proc is running
    $currentProcs = Get-Process 
    if('Plex Media Server' -in $currentProcs.ProcessName) {
        #using write-host since my VM is on Windows Server 2012 R2.... dumb, Future Joe FIX THAT!
        #TODO update this to Write-Information when I upgrade this VM to user PS 7 and Windows Server 2016+
        Write-Host 'Plex server .exe started successfully'
        return
    }
    else {
        Write-Error 'Plex server .exe failed to start but did not throw terminating error, please review'
        return
    }

#endregion