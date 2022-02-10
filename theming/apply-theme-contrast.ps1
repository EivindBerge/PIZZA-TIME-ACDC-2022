$themePalette = @{
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

# Don't use real tenant names in public repos
Connect-PnPOnline https://CHANGETHIS.sharepoint.com/ -Interactive
# Inverted set to to true to ensure white/black in themes are handled correct
Add-PnPTenantTheme -Identity "TurtlePowerInverted" -Palette $themePalette -IsInverted $true