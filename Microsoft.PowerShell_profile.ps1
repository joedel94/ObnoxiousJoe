#region variables

    #homelab NAS file dir 
    $Nas = '\\synnas01\'

#endregion

#region Modules and Functions

    #import a bunch of useful modules
    Import-Module -Name "posh-git"

#endregion

#region PS Drives

    #git local repo location
    New-PSDrive -Name 'L' -PSProvider FileSystem -Root "$HOME\LocalRepos" | Out-Null
    #synnas01 homelab NAS, checks first of the NAS is reachable in case I am not home
    #this will require a cred to be entered at each login, this should be cached in cred manager but that is not the best
    #TODO... I need a secret management solution for the homelab... 
    $media = Join-Path -Path $Nas -ChildPath '\media'
    if (Test-Path -Path $media) {
        New-PSDrive -Name 'N' -PSProvider FileSystem -Root $media | Out-Null
    }
    else {
        Write-Warning 'Joe are you traveling? if not check the NAS connection...'
    }
    
#endregion