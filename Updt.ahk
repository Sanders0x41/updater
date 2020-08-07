updurl = https://github.com/SergeySander/updater/blob/master/TRKRitm.ahk
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nНастраиваем систему обновления.
RegWrite,REG_SZ ,HKEY_CURRENT_USER, SoftWare\AHK, put2, %A_Desktop%\TRKRitm.ahk
RegRead, put2, HKEY_CURRENT_USER, SoftWare\AHK, put2
sleep, 5000
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nСкачиваем обновленную версию.
URLDownloadToFile, %updurl%, %put2%
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nЗапускаем обновленную версию.
sleep, 3000
Run, % put2
ExitApp
