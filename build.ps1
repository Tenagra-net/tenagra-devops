Param(
    [Switch]$bootstrap = $false,
    [Switch]$dns = $false,
    [Switch]$dhcp = $false,
    [Switch]$tftp = $false,
    [Switch]$http = $false
)

Write-Host "Welcome to the Tenagra.net DevOps Build Environment."

# Prepare environment
if (Test-Path './.env')
{
    Select-String -Path './.env' -Pattern '^\s*[^\s=#]+=[^\s]+$' | ForEach-Object{
        $keyVal = $_ -split '=', 2
        $key = $( $keyVal[0].Trim() -split ":" )[-1]
        $val = $keyVal[1].Trim("'").Trim('"')
        [Environment]::SetEnvironmentVariable($key, $val)
    }
}

# Prepare environment
$profiles = @()
$TR
if ($bootstrap -or $dns -or ("$env:TDK_DNS".ToUpper() -in ('TRUE', '1', 'Y', 'YES')))
{
    $profiles += '--profile dnsserver'
}
if ($bootstrap -or $dhcp -or ("$env:TDK_DHCP".ToUpper() -in ('TRUE', '1', 'Y', 'YES')))
{
    $profiles += '--profile dhcpserver'
}
if ($bootstrap -or $tftp -or ("$env:TDK_TFTP".ToUpper() -in ('true', '1', 'Y', 'YES')))
{
    $profiles += '--profile tftpserver'
}
if ($bootstrap -or $http -or ("$env:TDK_http".ToUpper() -in ('true', '1', 'Y', 'YES')))
{
    $profiles += '--profile webserver'
}

# Run the Toolkit container
Push-Location ./services
Register-EngineEvent PowerShell.Exiting -Action { Pop-Location } | Out-Null

Invoke-Expression "docker compose build"
Invoke-Expression "docker compose $( $profiles -join ' ' ) up -d"
Invoke-Expression "docker compose run toolkit /bin/bash"
Invoke-Expression "docker compose $( $profiles -join ' ' ) down"
