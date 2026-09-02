@echo off
setlocal EnableDelayedExpansion
title BLACK_PSC_SP v3.0
color 0A
mode con cols=105 lines=35

:MENU
cls
echo.
echo  ================================================================
echo                 BLACK_PSC_SP v3.0
echo                 SECURITY TOOLKIT
echo  ================================================================
echo.
echo       [01] SYSTEM INFORMATION
echo       [02] NETWORK INFORMATION
echo       [03] DNS LOOKUP
echo       [04] CONNECTION TEST
echo       [05] SHOW NETWORK CONNECTIONS
echo       [06] FILE HASH SHA256
echo       [07] CHECK OPEN LOCAL PORTS
echo       [08] RUNNING PROCESSES
echo       [09] WINDOWS SERVICES
echo       [10] RANDOM SECURITY CHECK
echo.
echo       [99] EXIT
echo.
echo  ================================================================
echo.
set "choice="
set /p "choice=BLACK_PSC_SP^> "

if "%choice%"=="01" goto SYSTEM
if "%choice%"=="02" goto NETWORK
if "%choice%"=="03" goto DNS
if "%choice%"=="04" goto PING
if "%choice%"=="05" goto CONNECTIONS
if "%choice%"=="06" goto HASH
if "%choice%"=="07" goto PORTS
if "%choice%"=="08" goto PROCESS
if "%choice%"=="09" goto SERVICES
if "%choice%"=="10" goto RANDOM
if "%choice%"=="99" exit /b

goto MENU


:SYSTEM
cls
echo.
echo  [ SYSTEM INFORMATION ]
echo  ================================================================
echo.
systeminfo
echo.
pause
goto MENU


:NETWORK
cls
echo.
echo  [ NETWORK INFORMATION ]
echo  ================================================================
echo.
ipconfig /all
echo.
pause
goto MENU


:DNS
cls
echo.
echo  [ DNS LOOKUP ]
echo  ================================================================
echo.
set "host="
set /p "host=Entrez un domaine a analyser : "

if not defined host goto MENU

echo.
nslookup "%host%"
echo.
pause
goto MENU


:PING
cls
echo.
echo  [ CONNECTION TEST ]
echo  ================================================================
echo.
set "host="
set /p "host=Adresse a tester : "

if not defined host goto MENU

echo.
ping "%host%"
echo.
pause
goto MENU


:CONNECTIONS
cls
echo.
echo  [ NETWORK CONNECTIONS ]
echo  ================================================================
echo.
netstat -ano
echo.
pause
goto MENU


:HASH
cls
echo.
echo  [ SHA-256 FILE HASH ]
echo  ================================================================
echo.
set "file="
set /p "file=Chemin du fichier : "

if not exist "%file%" (
    echo.
    echo Fichier introuvable.
    pause
    goto MENU
)

echo.
certutil -hashfile "%file%" SHA256
echo.
pause
goto MENU


:PORTS
cls
echo.
echo  [ LOCAL PORT ANALYSIS ]
echo  ================================================================
echo.
echo Ports et connexions visibles sur cette machine :
echo.
netstat -ano
echo.
pause
goto MENU


:PROCESS
cls
echo.
echo  [ RUNNING PROCESSES ]
echo  ================================================================
echo.
tasklist
echo.
pause
goto MENU


:SERVICES
cls
echo.
echo  [ WINDOWS SERVICES ]
echo  ================================================================
echo.
sc query
echo.
pause
goto MENU


:RANDOM
cls
echo.
echo  [ RANDOM SECURITY CHECK ]
echo  ================================================================
echo.

set /a n=%random% %% 6

if %n%==0 (
    echo Analyse des processus...
    tasklist
)

if %n%==1 (
    echo Analyse reseau...
    netstat -ano
)

if %n%==2 (
    echo Analyse configuration IP...
    ipconfig
)

if %n%==3 (
    echo Analyse DNS...
    nslookup localhost
)

if %n%==4 (
    echo Analyse des services...
    sc query
)

if %n%==5 (
    echo Test de connexion locale...
    ping 127.0.0.1
)

echo.
echo  SECURITY CHECK COMPLETE.
pause
goto MENU