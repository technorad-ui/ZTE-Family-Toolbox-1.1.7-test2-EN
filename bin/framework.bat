::Chinese text: y

::call framework  startpre     skiptoolchk(Chinese text)
::                adbpre       [Chinese text all]
::                theme        Chinese text
::                conf         Chinese text         Chinese text        Chinese text
::                logviewer    end
::                loadcsvconf  csv Chinese text        [Chinese text]  [orig full](Chinese text)
::                chkdiskspace [Chinese text cur]         Chinese text

::start framework logviewer start                %logfile%


@ECHO OFF
chcp 65001 >nul
set args1=%1& set args2=%2& set args3=%3& set args4=%4& set args5=%5& set args6=%6& set args7=%7& set args8=%8& set args9=%9
goto %args1%




:CHKDISKSPACE
SETLOCAL
set logger=framework.bat-chkdiskspace
set letter=%args2%& set sizetocompare=%args3%
call log %logger% I Chinese text:letter:%letter%.sizetocompare:%sizetocompare%
if not "%letter%"=="cur" goto CHKDISKSPACE-1
set letter=
for %%a in ("%framework_workspace%") do set letter=%%~da
:CHKDISKSPACE-1
if "%letter%"=="" ECHOC {%c_e%}Chinese text{%c_i%}{\n}& call log %logger% F Chinese text& goto FATAL
call log %logger% I Chinese text %letter%
busybox.exe df -k 1>%tmpdir%\output.txt 2>&1 || type %tmpdir%\output.txt>>%logfile% && ECHOC {%c_e%}Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text&& goto FATAL
type %tmpdir%\output.txt>>%logfile%
set spaceleft_kb=
for /f "tokens=4 delims= " %%a in ('find "%letter%" "%tmpdir%\output.txt"') do set spaceleft_kb=%%a
if "%spaceleft_kb%"=="" ECHOC {%c_e%}Chinese text{%c_i%}{\n}& call log %logger% F Chinese text& goto FATAL
call calc m spaceleft nodec %spaceleft_kb% 1024
call calc numcomp %spaceleft% %sizetocompare%
if "%calc__numcomp__result%"=="greater" (set enough=y) else (set enough=n)
call log %logger% I Chinese text:%enough%. Chinese text:%spaceleft%. Chinese text:%sizetocompare%
ENDLOCAL & set framework__chkdiskspace__enough=%enough%& set framework__chkdiskspace__spaceleft=%spaceleft%
goto :eof


:LOADCSVCONF
SETLOCAL
set logger=framework.bat-loadcsvconf
set filepath=%args2%& set item=%args3%& set mode=%args4%
call log %logger% I Chinese text:filepath:%filepath%.item:%item%.mode:%mode%
if not exist %filepath% ECHOC {%c_e%}Chinese text %filepath%{%c_i%}{\n}& call log %logger% F Chinese text %filepath%& goto FATAL
if exist %tmpdir%\loadcsvconf.bat del %tmpdir%\loadcsvconf.bat 1>>%logfile% 2>&1
find "%item%" "%filepath%" 1>nul 2>nul || ECHOC {%c_e%}Chinese text %filepath% Chinese text %item%{%c_i%}{\n}&& call log %logger% F Chinese text %filepath% Chinese text %item%&& goto FATAL
set num=2
:LOADCSVCONF-1
if %num% GTR 31 ECHOC {%c_e%}Chinese text, Chinese text . Chinese text{%c_i%}{\n}& call log %logger% F Chinese text:%num% Chinese text . Chinese text:31 Chinese text& goto FATAL
set name=
for /f "tokens=%num% delims=[]," %%a in ('type %filepath% ^| find "],["') do set name=%%a
if "%name%"=="" goto LOADCSVCONF-2
for /f "tokens=%num% delims=," %%a in ('type %filepath% ^| find "%item%"') do set value=%%a
if "%mode%"=="orig" echo.set %name%=%value%|find "set" 1>>%tmpdir%\loadcsvconf.bat
if not "%mode%"=="orig" echo.set framework__loadcsvconf__%name%=%value%|find "set" 1>>%tmpdir%\loadcsvconf.bat
set /a num+=1& goto LOADCSVCONF-1
:LOADCSVCONF-2
ENDLOCAL
call %tmpdir%\loadcsvconf.bat
goto :eof


:LOGVIEWER
if "%args2%"=="end" taskkill /f /im busybox-bfflogviewer.exe 1>nul 2>nul & goto :eof
@ECHO OFF
COLOR 0F
TITLE BFF- Chinese text [Chinese text, Chinese text]
ECHO.
ECHO. Chinese text: %logfile%
ECHO.
call tool\Win\resizecmdwindow.exe -l 0 -r 70 -t 0 -b 20 -w 500 -h 800
tool\Win\busybox-bfflogviewer.exe tail -f %args3%
EXIT


:CONF
SETLOCAL
set logger=framework.bat-conf
call log %logger% I Chinese text conf\%args2% Chinese text %args3%. Chinese text %args4%
::if not exist conf\%args2% ECHOC {%c_e%}Chinese text conf\%args2%{%c_i%}{\n}& call log %logger% F Chinese text conf\%args2%& goto FATAL
if not exist conf\%args2% echo.>conf\%args2%
find "set %args3%=" "conf\%args2%" 1>nul 2>nul || echo.set %args3%=%args4%|findstr "set" 1>>conf\%args2%&& goto CONF-DONE
type conf\%args2% | find "set " | find /v "set %args3%=" 1>%tmpdir%\output.txt
echo.set %args3%=%args4%|findstr "set" 1>>%tmpdir%\output.txt
move /Y %tmpdir%\output.txt conf\%args2% 1>nul || ECHOC {%c_e%}Chinese text %tmpdir%\output.txt Chinese text conf\%args2% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\output.txt Chinese text conf\%args2% Chinese text&& goto FATAL
:CONF-DONE
ENDLOCAL
goto :eof


:THEME
set c_i=0F& set c_w=0E& set c_e=0C& set c_s=0A& set c_h=0D
if "%args2%"=="" set args2=%framework_theme%
if "%args2%"=="default" set c_i=0F& set c_w=0E& set c_e=0C& set c_s=0A& set c_h=0D& set c_a=0E& set c_we=07
if "%args2%"=="douyinhacker" set c_i=0A& set c_w=0E& set c_e=0C& set c_s=0F& set c_h=0D& set c_a=0E& set c_we=07
if "%args2%"=="ubuntu" set c_i=5F& set c_w=5E& set c_e=5C& set c_s=5A& set c_h=59& set c_a=5E& set c_we=5F
if "%args2%"=="classic" set c_i=3F& set c_w=3E& set c_e=3C& set c_s=3A& set c_h=3D& set c_a=3E& set c_we=3F
if "%args2%"=="gold" set c_i=8E& set c_w=E0& set c_e=CF& set c_s=A0& set c_h=6F& set c_a=8E& set c_we=8E
if "%args2%"=="dos" set c_i=1F& set c_w=1E& set c_e=1C& set c_s=A0& set c_h=80& set c_a=1E& set c_we=1F
if "%args2%"=="ChineseNewYear" set c_i=CF& set c_w=6F& set c_e=0F& set c_s=C0& set c_h=7C& set c_a=6F& set c_we=CF
goto :eof


:STARTPRE
if exist tool\logo.txt type tool\logo.txt
ECHO. Chinese text ...
::Chinese text path- Chinese text ...
set path=%path%||ECHO. Chinese text Path Chinese text . Chinese text&& goto FATAL
set path=%path%;%windir%\Sysnative
::ECHO. Chinese text find, findstr, copy, move, ren, del Chinese text ...
echo.test>bff_test1.tmp
find "test" "bff_test1.tmp"         1>nul || ECHO. Chinese text find Chinese text . Chinese text, Chinese text&& goto FATAL
findstr "test" "bff_test1.tmp"      1>nul || ECHO. Chinese text findstr Chinese text . Chinese text, Chinese text&& goto FATAL
copy /Y bff_test1.tmp bff_test2.tmp 1>nul || ECHO. Chinese text copy Chinese text . Chinese text, Chinese text&& goto FATAL
move /Y bff_test1.tmp bff_test2.tmp 1>nul || ECHO. Chinese text move Chinese text . Chinese text, Chinese text&& goto FATAL
ren bff_test2.tmp bff_test1.tmp     1>nul || ECHO. Chinese text ren Chinese text . Chinese text, Chinese text&& goto FATAL
del /F /Q bff_test1.tmp             1>nul || ECHO. Chinese text del Chinese text . Chinese text, Chinese text&& goto FATAL
::ECHO. Chinese text Windows Chinese text ...
for /f "tokens=4 delims=[] " %%a in ('ver ^| find " "') do set winver=%%a
::ECHO. Chinese text ...
for /f "tokens=2 delims=() " %%a in ('echo." %cd% "') do (if not "%%a"=="%cd%" ECHO. Chinese text& goto FATAL)
set framework_workspace=%cd%
::ECHO. Chinese text path- Chinese text ...
set path=%framework_workspace%;%framework_workspace%\tool\Win;%path%
::ECHO. Chinese text ECHOC...
ECHOC | find "Usage" 1>nul 2>nul || ECHO.ECHOC.exe Chinese text&& goto FATAL
::ECHO. Chinese text gettime...
if not exist tool\Win\gettime.exe ECHOC {%c_e%}Chinese text gettime.exe{%c_i%}{\n}& goto FATAL
gettime.exe | find "." 1>nul 2>nul || ECHOC {%c_e%}gettime.exe Chinese text{%c_i%}{\n}&& goto FATAL
::ECHO. Chinese text tmp Chinese text
if not exist tmp md tmp 1>nul || ECHOC {%c_e%}Chinese text tmp Chinese text{%c_i%}{\n}&& goto FATAL
if not "%framework_multitmpdir%"=="y" set framework_multitmpdir=n& set tmpdir=%framework_workspace%\tmp
if "%framework_multitmpdir%"=="y" (for /f %%a in ('gettime.exe ^| find "."') do set tmpdir=%framework_workspace%\tmp\%%a)
if not exist %tmpdir% md %tmpdir% 1>nul || ECHOC {%c_e%}Chinese text %tmpdir% Chinese text{%c_i%}{\n}&& goto FATAL
::ECHO. Chinese text ...
if not exist log.bat ECHOC {%c_e%}Chinese text log.bat{%c_i%}{\n}& goto FATAL
if "%framework_log%"=="n" set logfile=nul& set logger=CLOSED
if "%framework_log%"=="n" SETLOCAL & goto STARTPRE-2
if not exist log md log 1>nul || ECHOC {%c_e%}Chinese text log Chinese text{%c_i%}{\n}&& goto FATAL
for /f %%a in ('gettime.exe ^| find "."') do set logfile=%framework_workspace%\log\%%a.log
set logger=UNKNOWN
SETLOCAL
set logger=framework.bat-startpre
call log %logger% I Chinese text:%processor_architecture%.%winver%. Chinese text:%framework_workspace%
::ECHO. Chinese text ...
if "%framework_lognum%"=="" set framework_lognum=6
for /f %%a in ('dir /B log ^| find /C ".log"') do (if %%a LEQ %framework_lognum% goto STARTPRE-2)
for /f "tokens=1 delims=[]" %%a in ('dir /B log ^| find /N ".log"') do set /a var=%%a-%framework_lognum%
:STARTPRE-1
dir /B log | find /N ".log" | find "[%var%]" 1>nul 2>nul || goto STARTPRE-2
for /f "tokens=2 delims=[]" %%a in ('dir /B log ^| find /N ".log" ^| find "[%var%]"') do del log\%%a 1>nul
set /a var+=-1& goto STARTPRE-1
:STARTPRE-2
if "%args2%"=="skiptoolchk" call log %logger% I Chinese text& goto STARTPRE-DONE
::ECHO. Chinese text calc.bat...
if not exist calc.bat ECHOC {%c_e%}Chinese text calc.bat{%c_i%}{\n}& call log %logger% F Chinese text calc.bat& goto FATAL
::ECHO. Chinese text chkdev.bat...
if not exist chkdev.bat ECHOC {%c_e%}Chinese text chkdev.bat{%c_i%}{\n}& call log %logger% F Chinese text chkdev.bat& goto FATAL
::ECHO. Chinese text clean.bat...
if not exist clean.bat ECHOC {%c_e%}Chinese text clean.bat{%c_i%}{\n}& call log %logger% F Chinese text clean.bat& goto FATAL
::ECHO. Chinese text dl.bat...
if not exist dl.bat ECHOC {%c_e%}Chinese text dl.bat{%c_i%}{\n}& call log %logger% F Chinese text dl.bat& goto FATAL
::ECHO. Chinese text imgkit.bat...
if not exist imgkit.bat ECHOC {%c_e%}Chinese text imgkit.bat{%c_i%}{\n}& call log %logger% F Chinese text imgkit.bat& goto FATAL
::ECHO. Chinese text info.bat...
if not exist info.bat ECHOC {%c_e%}Chinese text info.bat{%c_i%}{\n}& call log %logger% F Chinese text info.bat& goto FATAL
::ECHO. Chinese text input.bat...
if not exist input.bat ECHOC {%c_e%}Chinese text input.bat{%c_i%}{\n}& call log %logger% F Chinese text input.bat& goto FATAL
::ECHO. Chinese text open.bat...
if not exist open.bat ECHOC {%c_e%}Chinese text open.bat{%c_i%}{\n}& call log %logger% F Chinese text open.bat& goto FATAL
::ECHO. Chinese text partable.bat...
if not exist partable.bat ECHOC {%c_e%}Chinese text partable.bat{%c_i%}{\n}& call log %logger% F Chinese text partable.bat& goto FATAL
::ECHO. Chinese text random.bat...
if not exist random.bat ECHOC {%c_e%}Chinese text random.bat{%c_i%}{\n}& call log %logger% F Chinese text random.bat& goto FATAL
::ECHO. Chinese text read.bat...
if not exist read.bat ECHOC {%c_e%}Chinese text read.bat{%c_i%}{\n}& call log %logger% F Chinese text read.bat& goto FATAL
::ECHO. Chinese text reboot.bat...
if not exist reboot.bat ECHOC {%c_e%}Chinese text reboot.bat{%c_i%}{\n}& call log %logger% F Chinese text reboot.bat& goto FATAL
::ECHO. Chinese text scrcpy.bat...
if not exist scrcpy.bat ECHOC {%c_e%}Chinese text scrcpy.bat{%c_i%}{\n}& call log %logger% F Chinese text scrcpy.bat& goto FATAL
::ECHO. Chinese text sel.bat...
if not exist sel.bat ECHOC {%c_e%}Chinese text sel.bat{%c_i%}{\n}& call log %logger% F Chinese text sel.bat& goto FATAL
::ECHO. Chinese text slot.bat...
if not exist slot.bat ECHOC {%c_e%}Chinese text slot.bat{%c_i%}{\n}& call log %logger% F Chinese text slot.bat& goto FATAL
::ECHO. Chinese text write.bat...
if not exist write.bat ECHOC {%c_e%}Chinese text write.bat{%c_i%}{\n}& call log %logger% F Chinese text write.bat& goto FATAL
::ECHO. Chinese text Notepad3...
::if not exist tool\Win\Notepad3\Notepad3.exe ECHOC {%c_e%}Chinese text Notepad3.exe{%c_i%}{\n}& call log %logger% F Chinese text Notepad3.exe& goto FATAL
::ECHO. Chinese text scrcpy...
::if not exist tool\Win\scrcpy\scrcpy.exe ECHOC {%c_e%}Chinese text scrcpy.exe{%c_i%}{\n}& call log %logger% F Chinese text scrcpy.exe& goto FATAL
::tool\Win\scrcpy\scrcpy.exe -h | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}scrcpy.exe Chinese text{%c_i%}{\n}&& call log %logger% F scrcpy.exe Chinese text&& goto FATAL
::ECHO. Chinese text Vieas...
::if not exist tool\Win\Vieas\Vieas.exe ECHOC {%c_e%}Chinese text Vieas.exe{%c_i%}{\n}& call log %logger% F Chinese text Vieas.exe& goto FATAL
::ECHO. Chinese text 7z...
::if not exist tool\Win\7z.dll ECHOC {%c_e%}Chinese text 7z.dll{%c_i%}{\n}& call log %logger% F Chinese text 7z.dll& goto FATAL
::if not exist tool\Win\7z.exe ECHOC {%c_e%}Chinese text 7z.exe{%c_i%}{\n}& call log %logger% F Chinese text 7z.exe& goto FATAL
::7z.exe | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}7z.exe Chinese text{%c_i%}{\n}&& call log %logger% F 7z.exe Chinese text&& goto FATAL
::ECHO. Chinese text adb...
if not exist tool\Win\adb.exe ECHOC {%c_e%}Chinese text adb.exe{%c_i%}{\n}& call log %logger% F Chinese text adb.exe& goto FATAL
if not exist tool\Win\AdbWinApi.dll ECHOC {%c_e%}Chinese text AdbWinApi.dll{%c_i%}{\n}& call log %logger% F Chinese text AdbWinApi.dll& goto FATAL
if not exist tool\Win\AdbWinUsbApi.dll ECHOC {%c_e%}Chinese text AdbWinUsbApi.dll{%c_i%}{\n}& call log %logger% F Chinese text AdbWinUsbApi.dll& goto FATAL
adb.exe start-server>nul
adb.exe devices | find "List of devices attached" 1>nul 2>nul || ECHOC {%c_e%}adb.exe Chinese text{%c_i%}{\n}&& call log %logger% F adb.exe Chinese text&& goto FATAL
::ECHO. Chinese text aria2c...
::if not exist tool\Win\aria2c.exe ECHOC {%c_e%}Chinese text aria2c.exe{%c_i%}{\n}& call log %logger% F Chinese text aria2c.exe& goto FATAL
::aria2c.exe -h | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}aria2c.exe Chinese text{%c_i%}{\n}&& call log %logger% F aria2c.exe Chinese text&& goto FATAL
::ECHO. Chinese text busybox...
if not exist tool\Win\busybox.exe ECHOC {%c_e%}Chinese text busybox.exe{%c_i%}{\n}& call log %logger% F Chinese text busybox.exe& goto FATAL
busybox.exe | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}busybox.exe Chinese text{%c_i%}{\n}&& call log %logger% F busybox.exe Chinese text&& goto FATAL
::ECHO. Chinese text busybox-bfflogviewer...
::if not exist tool\Win\busybox-bfflogviewer.exe ECHOC {%c_e%}Chinese text busybox-bfflogviewer.exe{%c_i%}{\n}& call log %logger% F Chinese text busybox-bfflogviewer.exe& goto FATAL
::busybox-bfflogviewer.exe | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}busybox-bfflogviewer.exe Chinese text{%c_i%}{\n}&& call log %logger% F busybox-bfflogviewer.exe Chinese text&& goto FATAL
::ECHO. Chinese text calc...
if not exist tool\Win\calc.exe ECHOC {%c_e%}Chinese text calc.exe{%c_i%}{\n}& call log %logger% F Chinese text calc.exe& goto FATAL
for /f %%a in ('calc.exe 2199023255552 m 999 6') do (if not "%%a"=="2196824232296448.000000" ECHOC {%c_e%}calc.exe Chinese text{%c_i%}{\n}& call log %logger% F calc.exe Chinese text& goto FATAL)
::ECHO. Chinese text curl...
::if not exist tool\Win\curl.exe ECHOC {%c_e%}Chinese text curl.exe{%c_i%}{\n}& call log %logger% F Chinese text curl.exe& goto FATAL
::curl.exe --help | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}curl.exe Chinese text{%c_i%}{\n}&& call log %logger% F curl.exe Chinese text&& goto FATAL
::ECHO. Chinese text devcon...
if not exist tool\Win\devcon.exe ECHOC {%c_e%}Chinese text devcon.exe{%c_i%}{\n}& call log %logger% F Chinese text devcon.exe& goto FATAL
devcon.exe help | find "Device" 1>nul 2>nul || ECHOC {%c_e%}devcon.exe Chinese text{%c_i%}{\n}&& call log %logger% F devcon.exe Chinese text&& goto FATAL
::ECHO. Chinese text fastboot...
if not exist tool\Win\fastboot.exe ECHOC {%c_e%}Chinese text fastboot.exe{%c_i%}{\n}& call log %logger% F Chinese text fastboot.exe& goto FATAL
fastboot.exe -h 2>&1 | find "usage" 1>nul 2>nul || ECHOC {%c_e%}fastboot.exe Chinese text{%c_i%}{\n}&& call log %logger% F fastboot.exe Chinese text&& goto FATAL
::ECHO. Chinese text fh_loader...
if not exist tool\Win\fh_loader.exe ECHOC {%c_e%}Chinese text fh_loader.exe{%c_i%}{\n}& call log %logger% F Chinese text fh_loader.exe& goto FATAL
fh_loader.exe -6 2>&1 | find "Base" 1>nul 2>nul || ECHOC {%c_e%}fh_loader.exe Chinese text{%c_i%}{\n}&& call log %logger% F fh_loader.exe Chinese text&& goto FATAL
::ECHO. Chinese text filedialog...
if not exist tool\Win\filedialog.exe ECHOC {%c_e%}Chinese text filedialog.exe{%c_i%}{\n}& call log %logger% F Chinese text filedialog.exe& goto FATAL
filedialog.exe 2>&1 | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}filedialog.exe Chinese text{%c_i%}{\n}&& call log %logger% F filedialog.exe Chinese text&& goto FATAL
::ECHO. Chinese text gpttool...
if not exist tool\Win\gpttool.exe ECHOC {%c_e%}Chinese text gpttool.exe{%c_i%}{\n}& call log %logger% F Chinese text gpttool.exe& goto FATAL
gpttool.exe -h 2>&1 | find "gpttool" 1>nul 2>nul || ECHOC {%c_e%}gpttool.exe Chinese text{%c_i%}{\n}&& call log %logger% F gpttool.exe Chinese text&& goto FATAL
::ECHO. Chinese text HexTool...
::if not exist tool\Win\HexTool.exe ECHOC {%c_e%}Chinese text HexTool.exe{%c_i%}{\n}& call log %logger% F Chinese text HexTool.exe& goto FATAL
::HexTool.exe | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}HexTool.exe Chinese text{%c_i%}{\n}&& call log %logger% F HexTool.exe Chinese text&& goto FATAL
::ECHO. Chinese text libcurl.def...
::if not exist tool\Win\libcurl.def ECHOC {%c_e%}Chinese text libcurl.def{%c_i%}{\n}& call log %logger% F Chinese text libcurl.def& goto FATAL
::ECHO. Chinese text libcurl.dll...
::if not exist tool\Win\libcurl.dll ECHOC {%c_e%}Chinese text libcurl.dll{%c_i%}{\n}& call log %logger% F Chinese text libcurl.dll& goto FATAL
::ECHO. Chinese text magiskboot...
if not exist tool\Win\magiskboot.exe ECHOC {%c_e%}Chinese text magiskboot.exe{%c_i%}{\n}& call log %logger% F Chinese text magiskboot.exe& goto FATAL
magiskboot.exe 2>&1 | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}magiskboot.exe Chinese text{%c_i%}{\n}&& call log %logger% F magiskboot.exe Chinese text&& goto FATAL
::ECHO. Chinese text numcomp...
if not exist tool\Win\numcomp.exe ECHOC {%c_e%}Chinese text numcomp.exe{%c_i%}{\n}& call log %logger% F Chinese text numcomp.exe& goto FATAL
numcomp.exe 999 888 | find "greater" 1>nul 2>nul || ECHOC {%c_e%}numcomp.exe Chinese text{%c_i%}{\n}&& call log %logger% F numcomp.exe Chinese text&& goto FATAL
::ECHO. Chinese text qcedlxmlhelper...
if not exist tool\Win\qcedlxmlhelper.exe ECHOC {%c_e%}Chinese text qcedlxmlhelper.exe{%c_i%}{\n}& call log %logger% F Chinese text qcedlxmlhelper.exe& goto FATAL
qcedlxmlhelper.exe 2>&1 | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}qcedlxmlhelper.exe Chinese text{%c_i%}{\n}&& call log %logger% F qcedlxmlhelper.exe Chinese text&& goto FATAL
::ECHO. Chinese text QCNTool...
::if not exist tool\Win\QCNTool.exe ECHOC {%c_e%}Chinese text QCNTool.exe{%c_i%}{\n}& call log %logger% F Chinese text QCNTool.exe& goto FATAL
::QCNTool.exe -h | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}QCNTool.exe Chinese text{%c_i%}{\n}&& call log %logger% F QCNTool.exe Chinese text&& goto FATAL
::ECHO. Chinese text QMSL_MSVC10R.dll...
::if not exist tool\Win\QMSL_MSVC10R.dll ECHOC {%c_e%}Chinese text QMSL_MSVC10R.dll{%c_i%}{\n}& call log %logger% F Chinese text QMSL_MSVC10R.dll& goto FATAL
::ECHO. Chinese text QSaharaServer...
if not exist tool\Win\QSaharaServer.exe ECHOC {%c_e%}Chinese text QSaharaServer.exe{%c_i%}{\n}& call log %logger% F Chinese text QSaharaServer.exe& goto FATAL
QSaharaServer.exe | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}QSaharaServer.exe Chinese text{%c_i%}{\n}&& call log %logger% F QSaharaServer.exe Chinese text&& goto FATAL
::ECHO. Chinese text resizecmdwindow...
::if not exist tool\Win\resizecmdwindow.exe ECHOC {%c_e%}Chinese text resizecmdwindow.exe{%c_i%}{\n}& call log %logger% F Chinese text resizecmdwindow.exe& goto FATAL
::resizecmdwindow.exe | find "usage" 1>nul 2>nul || ECHOC {%c_e%}resizecmdwindow.exe Chinese text{%c_i%}{\n}&& call log %logger% F resizecmdwindow.exe Chinese text&& goto FATAL
::ECHO. Chinese text simg_dump...
if not exist tool\Win\simg_dump.exe ECHOC {%c_e%}Chinese text simg_dump.exe{%c_i%}{\n}& call log %logger% F Chinese text simg_dump.exe& goto FATAL
simg_dump.exe 2>&1 | find "Usage" 1>nul 2>nul || ECHOC {%c_e%}simg_dump.exe Chinese text{%c_i%}{\n}&& call log %logger% F simg_dump.exe Chinese text&& goto FATAL
::ECHO. Chinese text strtofile...
if not exist tool\Win\strtofile.exe ECHOC {%c_e%}Chinese text strtofile.exe{%c_i%}{\n}& call log %logger% F Chinese text strtofile.exe& goto FATAL
if exist %tmpdir%\bff-test.txt del %tmpdir%\bff-test.txt 1>nul
echo.bff-test|strtofile.exe %tmpdir%\bff-test.txt || ECHOC {%c_e%}strtofile.exe Chinese text{%c_i%}{\n}&& call log %logger% F strtofile.exe Chinese text&& goto FATAL
for /f %%a in (%tmpdir%\bff-test.txt) do (if not "%%a"=="bff-test" ECHOC {%c_e%}strtofile.exe Chinese text{%c_i%}{\n}& call log %logger% F strtofile.exe Chinese text& goto FATAL)
del %tmpdir%\bff-test.txt 1>nul
::ECHO. Chinese text bootctl...
if not exist tool\Android\bootctl ECHOC {%c_e%}Chinese text bootctl{%c_i%}{\n}& call log %logger% F Chinese text bootctl& goto FATAL
::ECHO. Chinese text busybox...
if not exist tool\Android\busybox ECHOC {%c_e%}Chinese text busybox{%c_i%}{\n}& call log %logger% F Chinese text busybox& goto FATAL
::ECHO. Chinese text mke2fs...
if not exist tool\Android\mke2fs ECHOC {%c_e%}Chinese text mke2fs{%c_i%}{\n}& call log %logger% F Chinese text mke2fs& goto FATAL
::ECHO. Chinese text mkfs.exfat...
if not exist tool\Android\mkfs.exfat ECHOC {%c_e%}Chinese text mkfs.exfat{%c_i%}{\n}& call log %logger% F Chinese text mkfs.exfat& goto FATAL
::ECHO. Chinese text mkfs.fat...
if not exist tool\Android\mkfs.fat ECHOC {%c_e%}Chinese text mkfs.fat{%c_i%}{\n}& call log %logger% F Chinese text mkfs.fat& goto FATAL
::ECHO. Chinese text mkntfs...
if not exist tool\Android\mkntfs ECHOC {%c_e%}Chinese text mkntfs{%c_i%}{\n}& call log %logger% F Chinese text mkntfs& goto FATAL
::ECHO. Chinese text qualcomm_config.py...
if not exist tool\Other\qualcomm_config.py ECHOC {%c_e%}Chinese text qualcomm_config.py{%c_i%}{\n}& call log %logger% F Chinese text qualcomm_config.py& goto FATAL
:STARTPRE-DONE
call log %logger% I Chinese text
ENDLOCAL
goto :eof


:ADBPRE
call log framework.bat-adbpre I Chinese text:args2:%args2%
if "%args2%"=="" set args2=all
if "%args2%"=="all" (
    call write adbpush tool\Android\bootctl bootctl program
    call write adbpush tool\Android\busybox busybox program
    call write adbpush tool\Android\mke2fs mke2fs program
    call write adbpush tool\Android\mkfs.exfat mkfs.exfat program
    call write adbpush tool\Android\mkfs.fat mkfs.fat program
    call write adbpush tool\Android\mkntfs mkntfs program
    )
if not "%args2%"=="all" call write adbpush tool\Android\%args2% %args2% program
goto :eof





:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)
