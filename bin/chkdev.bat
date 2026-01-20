::Chinese text: y

::call chkdev system       rechk(Chinese text)  Chinese text(Chinese text 3)
::            recovery     rechk(Chinese text)  Chinese text(Chinese text 3)
::            sideload     rechk(Chinese text)  Chinese text(Chinese text 3)
::            fastboot     rechk(Chinese text)  Chinese text(Chinese text 3)
::            fastbootd    rechk(Chinese text)  Chinese text(Chinese text 3)
::            qcedl        rechk(Chinese text)  Chinese text(Chinese text 3)
::            qcdiag       rechk(Chinese text)  Chinese text(Chinese text 3)
::            sprdboot     rechk(Chinese text)  Chinese text(Chinese text 3)
::            mtkbrom      rechk(Chinese text)  Chinese text(Chinese text 3)
::            mtkpreloader rechk(Chinese text)  Chinese text(Chinese text 3)
::            all          rechk(Chinese text)  Chinese text(Chinese text 3)

@ECHO OFF
chcp 65001 >nul
set args1=%1& set args2=%2& set args3=%3& set args4=%4& set args5=%5& set args6=%6& set args7=%7& set args8=%8& set args9=%9


SETLOCAL
set mode=%args1%
if "%args2%"=="rechk" (set rechk=y) else (set rechk=n)
if not "%args3%"=="" (set rechk_wait=%args3%) else (set rechk_wait=3)
::Chinese text, Chinese text 1 Chinese text . Chinese text, Chinese text (Chinese text, Chinese text).
set trytimes_max=30
set logger=chkdev.bat-%mode%
if not "%mode%"=="all" (goto CHKDEV-1) else (goto CHKDEV-2)
:CHKDEV-1
set keyword=
if "%mode%"=="system" set chktype=adb& set modename=Chinese text& set keyword=device
if "%mode%"=="recovery" set chktype=adb& set modename=Recovery Chinese text& set keyword=recovery
if "%mode%"=="sideload" set chktype=adb& set modename=ADB Sideload Chinese text& set keyword=sideload
if "%mode%"=="fastboot" set chktype=fastboot& set modename=Fastboot Chinese text& set keyword=fastboot
if "%mode%"=="fastbootd" set chktype=fastboot& set modename=FastbootD Chinese text& set keyword=fastboot
if "%mode%"=="qcedl" set chktype=port& set modename=9008 Chinese text
if "%mode%"=="qcdiag" set chktype=port& set modename=Chinese text
if "%mode%"=="sprdboot" set chktype=port& set modename=Chinese text boot Chinese text& set keyword=SPRD U2S Diag
if "%mode%"=="mtkbrom" set chktype=port& set modename=Chinese text brom Chinese text& set keyword=MediaTek USB Port 
if "%mode%"=="mtkpreloader" set chktype=port& set modename=Chinese text preloader Chinese text& set keyword= PreLoader USB VCOM 
if "%chktype%"=="" ECHOC {%c_e%}Chinese text{%c_i%}{\n}& call log %logger% F Chinese text& goto FATAL
call :chk%chktype%
if "%rechk%"=="n" goto DONE
ECHO.%rechk_wait% Chinese text, Chinese text ...& TIMEOUT /T %rechk_wait% /NOBREAK>nul & call :chk%chktype%
goto DONE
:CHKDEV-2
call :chkall
if "%rechk%"=="n" goto DONE
ECHO.%rechk_wait% Chinese text, Chinese text ...& TIMEOUT /T %rechk_wait% /NOBREAK>nul & call :chkall
goto DONE


:chkport
ECHOC {%c_i%}Chinese text: %modename%... {%c_i%}& call log %logger% I Chinese text:%mode%
set trytimes=1
::Chinese text
:chkport-1
::Chinese text
::if %trytimes% GTR %trytimes_max% ECHOC {%c_e%}Chinese text{%c_i%}{\n}& ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text:%mode%& pause>nul & goto chkport
::Chinese text
if "%mode%"=="qcedl"  devcon.exe listclass Ports 2>&1 | busybox egrep -n "Qualcomm HS-USB QDLoader 9008|Quectel QDLoader 9008" | find /n ":" 1>%tmpdir%\output.txt 2>&1
if "%mode%"=="qcdiag" devcon.exe listclass Ports 2>&1 | busybox egrep -n "Qualcomm HS-USB Android DIAG 901D|Qualcomm HS-USB Diagnostics|Qualcomm HS-USB MDM Diagnostics|ZTE Handset Diagnostic Interface|LGE Mobile USB Diagnostic Port|USB Diagnostics Port" | find /n ":" 1>%tmpdir%\output.txt 2>&1
if not "%mode%"=="qcedl" (
    if not "%mode%"=="qcdiag" (
        devcon.exe listclass Ports 2>&1 | busybox egrep -n "%keyword%" | find /n ":" 1>%tmpdir%\output.txt 2>&1))
::Chinese text
find "[1]" "%tmpdir%\output.txt" 1>nul 2>nul || set /a trytimes+=1&& goto chkport-1
find "[2]" "%tmpdir%\output.txt" 1>nul 2>nul && ECHOC {%c_we%} {%c_we%}{\n}&& type %tmpdir%\output.txt && ECHOC {%c_e%}Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& type %tmpdir%\output.txt>>%logfile%&& call log %logger% E Chinese text&& pause>nul && ECHOC {%c_i%}Chinese text ...{%c_i%}&& goto chkport-1
::Chinese text
busybox.exe sed -i "s/ /\r\n/g" %tmpdir%\output.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\output.txt Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\output.txt Chinese text&& goto FATAL
set port=
for /f "tokens=1 delims=(COM) " %%a in ('type %tmpdir%\output.txt ^| find "(COM"') do set port=%%a
if "%port%"=="" call log %logger% E Chinese text& goto chkport-1
::Chinese text
ECHOC {%c_s%}Chinese text (COM%port%){%c_i%}{\n}& call log %logger% I Chinese text:%mode%. Chinese text:%port%
goto :eof


:chkadb
ECHOC {%c_i%}Chinese text: %modename%... {%c_i%}& call log %logger% I Chinese text:%mode%
adb.exe start-server 1>>%logfile% 2>&1 || ECHO. && ECHOC {%c_e%}Chinese text adb Chinese text . Chinese text adb Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text adb Chinese text&& pause>nul && goto chkadb
set trytimes=1
::Chinese text
:chkadb-1
::Chinese text
if %trytimes% GTR %trytimes_max% ECHOC {%c_e%}Chinese text{%c_i%}{\n}& ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text:%mode%& pause>nul & goto chkadb
::Chinese text
adb.exe devices -l 2>&1 | find /v "List of devices attached" | find "%keyword%" | find /n "%keyword%" 1>%tmpdir%\output.txt 2>&1
::Chinese text
set num=
for /f "tokens=1 delims=[]" %%a in (%tmpdir%\output.txt) do set num=%%a
if "%num%"=="" set /a trytimes+=1& TIMEOUT /T 1 /NOBREAK>nul & goto chkadb-1
if not "%num%"=="1" ECHOC {%c_we%} {%c_we%}{\n}& type %tmpdir%\output.txt & ECHOC {%c_e%}Chinese text ADB Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& type %tmpdir%\output.txt>>%logfile%& call log %logger% E Chinese text ADB Chinese text& pause>nul & ECHOC {%c_i%}Chinese text ...{%c_i%}& goto chkadb-1
::Chinese text
ECHOC {%c_s%}Chinese text{%c_i%}{\n}& call log %logger% I Chinese text:%mode%
goto :eof


:chkfastboot
ECHOC {%c_i%}Chinese text: %modename%... {%c_i%}& call log %logger% I Chinese text:%mode%
set trytimes=1
::Chinese text
:chkfastboot-1
::Chinese text
if %trytimes% GTR %trytimes_max% ECHOC {%c_e%}Chinese text{%c_i%}{\n}& ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text:%mode%& pause>nul & goto chkfastboot
::Chinese text
fastboot.exe devices -l 2>&1 | find "%keyword%" | find /n "%keyword%" 1>%tmpdir%\output.txt 2>&1
::Chinese text
set num=
for /f "tokens=1 delims=[]" %%a in (%tmpdir%\output.txt) do set num=%%a
if "%num%"=="" set /a trytimes+=1& TIMEOUT /T 1 /NOBREAK>nul & goto chkfastboot-1
if not "%num%"=="1" ECHOC {%c_we%} {%c_we%}{\n}& type %tmpdir%\output.txt & ECHOC {%c_e%}Chinese text Fastboot Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& type %tmpdir%\output.txt>>%logfile%& call log %logger% E Chinese text Fastboot Chinese text& pause>nul & ECHOC {%c_i%}Chinese text ...{%c_i%}& goto chkfastboot-1
::Chinese text fastboot Chinese text fastbootd
set var=n
fastboot.exe getvar is-userspace 2>&1 | find /v "Finished." | find "is-userspace: yes" 1>nul 2>nul && set var=y
if "%mode%"=="fastboot" (if "%var%"=="y" set /a trytimes+=1& TIMEOUT /T 1 /NOBREAK>nul & goto chkfastboot-1)
if "%mode%"=="fastbootd" (if "%var%"=="n" set /a trytimes+=1& TIMEOUT /T 1 /NOBREAK>nul & goto chkfastboot-1)
::Chinese text
ECHOC {%c_s%}Chinese text{%c_i%}{\n}& call log %logger% I Chinese text:%mode%
goto :eof


:chkall
ECHOC {%c_i%}Chinese text: Chinese text ... {%c_i%}& call log %logger% I Chinese text:Chinese text
adb.exe start-server 1>>%logfile% 2>&1 || ECHO. && ECHOC {%c_e%}Chinese text adb Chinese text . Chinese text adb Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text adb Chinese text&& pause>nul && goto chkall
set trytimes=1
::Chinese text
:chkall-1
set devnum=0
::Chinese text
if %trytimes% GTR %trytimes_max% ECHOC {%c_e%}Chinese text{%c_i%}{\n}& ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text:Chinese text& pause>nul & goto chkall
::Chinese text
devcon.exe listclass Ports 2>&1 | busybox.exe grep -E "Qualcomm HS-USB QDLoader 9008|Quectel QDLoader 9008|SPRD U2S Diag|MediaTek USB Port | PreLoader USB VCOM " 2>>%logfile% | find /N "COM" 1>%tmpdir%\output.txt 2>nul
::Chinese text 1
set num=
for /f "tokens=1 delims=[] " %%a in (%tmpdir%\output.txt) do set num=%%a
if "%num%"=="" goto chkall-3
if not "%num%"=="1" ECHOC {%c_we%} {%c_we%}{\n}& ECHOC {%c_e%}Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text& pause>nul & ECHOC {%c_i%}Chinese text ...{%c_i%}& goto chkall-1
::Chinese text
find "MediaTek USB Port " "%tmpdir%\output.txt" 1>nul 2>nul && set /a devnum+=1&& set mode=mtkbrom&& set modename=Chinese text brom Chinese text&& set chktype=port&& goto chkall-2
find " PreLoader USB VCOM " "%tmpdir%\output.txt" 1>nul 2>nul && set /a devnum+=1&& set mode=mtkpreloader&& set modename=Chinese text preloader Chinese text&& set chktype=port&& goto chkall-2
find "Qualcomm HS-USB QDLoader 9008" "%tmpdir%\output.txt" 1>nul 2>nul && set /a devnum+=1&& set mode=qcedl&& set modename=9008 Chinese text&& set chktype=port&& goto chkall-2
find "Quectel QDLoader 9008" "%tmpdir%\output.txt" 1>nul 2>nul && set /a devnum+=1&& set mode=qcedl&& set modename=9008 Chinese text&& set chktype=port&& goto chkall-2
find "SPRD U2S Diag" "%tmpdir%\output.txt" 1>nul 2>nul && set /a devnum+=1&& set mode=sprdboot&& set modename=Chinese text boot Chinese text&& set chktype=port&& goto chkall-2
goto chkall-3
:chkall-2
::Chinese text
busybox.exe sed -i "s/ /\r\n/g" %tmpdir%\output.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\output.txt Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\output.txt Chinese text&& goto FATAL
set port=
for /f "tokens=1 delims=(COM) " %%a in ('type %tmpdir%\output.txt ^| find "(COM"') do set port=%%a
if "%port%"=="" ECHOC {%c_e%}Chinese text{%c_i%}{\n}& call log %logger% F Chinese text& goto FATAL
:chkall-3
::Chinese text fastboot Chinese text
fastboot.exe devices -l 2>&1 | find " fastboot" | find /n " fastboot" 1>%tmpdir%\output.txt 2>&1
::Chinese text fastboot Chinese text 1
set num=
for /f "tokens=1 delims=[] " %%a in (%tmpdir%\output.txt) do set num=%%a
if "%num%"=="" goto chkall-4
if not "%num%"=="1" ECHOC {%c_we%} {%c_we%}{\n}& ECHOC {%c_e%}Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text& pause>nul & ECHOC {%c_i%}Chinese text ...{%c_i%}& goto chkall-1
set /a devnum+=1
::Chinese text fastboot Chinese text
set mode=fastboot& set modename=Fastboot Chinese text& set chktype=fastboot
fastboot.exe getvar is-userspace 2>&1 | find /v "Finished." | find "is-userspace: yes" 1>nul 2>nul && set mode=fastbootd&& set modename=Fastbootd Chinese text&& set chktype=fastboot
:chkall-4
::Chinese text adb Chinese text
adb.exe devices -l 2>&1 | find /v "List of devices attached" | find " " | find /n " " 1>%tmpdir%\output.txt 2>&1
::Chinese text adb Chinese text 1
set num=
for /f "tokens=1,3 delims=[] " %%a in (%tmpdir%\output.txt) do set num=%%a& set var=%%b
if "%num%"=="" goto chkall-5
if not "%num%"=="1" ECHOC {%c_we%} {%c_we%}{\n}& ECHOC {%c_e%}Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text& pause>nul & ECHOC {%c_i%}Chinese text ...{%c_i%}& goto chkall-1
::Chinese text adb Chinese text
if "%var%"=="device" set /a devnum+=1& set mode=system& set modename=Chinese text& set chktype=adb
if "%var%"=="recovery" set /a devnum+=1& set mode=recovery& set modename=Recovery Chinese text& set chktype=adb
if "%var%"=="sideload" set /a devnum+=1& set mode=sideload& set modename=ADB Sideload Chinese text& set chktype=adb
:chkall-5
::Chinese text 1
if "%devnum%"=="0" set /a trytimes+=1& TIMEOUT /T 1 /NOBREAK>nul & goto chkall-1
if not "%devnum%"=="1" ECHOC {%c_we%} {%c_we%}{\n}& ECHOC {%c_e%}Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text& pause>nul & ECHOC {%c_i%}Chinese text ...{%c_i%}& goto chkall-1
::Chinese text
if not "%chktype%"=="port" (ECHOC {%c_s%}Chinese text: %modename%{%c_i%}{\n}& call log %logger% I Chinese text:%mode%) else (ECHOC {%c_s%}Chinese text: %modename% ^(COM%port%^){%c_i%}{\n}& call log %logger% I Chinese text:%mode%. Chinese text:%port%)
goto :eof


:DONE
if "%mode%"=="fastboot" (
    if "%product:~0,2%"=="NX" (
        call log %logger% I Chinese text . Chinese text
        fastboot.exe oem nubia_unlock NUBIA_%product% 1>>%logfile% 2>&1))
ENDLOCAL & set chkdev__mode=%mode%& set chkdev__port=%port%& set chkdev__port__%mode%=%port%
goto :eof








:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)

