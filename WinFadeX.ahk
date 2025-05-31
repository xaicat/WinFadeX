#SingleInstance Force
SetWorkingDir A_ScriptDir
Persistent

global processedWindows := Map()
global windowTransparency := Map()
global fullscreenOverlay := {active: false, hwnd: 0, title: ""}
global activeOverlayMap := Map()

SetTimer CheckNewWindows, 500

CheckNewWindows()
{
    global processedWindows, windowTransparency
    windowList := WinGetList()
    for thisWindow in windowList
    {
        if processedWindows.Has(thisWindow)
            continue
        try {
            if (WinGetMinMax("ahk_id " thisWindow) = -1 || !WinExist("ahk_id " thisWindow))
                continue

            winTitle := WinGetTitle("ahk_id " thisWindow)
            if (winTitle = "Program Manager" || winTitle = "" || InStr(winTitle, "FullscreenOverlay") || InStr(winTitle, "ActiveOverlay"))
                continue

            WinSetTransparent(220, "ahk_id " thisWindow)
            processedWindows[thisWindow] := true
            windowTransparency[thisWindow] := 220
        }
    }
}

; Toggle transparency for active window (except overlays)
^!RButton:: {
    hwnd := WinExist("A")
    winTitle := WinGetTitle("ahk_id " hwnd)
    if (InStr(winTitle, "Overlay"))
        return

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

; Adjust transparency using mouse wheel
^!WheelUp::AdjustTransparency(+5)
^!WheelDown::AdjustTransparency(-5)

AdjustTransparency(delta) {
    hwnd := WinExist("A")
    winTitle := WinGetTitle("ahk_id " hwnd)
    if (!hwnd || InStr(winTitle, "Overlay"))
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

; Minimize all windows except the active one
^!m:: {
    activeHwnd := WinExist("A")
    if (!activeHwnd)
        return

    windowList := WinGetList()
    for hwnd in windowList {
        if (hwnd != activeHwnd) {
            try WinMinimize("ahk_id " hwnd)
        }
    }
}

; Ctrl + Alt + 1 - Create fullscreen dark blue overlay
^!1:: {
    global fullscreenOverlay
    if (fullscreenOverlay.hwnd) {
        try WinClose("ahk_id " fullscreenOverlay.hwnd)
        fullscreenOverlay := {active: false, hwnd: 0, title: ""}
    }    
    if (fullscreenOverlay.active)
        return
    CreateFullscreenOverlay("000033", "FullscreenOverlay-Blue")
}

; Ctrl + Alt + 2 - Create fullscreen dark green overlay
^!2:: {
    global fullscreenOverlay
    if (fullscreenOverlay.hwnd) {
        try WinClose("ahk_id " fullscreenOverlay.hwnd)
        fullscreenOverlay := {active: false, hwnd: 0, title: ""}
    }
    if (fullscreenOverlay.active)
        return
    CreateFullscreenOverlay("003300", "FullscreenOverlay-Green")
}

; Ctrl + Alt + 3 - Create fullscreen dark purple overlay
^!3:: {
    global fullscreenOverlay
    if (fullscreenOverlay.hwnd) {
        try WinClose("ahk_id " fullscreenOverlay.hwnd)
        fullscreenOverlay := {active: false, hwnd: 0, title: ""}
    }
    if (fullscreenOverlay.active)
        return
    CreateFullscreenOverlay("33001c", "FullscreenOverlay-Green")
}

; Ctrl + Alt + 4 - Create fullscreen dark red overlay
^!4:: {
    global fullscreenOverlay
    if (fullscreenOverlay.hwnd) {
        try WinClose("ahk_id " fullscreenOverlay.hwnd)
        fullscreenOverlay := {active: false, hwnd: 0, title: ""}
    }
    if (fullscreenOverlay.active)
        return
    CreateFullscreenOverlay("332900", "FullscreenOverlay-Green")
}

; Remove fullscreen overlay
^!0:: {
    global fullscreenOverlay
    if (fullscreenOverlay.hwnd) {
        try WinClose("ahk_id " fullscreenOverlay.hwnd)
        fullscreenOverlay := {active: false, hwnd: 0, title: ""}
    }
}

CreateFullscreenOverlay(color, title) {
    global fullscreenOverlay
    screenWidth := SysGet(78)
    screenHeight := SysGet(79)

    overlay := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20 +LastFound", title)
    overlay.BackColor := color
    overlay.Show("x0 y0 w" screenWidth " h" screenHeight)

    overlayHwnd := WinExist()
    WinSetTransparent(51, "ahk_id " overlayHwnd)  ; 20% opacity
    fullscreenOverlay := {active: true, hwnd: overlayHwnd, title: title}
}

; Ctrl + Alt + o - Overlay active window only (dark blue)
^!o:: {
    global activeOverlayMap
    hwnd := WinExist("A")
    if (!hwnd || activeOverlayMap.Has(hwnd))
        return

    WinGetPos(&x, &y, &w, &h, "ahk_id " hwnd)
    overlay := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20 +LastFound", "ActiveOverlay-" hwnd)
    overlay.BackColor := "000013"
    overlay.Show("x" x " y" y " w" w " h" h)

    overlayHwnd := WinExist()
    WinSetTransparent(51, "ahk_id " overlayHwnd)
    activeOverlayMap[hwnd] := overlayHwnd
}

; Ctrl + Alt + Shift + o - Remove all active window overlays
^!+o:: {
    global activeOverlayMap
    for _, overlayHwnd in activeOverlayMap {
        try WinClose("ahk_id " overlayHwnd)
    }
    activeOverlayMap := Map()
}
