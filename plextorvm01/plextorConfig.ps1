Configuration PlexServer {
    
    Import-DscResource -ModuleName PSDscResources

    Node plextorvm01 {
        ProcessSet PlexApplication {
            Path = 'C:\Program Files (x86)\Plex\Plex Media Server\Plex Media Server.exe'
            Ensure = 'Present'
        }
    }
}