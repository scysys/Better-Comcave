@echo off
SETLOCAL enableextensions enabledelayedexpansion

::CC Launcher Prozess
set EXE=java.exe
::CC Launcher Pfad
set START_CCLauncher="" "C:\CCLauncher-Client-3\CCLauncher_Client_3.0.exe"

SET MINUTEN_BIS_STUNDE=60
set MULTI=60
GOTO SKIP
:ABFRAGE
del %USERPROFILE%\CC_Launcher_Client\.controlgui\logs\resultsall.txt
del %USERPROFILE%\CC_Launcher_Client\.controlgui\logs\resultstrue.txt
SET /A MINUTEN_BIS_STUNDE-=%_minute%
set /A MINUTEN_BIS_STUNDE*=%MULTI%
TASKKILL /F /IM %EXE% >nul
timeout /t 3
echo Abfrage: Launcherrestart.
echo abbrechen mit STRG + C
start %START_CCLauncher%

set string=CCLauncher wurde erfolgreich gestartet. Die Automatische Eingabe der Zugangsdaten wird gestartet.

for /L %%a in (1, 1, 100) do (
set sting=!string:~0,%%a! 
echo ^>!sting!
ping localhost -n 1 >nul
if %%a GEQ 100 goto SEK

:SEK
timeout /t 7
wscript "userinput.vbs"
timeout /t %MINUTEN_BIS_STUNDE%

SET MINUTEN_BIS_STUNDE=60

cls 
goto END

)



GOTO END
:KEINEABFRAGE
del %USERPROFILE%\CC_Launcher_Client\.controlgui\logs\resultsall.txt
del %USERPROFILE%\CC_Launcher_Client\.controlgui\logs\resultstrue.txt
cls 
echo Keine Abfrage Check Restart.
echo abbrechen mit STRG + C
timeout /t 20
GOTO END

:SKIP

FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto ComcaveFound

goto ComcaveNotFound

:ComcaveFound
set string=CCLauncher ist aktiv und muss nicht gestartet werden.

for /L %%a in (1, 1, 100) do (
set sting=!string:~0,%%a! 
echo ^>!sting!
ping localhost -n 1 >nul
if %%a GEQ 100 goto END
cls 
)

:ComcaveNotFound
set string=CCLauncher ist nicht aktiv :(

for /L %%a in (1, 1, 100) do (
set sting=!string:~0,%%a! 
echo ^>!sting!
ping localhost -n 1 >nul
if %%a GEQ 100 goto OpenComcave
cls 
)

:OpenComcave
start %START_CCLauncher%

set string=CCLauncher wurde erfolgreich gestartet. Die Automatische Eingabe der Zugangsdaten wird gestartet.

for /L %%a in (1, 1, 100) do (
set sting=!string:~0,%%a! 
echo ^>!sting!
ping localhost -n 1 >nul
if %%a GEQ 100 goto UserDetails
cls 
)

:UserDetails
:: i have no plan how to do it in batch. so we use vbscript for input of your details (username / password)
wscript "userinput.vbs"
goto END

:END


:: Check WMIC is available



WMIC.EXE Alias /? >NUL 2>&1 || GOTO s_error

:: Use WMIC to retrieve date and time
FOR /F "skip=1 tokens=1-6" %%G IN ('WMIC Path Win32_LocalTime Get Day^,Hour^,Minute^,Month^,Second^,Year /Format:table') DO (
   IF "%%~L"=="" goto s_done
      Set _yyyy=%%L
      Set _mm=00%%J
      Set _dd=00%%G
      Set _hour=00%%H
      SET _minute=00%%I
)
:s_done

:: Pad digits with leading zeros
      Set _mm=%_mm:~-2%
      Set _dd=%_dd:~-2%
      Set _hour=%_hour:~-2%
      Set _minute=%_minute:~-2%

:: Display the date/time in ISO 8601 format:

Set _isodate=%_yyyy%-%_mm%-%_dd% %_hour%:
Set _text="INFO  [Timer-2] sound.PlaySound (PlaySound.java:70) - Sound stop: ping.mp3"
Echo.:%_text%:
Echo %_isodate%
Echo %_hour%

findstr /C:"%_isodate%" %USERPROFILE%\CC_Launcher_Client\.controlgui\logs\app.log > %USERPROFILE%\CC_Launcher_Client\.controlgui\logs\resultsall.txt
findstr /C:"INFO  [Timer-2] sound.PlaySound (PlaySound.java:70) - Sound stop: ping.mp3" %USERPROFILE%\CC_Launcher_Client\.controlgui\logs\resultsall.txt > %USERPROFILE%\CC_Launcher_Client\.controlgui\logs\resultstrue.txt
if %errorlevel%==0 (
GOTO ABFRAGE
) else (
GOTO KEINEABFRAGE
)




:: As user requests, i moved the restart interval to an random time between 10 to 60 minutes.
::set /a rand=%random%%% 3001 +600
::echo Script startet in %rand% Sekunden automatisch von neuem.
::echo Enter zum sofortigen Neustart.
::timeout /t %rand%
::taskkill /f /im %EXE% >nul
:: make sure launcher is closed
::timeout /t 3
::%0