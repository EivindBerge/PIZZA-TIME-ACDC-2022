$themePalette = @{
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

# Don't use real tenant names in public repos
Connect-PnPOnline https://CHANGETHIS.sharepoint.com/ -Interactive

# Inverted set to to false to ensure white/black in themes are handled correct
Add-PnPTenantTheme -Identity "Turtle Power" -Palette $themePalette -IsInverted $false