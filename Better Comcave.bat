:: Hello Comcave. How are you?
:: This little and dirty script is nothing about you, but there is an problem :(
:: There are several days where is nothing to do!
:: But i must sit at home to make sure that i can solve your CCLauncher Captchas.
:: That´s ok but Captchas are for Bots and not for Humans :p
:: Those things steal my time, that i can 
:: "use for Playing xBox"
:: "use with my family"
:: "use with my dog or cat"
:: and if i really nothing to do, maybe i use my free time with my wife. <3
::
:: Anyway this is the simplest solution to trick your CC-Launcher.
:: Please don´t change your running system.
:: I wouldn´t like it, when i must use my free time to write another script that will simply solve your captchas.
::
:: Stay fresh an be cool!
:: Anyone including you and your technicals can learning from those things and can search for new things to prevent such actions.
::
@echo off
SETLOCAL enableextensions enabledelayedexpansion

set EXE=CCLauncher_Client.exe
set START_CCLauncher="" "C:\CCLauncher_Client\CCLauncher_Client.exe"

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
:: As user requests, i moved the restart interval to an random time between 10 to 60 minutes.
set /a rand=%random%%% 3001 +600
echo Script startet in %rand% Sekunden automatisch von neuem.
echo Enter zum sofortigen Neustart.
timeout /t %rand%
taskkill /f /im %EXE% >nul
:: make sure launcher is closed
timeout /t 3
%0