FileDelete, %A_Desktop%/updt.ahk
FileDelete, %A_Desktop%/verlen.ini
buildscr = 3
downlurl = https://raw.githubusercontent.com/SergeySander/updater/master/updt.ahk
downllen = https://raw.githubusercontent.com/SergeySander/updater/master/verlen.ini
Utf8ToAnsi(ByRef Utf8String, CodePage = 1251)
{
If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
BOM = 3
Else
BOM = 0
UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "Int", 0, "Int", 0)
VarSetCapacity(UniBuf, UniSize * 2)
DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "UInt", &UniBuf, "Int", UniSize)
AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Int", 0, "Int", 0
, "Int", 0, "Int", 0)
VarSetCapacity(AnsiString, AnsiSize)
DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Str", AnsiString, "Int", AnsiSize
, "Int", 0, "Int", 0)
Return AnsiString
}
WM_HELP(){
IniRead, vupd, %A_Desktop%/verlen.ini, UPD, v
IniRead, desupd, %A_Desktop%/verlen.ini, UPD, des
desupd := Utf8ToAnsi(desupd)
IniRead, updupd, %A_Desktop%/verlen.ini, UPD, upd
updupd := Utf8ToAnsi(updupd)
updupd := Utf8ToAnsi(updupd)
msgbox, , ������ ��������� ������ %vupd%, %updupd%
return
}
OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs
SplashTextOn, , 60,��������������, ������ �������. ��������..`n��������� ������� ����������.
URLDownloadToFile, %downllen%, %A_Desktop%/verlen.ini
IniRead, buildupd, %A_Desktop%/verlen.ini, UPD, build
if buildupd =
{
SplashTextOn, , 60,��������������, ������ �������. ��������..`n������. ��� ����� � ��������.
sleep, 2000
}
if buildupd > % buildscr
{
IniRead, vupd, %A_Desktop%/verlen.ini, UPD, v
SplashTextOn, , 60,��������������, ������ �������. ��������..`n���������� ���������� �� ������ %vupd%!
sleep, 2000
IniRead, desupd, %A_Desktop%/verlen.ini, UPD, des
IniRead, updupd, %A_Desktop%/verlen.ini, UPD, upd
SplashTextoff
msgbox, 1, ���������� ������� �� ������ %vupd%, ���������� ?
IfMsgBox OK
{
put2 := % A_ScriptFullPath
RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\AHK ,put2 , % put2
SplashTextOn, , 60,��������������, ����������. ��������..`n��������� ������ �� ������ %vupd%!
URLDownloadToFile, %downlurl%, %A_Desktop%/updt.ahk
sleep, 1000
run, %A_Desktop%/updt.ahk
exitapp
}
IfMsgBox Cancel
{
SplashTextOn, , 60,��������������, �� � �����.`n���������� ������������...`nAHK �� �����������.
sleep 1500
exitapp
}
}
SplashTextoff
