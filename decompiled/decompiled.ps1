
# W tym pliku znajdują się zawartości kodu PowerShell, które zostały zdekompilowane z orginalnego pliku .exe, i ich krótka analiza.

# ══════════════════════════════[TechniSchools_autoReConfigure_XAMPP_Ini_Log.exe]══════════════════════════════
#$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
#$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
#if ($testadmin -eq $false) {
#    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#    exit $LASTEXITCODE
#}
#Clear-Host
#
#function RemoveControl($path){
#    $pathIni=($path+"xampp-control.ini")
#    if (Test-Path ($pathIni)) {
#        Remove-Item ($pathIni) -Force
#        Write-Host ($pathIni)
#    }
#    else
#    {
#        Write-Host ("No file "+$pathIni)
#    }
#    $pathLog=($path+"xampp-control.log")
#    if (Test-Path ($pathLog)) {
#        Remove-Item ($pathLog) -Force
#        Write-Host ($pathLog)
#    }
#    else{
#        Write-Host ("No file "+$pathLog)
#    }
#}
#
#
#$XamppPath="C:\xampp"
#
#RemoveControl($XamppPath+"\")
#for ($i = 1; $i -le 777; $i++) {
#    RemoveControl(($XamppPath+$i+"\"))
#}
#  ════════════════[ Analiza Kodu ]════════════════
#  Na początku sprawdzamy czy uruchomiono jako admin no i później jeżeli nie to klasycznie relanchujemy jako admin. (Od teraz będę to nazwyał INARAA)
#  Potem mamy funkcję RemoveControl co jest jeszcze okej to rozumiem by usuwać plik .ini i logi
#  Ale to co jest po pierwszym wywołaniu to jest jakiś bezsens. Jakby po co usuwać dodatkowe foldery xampp? I tak system skonfigurtuje sobie powiedzmy ten następny.
#  Ogólnie ten for jest bardzo słabo napisany i zrobił bym go lepiej. Sprawdzał bym też w rejestrze i innych miejscach by upewnić się że jest (w tym przypadku) tylko jeden xampp
#
#  ══════════════════════════════[TechniSchools_disable_BitLocker_security.exe]══════════════════════════════
#
# $BLV = Get-BitLockerVolume
# Disable-BitLocker -MountPoint $BLV
#
#  ════════════════[ Analiza Kodu ]════════════════
#  Tutaj dziwne podejście bo nawet nie ma procedury INARAA, bo to chyba admin jest potrzebny do wyłączenia BitLockera
#  A tak to skrypcik 10/10, podoba mi się dobra implementacja.
#
# ══════════════════════════════[TechniSchools_Docker_configure_before_first_run.exe]══════════════════════════════
#
#
# Check for administrative privileges
#$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
#if (-not $isAdmin) {
#    Write-Host "Please run the script with administrative privileges."
#    exit
#}
#
#Clear-Host
#
## Check if Docker is installed
#if (!(Test-Path -Path "HKLM:\SOFTWARE\Docker Inc.")) {
#    Write-Host "Docker is not installed. Exiting script."
#    exit
#}
#
## Check if docker-users group already exists
#$ud = Get-LocalGroup | Where-Object { $_.Name -eq "docker-users" }
#if (-not $ud) {
#    # Create docker-users group
#    try {
#        New-LocalGroup -Name "docker-users" -Description "Users of Docker Desktop"
#        Write-Host "docker-users group created successfully."
#    } catch {
#        Write-Host "Failed to create docker-users group."
#        exit
#    }
#} else {
#    Write-Host "docker-users group already exists."
#}
#
## Add members to docker-users group
#$members = @('Users', 'Administrators', 'Everyone', 'Wszyscy', 'Użytkownicy', 'Administratorzy')
#foreach ($member in $members) {
#    try {
#        Add-LocalGroupMember -Group 'docker-users' -Member $member -ErrorAction Stop -Verbose
#        Write-Host "Added $member to docker-users group."
#    } catch {
#        Write-Host "Failed to add $member to docker-users group."
#    }
#}
#
## Update WSL
#$wslUpdateOutput = wsl --update
#if ($wslUpdateOutput -like '*This update does not apply to this WSL 2 distribution.*') {
#    Write-Host "WSL update not required."
#} elseif ($wslUpdateOutput -like '*All WSL 2 distributions have been updated.*') {
#    Write-Host "WSL update completed successfully."
#} else {
#    Write-Host "Failed to update WSL."
#    # exit
#}
#  ════════════════[ Analiza Kodu ]════════════════
#  Klasyczna procedura INARAA. Mamy weryfikacje dockera ale zauważyłem (co jest na minus), że jak nie ma dockera to wychodzi ze skryptu. Mi się wydaje że lepiej by było jakby instalowało odrazu
#  Tworzymy grupę docker-users, dodajemy userów do dockera, to są dobre funkcje podoba mi się
#  I ostatnie, na huj tutaj jest wstawiony update WSL? Nie można by zrobić jednego execa do konfiguracji i tam to wyszstko wżócic? No naprawde szczególnie że w nazwie pliku nawet jest że to jest do Dockera
#
#  ══════════════════════════════[TechniSchools_nmap_installation.exe]══════════════════════════════
# Check if Chocolatey is installed
#if (!(Test-Path "$env:ProgramData\chocolatey\bin\choco.exe")) {
#    # Install Chocolatey
#    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#}
#
## Install Nmap version 7.40
#choco install nmap --version=7.40 -y
#
## Add Nmap to system PATH
#$NmapInstallDir = (Get-Command nmap).Path | Split-Path
#write-host $NmapInstallDir
#$envPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
#if (-not $envPath.Contains($NmapInstallDir)) {
#    $newPath = "$NmapInstallDir;$envPath"
#    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
#    # Refresh the environment variables in the current session
#    $env:Path = $newPath
#}
#  ════════════════[ Analiza Kodu ]════════════════
#  Na początku spraawdzamy czy jest chocolatey zainstalowany, no tak średnio bym to powiedział na temat oceny. (Mieszane uczucia)
#  Instaluje nmapa w wersji 7.40, to jest ok ALE, tutaj piszemy hardcoded wersje. Lepszym rozwiązaniem jest fetchować najnowszą wersję
#  No i ostatnie dodaje folder instalacyjny NMAP do Path co jest fajne i to mi się podoba.
#
#  ══════════════════════════════[TechniSchools_package_manager_installer.exe]══════════════════════════════
#cheking admin rights
#$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
#$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
#if ($testadmin -eq $false) {
#    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#    exit $LASTEXITCODE
#}
#
#$instSourceLink = 'https://github.com/Techni-Schools/windows-software-monitor-deployment/raw/waw-2024-2029/to%20install.txt'
#$deinstSourceLink = 'https://github.com/Techni-Schools/windows-software-monitor-deployment/raw/waw-2024-2029/to%20uninstall.txt'
#$pinSourceLink = 'https://github.com/Techni-Schools/windows-software-monitor-deployment/raw/waw-2024-2029/to%20pin.txt'
#$unPinSourceLink = 'https://github.com/Techni-Schools/windows-software-monitor-deployment/raw/waw-2024-2029/to%20unpin.txt'
#
#Set-ExecutionPolicy AllSigned -Force
#function GetFile($source) {
#    $destination = 'C:\Users\Public\package.txt'
#    Start-BitsTransfer -Source $source -Destination $destination
#    $listOfPackageS = Get-Content $destination
#    <# delete file #>
#    Remove-Item $destination
#    return $listOfPackageS
#}
#
#function DeinstalationPrograms {
#    <# Code block to handle packages uninstalion base on list from net #>
#    $uninstalList = GetFile($deinstSourceLink)
#    foreach ($item in $uninstalList) {
#        choco uninstall $item -y
#    }
#}
#
#function InstalationPrograms {
#    <# Code block to handle package instalion base on list from net #>
#    $instList = GetFile($instSourceLink)
#    foreach ($item in $instList) {
#        choco install $item -y
#    }
#    write-host "`n---+++ FINISH install all new packages +++---`n"
#
#}
#
#function UpdatePrograms {
#    $upgradeList = GetFile($instSourceLink)
#    foreach ($item in $upgradeList) {
#        choco upgrade $item -y
#    }
#    Write-Host "Upgrade all packages has been done"
#
#}
#
##disable update/mod programs
#function PinPrograms {
#    $toPin = GetFile($pinSourceLink)
#    foreach ($p in $toPin) {
#        choco pin add -n $p
#    }
#}
#
#function UnPinPrograms {
#
#    $toUnPin = GetFile($unPinSourceLink)
#    foreach ($u in $toUnPin) {
#        choco pin remove -n $u
#    }
#}
#
#if (!(Test-Path "$env:ProgramData\chocolatey\bin\choco.exe")) {
#    # Install Chocolatey
#    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#}
#
#<# Code block to handle package manager de/instalation#>
#if (Test-Path -Path "$env:ProgramData\Chocolatey") {
#    UnPinPrograms
#    PinPrograms
#    DeinstalationPrograms
#    InstalationPrograms
#    # UnPinPrograms
#    # UpdatePrograms
#}
#  ════════════════[ Analiza Kodu ]════════════════
#  Tutaj znowy klasycznie procedura INARAA. I dochodzimy do momentu gdzie mam lekkiego mind fucka, po co blokować aktualizacje programów? Nie lepiej je odinstalować?
#  Ogólnie ten cały proces jest git (instalowanie i odinstalowywanie programów), ale znowu nie rozumiem czemu tu jest instalowanie chocolatey?
#  Lepiej by było jakby on był w TechniSchools_updater.exe, bo wtedy wszystko jakby jest dobrze poukładane i lepsze no w organizacji.
#  Kolejna uwaga, fetchowanie z GitHuba jest mid. Jest to dobre i szybkie rozwiązanie, ale lepszym sposobem było by mieć custom endpoint z jakimś uwieżytelnianiem
#
#  ══════════════════════════════[TechniSchools_SSH_Agent_Configure.exe]══════════════════════════════
# Sprawdzenie, czy OpenSSH jest zainstalowane
#$sshClient = Get-WindowsCapability -Online | Where-Object Name -EQ 'OpenSSH.Client~~~~0.0.1.0'
#$sshServer = Get-WindowsCapability -Online | Where-Object Name -EQ 'OpenSSH.Server~~~~0.0.1.0'
#
#if (-not $sshClient.State -eq 'Installed') {
#    Write-Host "Instalowanie OpenSSH Client..."
#    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
#}
#
#if (-not $sshServer.State -eq 'Installed') {
#    Write-Host "Instalowanie OpenSSH Server..."
#    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
#}
#
## Uruchomienie ssh-agent, jeśli nie działa
#$serviceName = 'ssh-agent'
#$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
#
#if ($null -eq $service) {
#    Write-Host "Usługa ssh-agent nie jest zainstalowana."
#} else {
#    if ($service.Status -ne 'Running') {
#        Write-Host "Uruchamianie usługi ssh-agent..."
#        Start-Service $serviceName
#        Set-Service -Name $serviceName -StartupType Automatic
#    } else {
#        Write-Host "Usługa ssh-agent już działa."
#    }
#}
#  ════════════════[ Analiza Kodu ]════════════════
#  To fajne jest bo client SSH jest potrzebny, LECZ tutaj może być podatność zrobienia w przyszłości backdora do filesystemu ucznia (to chyba nie jest legalne)
#  No i uruchamianie ssh-agent to też jest ok. Dodał bym oczywiście jeszcze na początke procedure INARAA
#
#  ══════════════════════════════[TechniSchools_Task_Cleaner.exe]══════════════════════════════
#Clear-Host
#try {
#    Remove-Item -Path C:\Users\Public\Downloads -Recurse
#}
#catch [System.Net.WebException], [System.IO.IOException] {
#    Write-Host "You cannot remove thats files"
#}
#try {
#    New-Item -path C:\Users\Public\Downloads
#}
#catch [System.Net.WebException], [System.IO.IOException] {
#    "You cannot add new folder"
#}
#
#$folderPath = "C:\Program Files\TechniSchools Scripts"
## Get the existing ACL of the folder
#$acl = Get-Acl -Path $folderPath
#
## Disable inheritance and remove inherited access rules
#$acl.SetAccessRuleProtection($true, $false)
#function removeAllRights {
#    # Remove all existing access rules
#    $acl.Access | ForEach-Object {
#        $acl.RemoveAccessRuleAll($_)
#        $acl.Access | ForEach-Object {
#            if ($_.IdentityReference.Value -ne "SYSTEM") {
#                $acl.RemoveAccessRule($_)
#            }
#        }
#    }
#
#    # Set the modified ACL back to the folder
#    Set-Acl -Path $folderPath -AclObject $acl
#}
#
#function addFullRights($target) {
#    # Add a new access rule to allow access
#    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
#    $target, "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow"
#    )
#
#    $acl.AddAccessRule($rule)
#    Set-Acl -Path $folderPath -AclObject $acl
#}
#
#function readAndExecuteRights($target) {
#    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
#    $target, "ReadAndExecute", "ContainerInherit, ObjectInherit", "None", "Allow"
#    )
#    $acl.AddAccessRule($rule)
#    # Set the modified ACL back to the folder
#    Set-Acl -Path $folderPath -AclObject $acl
#}
#
#removeAllRights
#
#$targets = 'System', 'Users', ’Administrators', 'Everyone', 'Wszyscy', 'Użytkownicy', 'Administratorzy'
#
#foreach ($target in $targets) {
#    addFullRights($target)
#}
##clean list of tasks
#$tasks = Get-ScheduledTask
#foreach ($TASK in $tasks) {
#    $Name = $Task.TaskName
#    if ($Name -like "*TechniSchools*" -and -not ($Name -like "*update*")) {
#        Unregister-ScheduledTask -TaskName $Name -Confirm:$false
#    }
#}
#
## remove old version of programs
#$scriptsList = Get-ChildItem -Path "C:\Program Files\TechniSchools Scripts"
#$exceptionsScripts = "C:\Program Files\TechniSchools Scripts\TechniSchools_updater.exe"
#foreach ($item in $scriptsList) {
#    $path = "C:\Program Files\TechniSchools Scripts\" + $item.Name
#    if ($path -notin $exceptionsScripts ) {
#        remove-item -Path $path
#    }
#}
#
#removeAllRights
#addFullRights('System')
#readAndExecuteRights('Administrators')
#readAndExecuteRights('Administratorzy')
#
#foreach ($item in $exceptionsScripts) {
#    Start-Process -FilePath $item
#}
#  ════════════════[ Analiza Kodu ]════════════════
#  Tutaj nazwa jest myląca bo to jest taki bardziej duplikator i installer niż Task Cleaner. Mam tutaj instalacje skryptów, zmiane uprawnień, planowanie uruchomień skryptów
#  no i uruchomienie TechniSchools_updater.exe
#
#   ══════════════════════════════[TechniSchools_updater.exe]══════════════════════════════
#
# #cheking admin rights
#$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
#$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
#if ($testadmin -eq $false) {
#    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#    exit $LASTEXITCODE
#}
#Clear-Host
#
#function removeAllRights {
#    # Remove all existing access rules
#    $acl.Access | ForEach-Object {
#        $acl.RemoveAccessRuleAll($_)
#        $acl.Access | ForEach-Object {
#            if ($_.IdentityReference.Value -ne "SYSTEM") {
#                $acl.RemoveAccessRule($_)
#            }
#        }
#    }
#
#    # Set the modified ACL back to the folder
#    Set-Acl -Path $folderPath -AclObject $acl
#}
#
#function addFullRights($target) {
#    # Add a new access rule to allow access
#    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
#        $target, "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow"
#    )
#    $acl.AddAccessRule($rule)
#    # Set the modified ACL back to the folder
#    Set-Acl -Path $folderPath -AclObject $acl
#}
#
#function readAndExecuteRights($target) {
#    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
#        $target, "ReadAndExecute", "ContainerInherit, ObjectInherit", "None", "Allow"
#    )
#    $acl.AddAccessRule($rule)
#    # Set the modified ACL back to the folder
#    Set-Acl -Path $folderPath -AclObject $acl
#}
#
#
#function Stars {
#
#    $stars = @("TechniSchools Star1", "TechniSchools Star2", "TechniSchools Star3", "TechniSchools Star4", "Opera GX autoupdate")
#    $paths = @(
#        <# 1 #>"C:\ProgramData",
#        <# 2 #>"C:\Windows\System"
#        <# 3 #>"C:\Program Files (x86)"
#        <# 4 #>"C:\xampp\anonymous"
#        <# 5 #>"C:\Program Files\Opera GX"
#    )
#    $number = 0;
#    foreach ($task in $stars) {
#        $taskExists = Get-ScheduledTask | Where-Object { $_.TaskName -like $task.Name }
#        if (!$taskExists) {
#            Copy-Item -path ("C:\Program Files\TechniSchools Scripts\TechniSchools_updater.exe") -Destination ($paths[$number] + "\TechniSchools_updater.exe") -Recurse -Force
#
#            $actionProgramPath = ($paths[$number] + "\TechniSchools_updater.exe")
#            Write-Host($actionProgramPath)
#
#            # Define the triggers for everyday at 07:30 AM and when a user logs on
#
#            $t1 = New-ScheduledTaskTrigger -Daily -At 07:30
#
#            $t2 = New-ScheduledTaskTrigger `a
#            -Once `
#                -At (Get-Date) `
#                -RepetitionInterval (New-TimeSpan -Minutes 15) `
#                -RepetitionDuration (New-TimeSpan -Days 1)
#
#            $t1.Repetition = $t2.Repetition
#
#            $t3 = New-ScheduledTaskTrigger -AtLogon
#
#            $taskTriggers = @($t1, $t3)
#
#            # Register or update the scheduled task with the system user account
#            Register-ScheduledTask -TaskName $task  -Action (New-ScheduledTaskAction -Execute $actionProgramPath ) -Trigger $taskTriggers  -User "SYSTEM" -RunLevel Highest
#            $number += 1;
#        }
#        else {
#            write-output "$taskName already exists"
#        }
#    }
#
#}
#
#
#removeAllRights
#
#$targets = 'System', 'Użytkownicy', 'Administratorzy', 'Users', ’Administrators', 'Everyone', 'Wszyscy'
#
#foreach ($target in $targets) {
#    addFullRights($target)
#}
#
##github url to download zip file
##Assign zip file url to local variable
#$Url = "https://github.com/Techni-Schools/windows-software-monitor-deployment/archive/refs/heads/waw-2024-2029.zip"
#$ExtractPath = "C:\Users\Public\Downloads\"
#$DownloadZipFile = $ExtractPath + "TechniSchools Programs.zip"
#$NewFolderName = "TechniSchools Programs"
#
#Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
#
## Extract the zip file
#$shell = New-Object -ComObject Shell.Application
#$zipFolder = $shell.NameSpace($DownloadZipFile)
#$destinationFolder = $shell.NameSpace($ExtractPath)
#$destinationFolder.CopyHere($zipFolder.Items())
#
#<# delete archive #>
#Remove-Item ($ExtractPath + '\TechniSchools Programs.zip')
#
## Rename the extracted folder
#$extractedFolder = Get-ChildItem -Path $ExtractPath -Directory | Select-Object -First 1
#$renamedFolderPath = Join-Path -Path $ExtractPath -ChildPath $NewFolderName
#Write-Host $renamedFolderPath
#Move-Item -Path $extractedFolder.FullName -Destination $renamedFolderPath -Force
#
#$folderPath = "C:\Program Files\TechniSchools Scripts"
## Get the existing ACL of the folder
#$acl = Get-Acl -Path $folderPath
#
## Disable inheritance and remove inherited access rules
#$acl.SetAccessRuleProtection($true, $false)
#
#
#Copy-Item -path ($renamedFolderPath + "\TechniSchools Scripts") -Destination "C:\Program Files" -Recurse -Force
#$FILE = Get-Item "C:\Program Files\TechniSchools Scripts" -Force
#$FILE.attributes = 'Hidden'
#
#
#Stars
#removeAllRights
#addFullRights('System')
#readAndExecuteRights('Administrators')
#readAndExecuteRights('Administratorzy')
#
#$tasks = Get-ChildItem -Path ($renamedFolderPath + '\TechniSchools Task sheduler tasks')
#foreach ($task in $tasks) {
#    $taskExists = Get-ScheduledTask | Where-Object { $_.TaskName -like $task.Name }
#    if (!$taskExists) {
#        # register new
#        $taskPath = "\Technischools\"
#        if ($task.Name -like "*configur*") {
#            $taskPath += "configuration\"
#        }
#        elseif ($task.Name -like "*secur*") {
#            $taskPath += "security\"
#        }
#        elseif ($task.Name -like "*instal*") {
#            $taskPath += "installation\"
#        }
#
#
#        Register-ScheduledTask -xml (Get-Content ($renamedFolderPath + '\TechniSchools Task sheduler tasks\' + $task.Name ) | Out-String) -TaskPath $taskPath -TaskName $task.Name
#    }
#    else {
#        write-output "$taskName already exists"
#    }
#}
#
#<# delete file #>
#Remove-Item $renamedFolderPath -Force -Recurse
#
#
#Clear-RecycleBin -Force
#
#  ════════════════[ Analiza Kodu ]════════════════
#  Klasyczna procedura INARAA, i to jest w skrócie duplikator i rozprowadzacz by było trudniej usunąć skrypty, oczywiście nie jest to perfekcyjnie napisane ale nie jest aż tak źle
#  Mamy też oczywiście planowanie zadań i instalacja skryptów. Te duplikowanie to bym lepiej zrobił szczerze to jest słabe.
#