@ECHO OFF
chcp 65001 >nul
mode con cols=71
COLOR 0F
TITLE BFF- Chinese text

cd /d %~dp0 1>nul 2>nul
if exist bin (cd bin) else (ECHO. Chinese text bin & goto FATAL)
if not exist tmp ECHO. Chinese text tmp & goto FATAL
set path=%cd%;%cd%\tool\Win;%path%
set framework_workspace=%cd%

::ECHO. Chinese text ECHOC...
if not exist %framework_workspace%\tool\Win\ECHOC.exe ECHO. Chinese text ECHOC.exe& goto FATAL
ECHOC | find "Usage" 1>nul 2>nul || ECHO.ECHOC.exe Chinese text&& goto FATAL
::ECHO. Chinese text strtofile...
if not exist %framework_workspace%\tool\Win\strtofile.exe ECHOC {%c_e%}Chinese text strtofile.exe{%c_i%}{\n}& goto FATAL
if exist %framework_workspace%\tmp\bff-test.txt del %framework_workspace%\tmp\bff-test.txt 1>nul
echo.bff-test|strtofile.exe %framework_workspace%\tmp\bff-test.txt || ECHOC {%c_e%}strtofile.exe Chinese text{%c_i%}{\n}&& goto FATAL
for /f %%a in (%framework_workspace%\tmp\bff-test.txt) do (if not "%%a"=="bff-test" ECHOC {%c_e%}strtofile.exe Chinese text{%c_i%}{\n}& goto FATAL)
del %framework_workspace%\tmp\bff-test.txt 1>nul


:CMD
CLS
ECHOC {0E}=--------------------------------------------------------------------={0F}{\n}
ECHO.
ECHO.                              BFF- Chinese text
ECHO.
ECHOC {0E}=--------------------------------------------------------------------={0F}{\n}
ECHO.
ECHOC {0E} Chinese text ADB Chinese text Fastboot Chinese text . Chinese text, Chinese text Enter Chinese text . Chinese text .{0F}{\n}
ECHO.
ECHOC {0E} cc{0F}  Chinese text ADB Chinese text Fastboot Chinese text  {0E}kil{0F} Chinese text ADB Chinese text Fastboot Chinese text{0F}{\n}
ECHOC {0E} pre{0F} Chinese text ADB Shell Chinese text  {0E}cfg{0F} Chinese text{0F}{\n}
ECHOC {0E} mmc{0F} Chinese text         {0E}cls{0F} Chinese text{0F}{\n}
ECHO. 
:CMD-CONTINUE
ECHOC {0E}=--------------------------------------------------------------------={0F}{\n}
ECHOC {0E}[Chinese text]{0F} & call strtofile.exe %framework_workspace%\tmp\cmd.bat
for /f %%a in (%framework_workspace%\tmp\cmd.bat) do set cmd=%%a
if "%cmd%"=="" ECHOC {0C}                                                        [Chinese text]{0F}{\n}& goto CMD-CONTINUE
if "%cmd%"=="cls" goto CMD
if "%cmd%"=="CLS" goto CMD
if "%cmd%"=="cc" (
    ECHO. Chinese text ADB Chinese text ...& adb.exe devices | findstr /v "attached"
    ECHO. Chinese text Fastboot Chinese text ...& fastboot.exe devices & goto CMD-CONTINUE)
if "%cmd%"=="mmc" (
    tasklist | find "mmc.exe" 1>nul 2>nul && ECHOC {0A}Chinese text！{0F}{\n}&& goto CMD-CONTINUE
    start %windir%\system32\devmgmt.msc & goto CMD-CONTINUE)
if "%cmd%"=="kil" (
    tasklist | find "adb.exe" 1>nul 2>nul && taskkill /f /im adb.exe
    tasklist | find "fastboot.exe" 1>nul 2>nul && taskkill /f /im fastboot.exe
    goto CMD-CONTINUE)
if "%cmd%"=="pre" (
    ECHO. Chinese text
    ECHO.bootctl...& call :pushlinuxtool bootctl
    ECHO.busybox...& call :pushlinuxtool busybox
    ECHO.dmsetup...& call :pushlinuxtool dmsetup
    ECHO.blktool...& call :pushlinuxtool blktool
    ECHO.mke2fs...& call :pushlinuxtool mke2fs
    ECHO.mkfs.exfat...& call :pushlinuxtool mkfs.exfat
    ECHO.mkfs.fat...& call :pushlinuxtool mkfs.fat
    ECHO.mkntfs...& call :pushlinuxtool mkntfs
    ECHO.parted...& call :pushlinuxtool parted
	ECHO.sgdisk...& call :pushlinuxtool sgdisk
    goto CMD-CONTINUE)
if "%cmd%"=="cfg" (
    ECHOC {0F}Chinese text:{07}{\n}& @ECHO ON & prompt $_& call %framework_workspace%\conf\fixed|findstr "set" & prompt & @ECHO OFF
    ECHOC {0F}Chinese text:{07}{\n}& @ECHO ON & prompt $_& call %framework_workspace%\conf\user|findstr "set" & prompt & @ECHO OFF
    goto CMD-CONTINUE)
call %framework_workspace%\tmp\cmd.bat || ECHOC {0C}                                                          [Chinese text]{0F}{\n}
goto CMD-CONTINUE


:pushlinuxtool
if not exist %framework_workspace%\tool\Android\%1 ECHOC {0C}Chinese text %framework_workspace%\tool\Android\%1{0F}{\n}& goto :eof
adb.exe push %framework_workspace%\tool\Android\%1 ./%1 1>nul || ECHOC {0C}Chinese text %framework_workspace%\tool\Android\%1 Chinese text ./%1 Chinese text{0F}{\n}&& goto :eof
adb.exe shell chmod +x ./%1 1>nul || ECHOC {0C}Chinese text ./%1 Chinese text{0F}{\n}&& goto :eof
goto :eof


:NODEV
ECHOC {0C}                                                    [Chinese text(Chinese text)Chinese text]{0F}{\n}
goto CMD-CONTINUE






:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)
