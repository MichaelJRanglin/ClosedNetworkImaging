@echo off
setlocal EnableDelayedExpansion
SET count=1
SET Co=1
SET B=B
echo ************************************************
echo ************Avalue Image Station******************
echo ************************************************
echo
goto :Start

:Start
FOR  %%G IN (*.wim) DO call :L %%G 
Set /p K=Select Image and press enter.  
FOR  %%G IN (*.wim) DO call :List %%G
GOTO :eof

:L 
echo %count% %1
set /A count+=1
Goto :eof
 
:Pick 
REM set /A M=%count% 
REM call :Pick %%count
Goto :eof

:List 
if %K%==%Co% (Call :Check %1)
Set /a Co+=1
Goto :eof

:Check
Set /p V=You selected %1 Image. Is this correct?(Y/N)
if "%v%" == "n" (goto :Start)
if "%v%" == "no" (goto :Start)
if "%v%" == "y" (goto :Image %1)
if "%v%" == "yes" (goto :Image %1)

Goto :eof

:Image 

echo Partitioning in progress...
start /wait diskpart /s boot.txt
 
echo Imaging in progress...
imagex.exe /apply z:\%1 1 c:\
bcdedit /set {default} device partition=C:
bcdedit /set {default} osdevice partition=C:
echo Done!
wpeutil reboot
Goto :eof
