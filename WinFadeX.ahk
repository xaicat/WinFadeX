#SingleInstance Force
SetWorkingDir A_ScriptDir
Persistent

global processedWindows := Map()
SetTimer CheckNewWindows, 500

CheckNewWindows()
{
    windowList := WinGetList()
    for thisWindow in windowList
    {
        if processedWindows.Has(thisWindow)
            continue
        try {
            if (WinGetMinMax("ahk_id " thisWindow) = -1 || !WinExist("ahk_id " thisWindow))
                continue
            winTitle := WinGetTitle("ahk_id " thisWindow)
            if (winTitle = "Program Manager" || winTitle = "")
                continue
            WinSetTransparent 220, "ahk_id " thisWindow
            processedWindows[thisWindow] := true
        }
    }
}

^!RButton::{
    currentTransparency := WinGetTransparent("A")
    if (currentTransparency = "")
    {
        WinSetTransparent(220, "A")
    }
    else
    {
        WinSetTransparent("Off", "A")
    }
}
