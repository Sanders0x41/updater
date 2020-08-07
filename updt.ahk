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


updurl = https://raw.githubusercontent.com/SergeySander/updater/master/TRKRitm.ahk
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nНастраиваем систему обновления.
RegWrite,REG_SZ ,HKEY_CURRENT_USER, SoftWare\AHK, put2, %A_Desktop%\TRKRitm.ahk
RegRead, put2, HKEY_CURRENT_USER, SoftWare\AHK, put2
sleep, 5000
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nСкачиваем обновленную версию.
URLDownloadToFile, %updurl%, %put2%
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nЗапускаем обновленную версию.
sleep, 3000
FileRead, Src, %A_Desktop%\TRKRitm.ahk
Ansi := Utf8ToAnsi(Src)  ; Преобразуем в Ansi.
FileAppend, %Ansi%, %A_Desktop%\TRKRitm.ahk
Run, % put2
