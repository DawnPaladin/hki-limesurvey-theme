#Powershell.exe -noprofile -executionpolicy Bypass -file .\Build.NA.ps1
# This file exists to help in deploying the application to production or staging servers 
# when the repo has been pushed.  Jenkins watches the repositories and when a repo receives
# a push, then Jenkins will pull the repo and execute this PowerShell script to distribute 
# the code.  This file will have no purpose and will not be execute until someone sets up
# a Jenkins build job for the repository this application is in

function DeploySource {
    param([string]$Server, [string]$Path) # $Server is the sever to distribute to and $Path is the share

    # Executes robocopy to distribute the code.  This'll have to be customized for the application to 
    # exclude any directories or files that shouldn't be distributed from the repo.  This'll typically 
    # include any directories from another repo (sometimes configuration files are stored in a different 
    # repo in order to have different sets of config files per region), server/site config files, and 
    # files used in the repo like .hgignore
    #
    # RoboCopy switches used in this repo copy
    # /XD  : Excludes this list of directories from the copy
    # /XF  : Excludes this list of files from the copy
    # /XX  : Won't delete this list of directories from the destination
    # /MIR : Prevents copying identical files
    robocopy ".\" "\\$Server\$Path" /MIR /XD ".hg" /XF "Build.EU.ps1" ".hgignore" > ("..\"+$Path.Replace("\","_")+"_copy_$Server.log")
    if($LASTEXITCODE -gt 4) {
        throw "robocopy command failed to copy to $Server\$Path with LastExitCode $LastExitCode"
        exit 1
    }
}

# Writes out a version file with information from the repository like revision and build number
[IO.File]::WriteAllLines("version.json", ('{ "version": "1.0", "revision": "'+(hg identify --num)+'", "build": "'+$ENV:BUILD_NUMBER+'"}'))

# Executes the deploy function.  This can be copied/pasted to distribute the code to multiple servers
DeploySource -server 10.0.4.212 -path "htdocs\limesurvey\upload\themes\survey\hki"

# Exit the screen with no errors
exit 0