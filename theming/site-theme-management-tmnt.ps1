
# Install TMNT light/dark site designs
# Author: Mikael Svenson - @mikaelsvenson
# Blog: http://techmikael.com

<#
.SYNOPSIS
Script to install site designs in SPO
.Description
Install a light/dark site design in SharePoint Online
.Parameter url
The admin site url for SPO
.Parameter theme
Values: light/dark
.Example 
.\reindex-users-v2.ps1 -url https://contoso.sharepoint.com -tempPath D:\repos\SPO-Trigger-Reindex
Specify temp path
.Example 
.\reindex-users-v2.ps1 -url https://contoso.sharepoint.com
Use script path as the temp path
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$url,
    [ValidateSet('upload', 'apply')]
    [string]$operation = "apply",
    [ValidateSet('light', 'dark')]
    [string]$theme = "dark"
)

$VerbosePreference = "Continue"
Import-Module "PnP.PowerShell"
$VerbosePreference = "SilentlyContinue"

$themePaletteLight = @{
    "themePrimary"         = "#597a18";
    "themeLighterAlt"      = "#f7faf2";
    "themeLighter"         = "#e0eacc";
    "themeLight"           = "#c6d7a4";
    "themeTertiary"        = "#93af5b";
    "themeSecondary"       = "#6a8a29";
    "themeDarkAlt"         = "#516e16";
    "themeDark"            = "#445d13";
    "themeDarker"          = "#32450e";
    "neutralLighterAlt"    = "#faf9f8";
    "neutralLighter"       = "#f3f2f1";
    "neutralLight"         = "#edebe9";
    "neutralQuaternaryAlt" = "#e1dfdd";
    "neutralQuaternary"    = "#d0d0d0";
    "neutralTertiaryAlt"   = "#c8c6c4";
    "neutralTertiary"      = "#a19f9d";
    "neutralSecondary"     = "#605e5c";
    "neutralPrimaryAlt"    = "#3b3a39";
    "neutralPrimary"       = "#323130";
    "neutralDark"          = "#201f1e";
    "black"                = "#000000";
    "white"                = "#ffffff";
}

$themePaletteDark = @{
    "themePrimary"         = "#8fd129";
    "themeLighterAlt"      = "#fafdf5";
    "themeLighter"         = "#ebf8d8";
    "themeLight"           = "#daf1b7";
    "themeTertiary"        = "#b8e376";
    "themeSecondary"       = "#9ad740";
    "themeDarkAlt"         = "#80bc26";
    "themeDark"            = "#6c9f20";
    "themeDarker"          = "#507517";
    "neutralLighterAlt"    = "#0b0b0b";
    "neutralLighter"       = "#151515";
    "neutralLight"         = "#252525";
    "neutralQuaternaryAlt" = "#2f2f2f";
    "neutralQuaternary"    = "#373737";
    "neutralTertiaryAlt"   = "#595959";
    "neutralTertiary"      = "#c8c8c8";
    "neutralSecondary"     = "#d0d0d0";
    "neutralPrimaryAlt"    = "#dadada";
    "neutralPrimary"       = "#ffffff";
    "neutralDark"          = "#f4f4f4";
    "black"                = "#f8f8f8";
    "white"                = "#000000";
};

function UploadDesigns() {
    if ( $theme -eq "ligth") {
        Add-PnPTenantTheme -Identity "Turtle Power" -Palette $themePaletteLight -IsInverted $true
    }
    else {
        Add-PnPTenantTheme -Identity "Turtle Power Inverted" -Palette $themePaletteDark -IsInverted $true
    }
}

function ApplyToAllSites($urlFilter) {
    $sites = (Get-PnPTenantSite -Filter "Url -like $urlFilter" | Select-Object -ExpandProperty Url)
    $themeName = "Turtle Power"
    if ($theme -eq "dark") {
        $themeName += " Inverted"
    }
    foreach ($site in $sites) {
        Write-Host "Applying theme $theme to $site"
        Connect-PnPOnline $site -Credentials $cred
        Set-PnPWebTheme -Theme "Turtle Power Inverted"
    }
}

# Don't use real tenant names in public repos
if ( -not $url.Contains("-admin")) {
    Write-Warning "You need to connect to an admin site"
    return;
}

$myCredential = Get-AutomationPSCredential -Name 'SPO'
$userName = $myCredential.UserName
$securePassword = $myCredential.Password
$password = $myCredential.GetNetworkCredential().Password
$cred = New-Object System.Management.Automation.PSCredential ($userName,$securePassword)

Connect-PnPOnline $url -Credentials $cred

if ( $operation -eq 'upload') {
    UploadDesigns
}
else {
    $urlFilter = $url.replace("-admin", "")
    ApplyToAllSites -urlFilter $urlFilter
}