#SingleInstance Force
SetWorkingDir A_ScriptDir
Persistent

global processedWindows := Map()
global windowTransparency := Map()

; Timer to auto-apply transparency to new windows
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
            WinSetTransparent(220, "ahk_id " thisWindow)
            processedWindows[thisWindow] := true
            windowTransparency[thisWindow] := 220
        }
    }
}

; Ctrl+Alt+Right Click toggles transparency for the active window
^!RButton::{
    hwnd := WinExist("A")
    current := WinGetTransparent("ahk_id " hwnd)
    if (current = "")
    {
        WinSetTransparent(220, "ahk_id " hwnd)
        windowTransparency[hwnd] := 220
    }
    else
    {
        WinSetTransparent("Off", "ahk_id " hwnd)
        windowTransparency.Delete(hwnd)
    }
}

; Ctrl+Alt+Mouse Wheel Up/Down adjusts transparency
^!WheelUp::AdjustTransparency(+20)
^!WheelDown::AdjustTransparency(-20)

AdjustTransparency(delta) {
    hwnd := WinExist("A")
    if !hwnd
        return

    current := WinGetTransparent("ahk_id " hwnd)
    if (current = "")
        current := 255

    newTrans := Clamp(current + delta, 50, 255)
    WinSetTransparent(newTrans, "ahk_id " hwnd)
    windowTransparency[hwnd] := newTrans
}

Clamp(value, min, max) {
    return (value < min) ? min : (value > max) ? max : value
}
