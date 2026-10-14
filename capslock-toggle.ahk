; AutoHotkey v1.1 / Windows
; レジストリで CapsLock → RCtrl に変更したPC専用。
; VIAの CapsLock + Esc は Shift + CapsLock を送信する。
; レジストリ変換後の Shift + RCtrl を受け取り、CapsLockを切り替える。
; レジストリ未変更のPCでは起動不要。元の emacs.ahk との同時起動は避ける。

#NoEnv
#SingleInstance Force
#InstallKeybdHook
#UseHook

+RCtrl::
    GetKeyState, state, CapsLock, T
    if (state = "D")
        SetCapsLockState, Off
    else
        SetCapsLockState, On
    ; 長押しによる連続切替を防ぐ。
    KeyWait, RCtrl
return
