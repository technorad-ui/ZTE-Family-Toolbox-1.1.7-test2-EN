::Chinese text: n

::call read system        Chinese text             Chinese text(Chinese text)                 noprompt(Chinese text)
::          recovery      Chinese text             Chinese text(Chinese text)                 noprompt(Chinese text)
::          qcedl         Chinese text             Chinese text(Chinese text)                 noprompt Chinese text notice   Chinese text(Chinese text auto)  Chinese text(Chinese text,Chinese text)
::          qcedlxml      Chinese text(Chinese text auto)  Chinese text(Chinese text auto)                    img Chinese text       xml Chinese text            Chinese text(Chinese text,Chinese text)
::          qcdiag        Chinese text(Chinese text auto)  Chinese text(Chinese text)                 noprompt(Chinese text)
::          adbpull       Chinese text          Chinese text(Chinese text)                 noprompt(Chinese text)

@ECHO OFF
chcp 65001 >nul
set args1=%1& set args2=%2& set args3=%3& set args4=%4& set args5=%5& set args6=%6& set args7=%7& set args8=%8& set args9=%9
goto %args1%





:ADBPULL
SETLOCAL
set logger=read.bat-adbpull
::Chinese text
set filepath=%args2%& set outputpath=%args3%& set mode=%args4%
call log %logger% I Chinese text:filepath:%filepath%.outputpath:%outputpath%.mode:%mode%
:ADBPULL-1
::Chinese text
if exist %outputpath% (if not "%mode%"=="noprompt" ECHOC {%c_w%}Chinese text %outputpath%, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text %outputpath%. Chinese text& pause>nul & ECHO. Chinese text ...)
::Chinese text
for %%a in ("%outputpath%") do set outputpath_fullname=%%~nxa
::Chinese text
for %%a in ("%outputpath%") do set var=%%~dpa
set outputpath_folder=%var:~0,-1%
::Chinese text
call log %logger% I Chinese text %filepath% Chinese text %outputpath%
cd /d %outputpath_folder% || ECHOC {%c_e%}Chinese text %outputpath_folder% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %outputpath_folder% Chinese text&& goto FATAL
adb.exe pull %filepath% %outputpath_fullname% 1>>%logfile% 2>&1 || cd /d %framework_workspace%&& ECHOC {%c_e%}Chinese text %filepath% Chinese text %outputpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text %outputpath% Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPULL-1
cd /d %framework_workspace% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& goto FATAL
::Chinese text
call log %logger% I Chinese text %filepath% Chinese text %outputpath% Chinese text
ENDLOCAL
goto :eof


:QCDIAG
SETLOCAL
set logger=read.bat-qcdiag
::Chinese text
set port=%args2%& set filepath=%args3%& set mode=%args4%
call log %logger% I Chinese text:port:%port%.filepath:%filepath%.mode:%mode%
:QCDIAG-1
::Chinese text
for %%a in ("%filepath%") do set filepath_fullname=%%~nxa
::Chinese text qcn Chinese text, qcn Chinese text
for %%a in ("%filepath%") do set var=%%~dpa
set filepath_folder=%var:~0,-1%
if not exist %filepath_folder% ECHOC {%c_e%}Chinese text %filepath_folder%{%c_i%}{\n}& call log %logger% F Chinese text %filepath_folder%& goto FATAL
if exist %filepath% (if not "%mode%"=="noprompt" ECHOC {%c_w%}Chinese text %filepath%, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text %filepath%. Chinese text& pause>nul & ECHO. Chinese text ...)
::Chinese text auto Chinese text
if "%port%"=="auto" call chkdev qcdiag 1>nul
if "%port%"=="auto" set port=%chkdev__port__qcdiag%
::Chinese text qcn
call log %logger% I Chinese text QCN Chinese text %filepath%
QCNTool.exe -r -p %port% -f %filepath_folder% -n %filepath_fullname% 1>%tmpdir%\output.txt 2>&1
::Chinese text: Chinese text IMEI, Chinese text, Chinese text type Chinese text
type %tmpdir%\output.txt>>%logfile%
find "Reading QCN from phone... OK" "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}Chinese text QCN Chinese text %filepath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text QCN Chinese text %filepath% Chinese text&& pause>nul && ECHO. Chinese text ... && goto QCDIAG-1
call log %logger% I Chinese text QCN Chinese text %filepath% Chinese text
ENDLOCAL
goto :eof


:QCEDL
SETLOCAL
set logger=read.bat-qcedl
::Chinese text
set parname=%args2%& set filepath=%args3%& set mode=%args4%& set port=%args5%& set fh=%args6%
call log %logger% I Chinese text:parname:%parname%.filepath:%filepath%.mode:%mode%.port:%port%.fh:%fh%
:QCEDL-1
::Chinese text
for %%a in ("%filepath%") do set filepath_fullname=%%~nxa
::Chinese text img Chinese text img Chinese text
for %%a in ("%filepath%") do set var=%%~dpa
set filepath_folder=%var:~0,-1%
if not exist %filepath_folder% ECHOC {%c_e%}Chinese text %filepath_folder%{%c_i%}{\n}& call log %logger% F Chinese text %filepath_folder%& goto FATAL
if exist %filepath% (if not "%mode%"=="noprompt" ECHOC {%c_w%}Chinese text %filepath%, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text %filepath%. Chinese text& pause>nul & ECHO. Chinese text ...)
::Chinese text auto Chinese text
if "%port%"=="auto" call chkdev qcedl 1>nul
if "%port%"=="auto" set port=%chkdev__port__qcedl%
if "%port%"=="" call chkdev qcedl 1>nul
if "%port%"=="" set port=%chkdev__port__qcedl%
::Chinese text
if not "%fh%"=="" call write qcedlsendfh %port% %fh% auto
::Chinese text
call info qcedl %port%
::Chinese text, Chinese text
if exist %tmpdir%\ptanalyse rd /s /q %tmpdir%\ptanalyse 1>>%logfile% 2>&1
md %tmpdir%\ptanalyse 1>>%logfile% 2>&1
set num=0
:QCEDL-2
if "%num%"=="%info__qcedl__lunnum%" ECHOC {%c_e%}Chinese text %parname%{%c_e%}& call log %logger% F Chinese text %parname%& goto FATAL
call log %logger% I Chinese text %num%
call partable readgpt qcedl %info__qcedl__memtype% %num% gptmain %tmpdir%\ptanalyse\gpt_main%num%.bin noprompt %port%
gpttool.exe -p %tmpdir%\ptanalyse\gpt_main%num%.bin -f print:default:#insl:sector:10 -o %tmpdir%\output.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %num% Chinese text{%c_e%}&& call log %logger% F Chinese text %num% Chinese text&& goto FATAL
set parsizesec=
for /f "tokens=4,5 delims= " %%a in ('type %tmpdir%\output.txt ^| find " %parname% "') do set parstartsec=%%a& set parsizesec=%%b
if "%parsizesec%"=="" set /a num+=1& goto QCEDL-2
::Chinese text, Chinese text
call log %logger% I Chinese text 9008 Chinese text %filepath%.lun:%num%. Chinese text:%parstartsec%. Chinese text:%parsizesec%
::Chinese text xml Chinese text, Chinese text xml
echo.^<?xml version="1.0" ?^>^<data^>^<program filename="%filepath_fullname%" physical_partition_number="%num%" label="%parname%" start_sector="%parstartsec%" num_partition_sectors="%parsizesec%" SECTOR_SIZE_IN_BYTES="%info__qcedl__secsize%" sparse="false"/^>^</data^>>%tmpdir%\tmp.xml
call read qcedlxml %port% %info__qcedl__memtype% %filepath_folder% %tmpdir%\tmp.xml
call log %logger% I 9008 Chinese text
ENDLOCAL
goto :eof


:QCEDLXML
SETLOCAL
set logger=read.bat-qcedlxml
::Chinese text
set port=%args2%& set memory=%args3%& set folderpath=%args4%& set xml=%args5%& set fh=%args6%
call log %logger% I Chinese text:port:%port%.memory:%memory%.folderpath:%folderpath%.xml:%xml%.fh:%fh%
:QCEDLXML-1
::Chinese text
if not exist %folderpath% ECHOC {%c_e%}Chinese text %folderpath%{%c_i%}{\n}& call log %logger% F Chinese text %folderpath%& goto FATAL
::Chinese text xml
echo.%xml%>%tmpdir%\output.txt
for /f %%a in ('busybox.exe sed "s/\//,/g" %tmpdir%\output.txt') do set xml=%%a
call log %logger% I xml Chinese text:
echo.%xml%>>%logfile%
::Chinese text auto Chinese text
if "%port%"=="auto" call chkdev qcedl 1>nul
if "%port%"=="auto" set port=%chkdev__port__qcedl%
::Chinese text
if not "%fh%"=="" call write qcedlsendfh %port% %fh% %memory%
::Chinese text auto Chinese text
if "%memory%"=="auto" (
    call log %logger% I Chinese text
    call info qcedl %port%)
if "%memory%"=="auto" (
    set memory=%info__qcedl__memtype%
    call log %logger% I Chinese text %info__qcedl__memtype%)
::Chinese text
::QSaharaServer.exe -p \\.\COM%port% -d | find "[portstatus]firehose" 1>nul 2>nul || ECHOC {%c_e%}Chinese text firehose Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text firehose Chinese text&& pause>nul && ECHO. Chinese text ... && goto QCEDLXML-1
::Chinese text
call log %logger% I Chinese text 9008 Chinese text
fh_loader.exe --port=\\.\COM%port% --memoryname=%memory% --sendxml=%xml% --convertprogram2read --mainoutputdir=%folderpath% --skip_config --showpercentagecomplete --noprompt 1>>%logfile% 2>&1 || ECHOC {%c_e%}9008 Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E 9008 Chinese text&& pause>nul && ECHO. Chinese text ... && goto QCEDLXML-1
move /Y %folderpath%\port_trace.txt %tmpdir% 1>>%logfile% 2>&1
call log %logger% I 9008 Chinese text
ENDLOCAL
goto :eof


:SYSTEM
SETLOCAL
set logger=read.bat-system
set target=./sdcard
goto ADBDD


:RECOVERY
SETLOCAL
set logger=read.bat-recovery
set target=./tmp
goto ADBDD


:ADBDD
::Chinese text
set parname=%args2%& set filepath=%args3%& set mode=%args4%
call log %logger% I Chinese text:parname:%parname%.filepath:%filepath%.mode:%mode%
:ADBDD-1
::Chinese text
::if not exist %filepath% ECHOC {%c_e%}Chinese text %filepath%{%c_i%}{\n}& call log %logger% F Chinese text %filepath%& goto FATAL
if exist %filepath% (if not "%mode%"=="noprompt" ECHOC {%c_w%}Chinese text %filepath%, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text %filepath%. Chinese text& pause>nul & ECHO. Chinese text ...)
::Chinese text Root
if "%target%"=="./sdcard" (
    call log %logger% I Chinese text Root
    echo.su>%tmpdir%\cmd.txt& echo.exit>>%tmpdir%\cmd.txt& echo.exit>>%tmpdir%\cmd.txt
    adb.exe shell < %tmpdir%\cmd.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text Root Chinese text . Chinese text Shell Chinese text Root Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text Root Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBDD-1)
::Chinese text
call info par %parname%
::Chinese text
if "%target%"=="./sdcard" echo.su>%tmpdir%\cmd.txt& echo.dd if=%info__par__path% of=%target%/%parname%.img >>%tmpdir%\cmd.txt
if "%target%"=="./tmp" echo.dd if=%info__par__path% of=%target%/%parname%.img >%tmpdir%\cmd.txt
echo.exit>>%tmpdir%\cmd.txt& echo.exit>>%tmpdir%\cmd.txt
call log %logger% I Chinese text %parname% Chinese text %target%/%parname%.img
adb.exe shell < %tmpdir%\cmd.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %parname% Chinese text %target%/%parname%.img Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %parname% Chinese text %target%/%parname%.img Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBDD-1
::Chinese text
call log %logger% I Chinese text %target%/%parname%.img Chinese text %filepath%
call read adbpull %target%/%parname%.img %filepath% noprompt
::Chinese text
call log %logger% I Chinese text %target%/%parname%.img
if "%target%"=="./sdcard" echo.su>%tmpdir%\cmd.txt& echo.rm %target%/%parname%.img>>%tmpdir%\cmd.txt
if "%target%"=="./tmp" echo.rm %target%/%parname%.img>%tmpdir%\cmd.txt
echo.exit>>%tmpdir%\cmd.txt& echo.exit>>%tmpdir%\cmd.txt
adb.exe shell < %tmpdir%\cmd.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %target%/%parname%.img Chinese text .{%c_i%}{\n}&& call log %logger% E Chinese text %target%/%parname%.img Chinese text
ENDLOCAL
goto :eof









:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)

