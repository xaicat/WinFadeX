## ⚡ WinFadeX

**WinFadeX** is a powerful yet lightweight AutoHotkey script that brings dynamic window transparency and overlay effects to your Windows desktop. Automatically fade in new windows, manually adjust opacity, or apply fullscreen/active overlays — all with simple hotkeys. Perfect for multitaskers, minimalists, and productivity enthusiasts.

---

## ✨ Features

- **🪟 Auto Transparency**  
  Automatically fades in newly opened windows to a semi-transparent state.

- **🎛 Manual Transparency Toggle**  
  Instantly toggle transparency for any active window using a hotkey.

- **🌀 Adjustable Transparency**  
  Fine-tune transparency with mouse wheel shortcuts.

- **🧠 Smart Detection**  
  System windows, desktop, and overlay windows are automatically excluded.

- **📐 Overlay Modes**  
  - Create fullscreen color overlays (Dark Blue, Green, Purple, Red).
  - Also have options to apply overlays on top of individual active windows.

- **📉 Focus Mode**  
  Minimize all windows except the currently active one.

- **⚡ Lightweight**  
  Runs silently in the background with minimal resource usage.

---

## 🔧 Usage

1. **Launch** the script by running `WinFadeX.ahk`.
2. The script runs continuously in the background.
3. Use the hotkeys below to control window fading, overlays, and focus.

---

## ⌨️ Hotkeys Reference

| Hotkey                      | Action Description                                    |
|----------------------------|--------------------------------------------------------|
| `Ctrl + Alt + Right Click` | Toggle transparency for the active window             |
| `Ctrl + Alt + Wheel Up`    | Increase transparency (make window more opaque)       |
| `Ctrl + Alt + Wheel Down`  | Decrease transparency (make window more transparent)  |
| `Ctrl + Alt + M`           | Minimize all windows except the active one            |
| `Ctrl + Alt + 1`           | Toggle fullscreen overlay - Dark Blue                 |
| `Ctrl + Alt + 2`           | Toggle fullscreen overlay - Dark Green                |
| `Ctrl + Alt + 3`           | Toggle fullscreen overlay - Dark Purple               |
| `Ctrl + Alt + 4`           | Toggle fullscreen overlay - Dark Red                  |
| `Ctrl + Alt + 0`           | Remove the fullscreen overlay                         |
| `Ctrl + Alt + O`           | Apply dark overlay to current active window only      |
| `Ctrl + Alt + Shift + O`   | Remove all active window overlays                     |

---

## 💡 Ideal For

- **Developers** juggling multiple windows and terminals.
- **Designers** aiming for aesthetic, minimal desktops.
- **Streamers** or **presenters** using overlays for focus.
- **Productivity lovers** who want a cleaner workspace.

---

## 📁 Installation

1. Ensure [AutoHotkey](https://www.autohotkey.com/) is installed.
2. Download or clone this repository.
3. Double-click `WinFadeX.ahk` to launch the script.
4. Optionally, add the script to your startup for automatic launch on boot.

---

## 🧠 Notes

- Transparency levels are clamped between 50 (most transparent) and 255 (fully opaque).
- Overlays are non-interactive and always on top but can be dismissed with assigned hotkeys.
- Smart detection avoids applying transparency to system-reserved windows or overlays.

---

## 🤝 Contribution

Feel free to fork, improve, and submit PRs. Suggestions and feedback are welcome!

---

## 📜 License

This project is licensed under the **Creative Commons Attribution 4.0 International (CC BY 4.0)** license.

You are free to use, share, and modify this script, even for commercial purposes — **but you must give appropriate credit**. If you publish or share this project elsewhere, please include a link to the original [GitHub repository](https://github.com/xaicat/WinFadeX) and credit the author.

© xaicat 2025


