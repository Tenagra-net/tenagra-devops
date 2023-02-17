Param(
    [Switch]$dns = $false,
    [Switch]$dhcp = $false,
    [Switch]$tftp = $false,
    [Switch]$http = $false,
    [Switch]$noshell = $false
)

Write-Host "Welcome to the DevOps Build Environment."

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
if ($dns -or ("$env:TDK_DNS".ToUpper() -in ('TRUE', '1', 'Y', 'YES')))
{
    $profiles += '--profile dnsserver'
}
if ($dhcp -or ("$env:TDK_DHCP".ToUpper() -in ('TRUE', '1', 'Y', 'YES')))
{
    $profiles += '--profile dhcpserver'
}
if ($tftp -or ("$env:TDK_TFTP".ToUpper() -in ('true', '1', 'Y', 'YES')))
{
    $profiles += '--profile tftpserver'
}
if ($http -or ("$env:TDK_http".ToUpper() -in ('true', '1', 'Y', 'YES')))
{
    $profiles += '--profile webserver'
}

# Run the Toolkit container
try
{
    Push-Location ./services
    Invoke-Expression "docker compose $( $profiles -join ' ' ) build"
    if ($( Invoke-Expression "docker compose ls -q" ) -contains 'devopstdk')
    {
        Invoke-Expression "docker compose $( $profiles -join ' ' ) restart" | Out-Null
    }
    Invoke-Expression "docker compose $( $profiles -join ' ' ) up -d"
    if (!$noshell)
    {
        Invoke-Expression "docker compose run toolkit /bin/bash"
    }
}
finally
{
    if (!$noshell)
    {
        Invoke-Expression "docker compose $( $profiles -join ' ' ) down"
    }
    Pop-Location
}
