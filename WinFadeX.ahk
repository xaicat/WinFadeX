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