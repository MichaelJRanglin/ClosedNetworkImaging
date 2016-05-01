@echo off
setlocal EnableDelayedExpansion 
SET count=10
Set TIME=0
Set TIM=3
netcfg –winpe  
wpeutil InitializeNetwork ]

netsh interface ipv4 set address "Ethernet" static 169.254.255.9 255.255.0.0 
 
goto :T

:T  
set /A count+=1 
set "delay=1" seconds 

set /a delay+=1
ping 127.0.0.1 -n %delay% > nu
for /f %%i in ('ping -n 1 169.254.255.%count% ^| find /c "(0%% loss)"') do SET MATCHES=%%i 
[ping loop to determine if the current ip is taken or not, using % loss of packets]
if %MATCHES% == 1 goto :x
if %MATCHES% == 0 goto :T

goto :eof 

:x 
netsh interface ipv4 set address "Ethernet" static 169.254.255.%count% 255.255.0.0  

:V 
echo IP Address set!
set "delay=5" seconds
set /a delay+=1
ping 127.0.0.1 -n %delay% > nu

net use z: \\THESERVER-PC\image /user:Admin ""

echo Sync to Image server!
goto :eof

