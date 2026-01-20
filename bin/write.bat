::Chinese text: y

::call write system        Chinese text               img Chinese text
::           recovery      Chinese text               img Chinese text
::           fastboot      Chinese text               img Chinese text
::           fastbootd     Chinese text               img Chinese text
::           fastbootboot  img Chinese text
::           qcedl         Chinese text               img Chinese text                      Chinese text(Chinese text auto)                                    Chinese text(Chinese text,Chinese text)
::           qcedlxml      Chinese text(Chinese text auto)    Chinese text(Chinese text auto)          img Chinese text                                         xml Chinese text                         Chinese text(Chinese text,Chinese text)
::           qcedlsendfh   Chinese text(Chinese text auto)    Chinese text                 [auto emmc ufs spinor skip](Chinese text,Chinese text,Chinese text auto)
::           qcdiag        Chinese text(Chinese text auto)    qcn Chinese text
::           twrpinst      zip Chinese text
::           sideload      zip Chinese text
::           adbpush       Chinese text           Chinese text                  [common program](Chinese text,Chinese text,Chinese text common)


@ECHO OFF
chcp 65001 >nul
set args1=%1& set args2=%2& set args3=%3& set args4=%4& set args5=%5& set args6=%6& set args7=%7& set args8=%8& set args9=%9
goto %args1%



:QCEDLSENDFH
SETLOCAL
set logger=write.bat-qcedlsendfh
::Chinese text
set port=%args2%& set filepath=%args3%& set configuremode=%args4%
call log %logger% I Chinese text:port:%port%.filepath:%filepath%.configuremode:%configuremode%
::Chinese text
if not exist %filepath% ECHOC {%c_e%}Chinese text %filepath%{%c_i%}{\n}& call log %logger% F Chinese text %filepath%& goto FATAL
::Chinese text
for %%a in ("%filepath%") do set filepath=%%~fa
::Chinese text auto Chinese text
if "%port%"=="auto" call chkdev qcedl 1>nul
if "%port%"=="auto" set port=%chkdev__port__qcedl%
::Chinese text
::call log %logger% I Chinese text
::QSaharaServer.exe -p \\.\COM%port% -d 1>%tmpdir%\output.txt 2>&1
::type %tmpdir%\output.txt>>%logfile%
::set portstatus=
::for /f "tokens=2 delims=[]" %%a in ('type %tmpdir%\output.txt ^| find "[portstatus]"') do set portstatus=%%a
::if "%portstatus%"=="firehose" ECHOC {%c_we%}Chinese text firehose Chinese text, Chinese text ...{%c_i%}{\n}& call log %logger% I Chinese text firehose Chinese text . Chinese text& goto QCEDLSENDFH-DONE
::if not "%portstatus%"=="sahara" ECHOC {%c_w%}Chinese text . Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text
:QCEDLSENDFH-1
call log %logger% I Chinese text
::Chinese text . Chinese text .
goto QCEDLSENDFH-COMMON
:QCEDLSENDFH-COMMON
set devprgtype=single
if exist %filepath%\prog_firehose_ddr.elf set devprgtype=multi
if "%devprgtype%"=="single" (
    QSaharaServer.exe -p \\.\COM%port% -s 13:%filepath% 1>%tmpdir%\output.txt 2>&1 & type %tmpdir%\output.txt>>%logfile%
    find "File transferred successfully" "%tmpdir%\output.txt" 1>nul 2>nul && goto QCEDLSENDFH-DONE)
if "%devprgtype%"=="multi" (
    QSaharaServer.exe -p \\.\COM%port% -s 36:%filepath%\multi_image_qti.mbn -s 37:%filepath%\multi_image.mbn -s 21:%filepath%\xbl_sc.elf -s 60:%filepath%\signed_firmware_soc_view.elf -s 59:%filepath%\sequencer_ram.elf -s 61:%filepath%\tme_config.elf -s 13:%filepath%\prog_firehose_ddr.elf -s 38:%filepath%\xbl_config_devprg.elf 1>%tmpdir%\output.txt 2>&1 & type %tmpdir%\output.txt>>%logfile%
    find "Successfully uploaded all images" "%tmpdir%\output.txt" 1>nul 2>nul && goto QCEDLSENDFH-DONE)
find "[portstatus]firehose" "%tmpdir%\output.txt" 1>nul 2>nul && ECHOC {%c_we%}Chinese text firehose Chinese text, Chinese text ...{%c_i%}{\n}&& call log %logger% I Chinese text firehose Chinese text . Chinese text&& goto QCEDLSENDFH-DONE
goto QCEDLSENDFH-FAILED
:QCEDLSENDFH-FAILED
ECHOC {%c_e%}Chinese text . Chinese text 9008. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text&& pause>nul && ECHO. Chinese text ... && goto QCEDLSENDFH-1
:QCEDLSENDFH-DONE
call log %logger% I Chinese text
::Chinese text
if "%product%"=="NX789J" set configuremode=ufs-zte& goto QCEDLSENDFH-CONFIGURE-UFS-ZTE
if "%product%"=="NX809J" set configuremode=ufs-zte& goto QCEDLSENDFH-CONFIGURE-UFS-ZTE
if "%configuremode%"=="skip" ECHOC {%c_w%}Chinese text . Chinese text{%c_i%}{\n}& call log %logger% W Chinese text& goto QCEDLSENDFH-CONFIGURE-DONE
if "%configuremode%"=="ufs" goto QCEDLSENDFH-CONFIGURE-%configuremode%
if "%configuremode%"=="emmc" goto QCEDLSENDFH-CONFIGURE-%configuremode%
if "%configuremode%"=="spinor" goto QCEDLSENDFH-CONFIGURE-%configuremode%
goto QCEDLSENDFH-CONFIGURE-AUTO
:QCEDLSENDFH-CONFIGURE-UFS-ZTE
call log %logger% I Chinese text %configuremode% Chinese text
echo.^<?xml version="1.0" encoding="UTF-8" ?^>^<data^>^<configure MemoryName="ufs" Verbose="0" AlwaysValidate="0" MaxDigestTableSizeInBytes="8192" MaxPayloadSizeToTargetInBytes="1048576" ZlpAwareHost="1" SkipStorageInit="0" Oem="ZTE"/^>^</data^>>%tmpdir%\cmd.xml
set result=n
qcedlcmdhelper.exe -p COM%port% -m xml -f %tmpdir%\cmd.xml 1>>%logfile% 2>&1 && set result=y
::fh_loader.exe --port=\\.\COM%port% --memoryname=ufs --search_path=%tmpdir% --sendxml=%tmpdir%\cmd.xml --mainoutputdir=%tmpdir% --skip_config --showpercentagecomplete --noprompt 1>>%logfile% 2>&1 && set result=y
echo.^<?xml version="1.0" ?^>^<data^>^<program SECTOR_SIZE_IN_BYTES="4096" filename="tmp.bin" physical_partition_number="0" label="PrimaryGPT" start_sector="0" num_partition_sectors="6" /^>^</data^>>%tmpdir%\tmp.xml
fh_loader.exe --port=\\.\COM%port% --memoryname=ufs --sendxml=%tmpdir%\tmp.xml --convertprogram2read --mainoutputdir=%tmpdir% --skip_config --noprompt 1>>%logfile% 2>&1
if "%result%"=="y" call log %logger% I %configuremode% Chinese text
if "%result%"=="n" ECHOC {%c_w%}%configuremode% Chinese text . Chinese text{%c_i%}{\n}& ECHO. Chinese text ... & call log %logger% W %configuremode% Chinese text
goto QCEDLSENDFH-CONFIGURE-DONE
:QCEDLSENDFH-CONFIGURE-UFS
call log %logger% I Chinese text %configuremode% Chinese text
call :qcedlsendfh-configure-tryufs
if "%result%"=="y" call log %logger% I %configuremode% Chinese text
if "%result%"=="n" ECHOC {%c_w%}%configuremode% Chinese text . Chinese text{%c_i%}{\n}& ECHO. Chinese text ... & call log %logger% W %configuremode% Chinese text
goto QCEDLSENDFH-CONFIGURE-DONE
:QCEDLSENDFH-CONFIGURE-EMMC
call log %logger% I Chinese text %configuremode% Chinese text
call :qcedlsendfh-configure-tryemmc
if "%result%"=="y" call log %logger% I %configuremode% Chinese text
if "%result%"=="n" ECHOC {%c_w%}%configuremode% Chinese text . Chinese text{%c_i%}{\n}& ECHO. Chinese text ... & call log %logger% W %configuremode% Chinese text
goto QCEDLSENDFH-CONFIGURE-DONE
:QCEDLSENDFH-CONFIGURE-SPINOR
call log %logger% I Chinese text %configuremode% Chinese text
call :qcedlsendfh-configure-tryspinor
if "%result%"=="y" call log %logger% I %configuremode% Chinese text
if "%result%"=="n" ECHOC {%c_w%}%configuremode% Chinese text . Chinese text{%c_i%}{\n}& ECHO. Chinese text ... & call log %logger% W %configuremode% Chinese text
goto QCEDLSENDFH-CONFIGURE-DONE
:QCEDLSENDFH-CONFIGURE-AUTO
call log %logger% I Chinese text ufs Chinese text
call :qcedlsendfh-configure-tryufs
if "%result%"=="y" call log %logger% I ufs Chinese text& goto QCEDLSENDFH-CONFIGURE-DONE
if "%result%"=="n" call log %logger% I ufs Chinese text
call log %logger% I Chinese text emmc Chinese text
call :qcedlsendfh-configure-tryemmc
if "%result%"=="y" call log %logger% I emmc Chinese text& goto QCEDLSENDFH-CONFIGURE-DONE
if "%result%"=="n" call log %logger% I emmc Chinese text
call log %logger% I Chinese text spinor Chinese text
call :qcedlsendfh-configure-tryspinor
if "%result%"=="y" call log %logger% I spinor Chinese text& goto QCEDLSENDFH-CONFIGURE-DONE
if "%result%"=="n" call log %logger% I spinor Chinese text
ECHOC {%c_w%}Chinese text . Chinese text{%c_i%}{\n}& ECHO. Chinese text ... & call log %logger% W Chinese text
goto QCEDLSENDFH-CONFIGURE-DONE
:qcedlsendfh-configure-tryufs
set result=n
fh_loader.exe --port=\\.\COM%port% --memoryname=ufs --configure --mainoutputdir=%tmpdir% --noprompt 1>>%logfile% 2>&1 || call log %logger% I Chinese text . Chinese text MaxDigestTableSizeInBytes Chinese text&& fh_loader.exe --port=\\.\COM%port% --memoryname=ufs --configure --fix_config --mainoutputdir=%tmpdir% --noprompt 1>>%logfile% 2>&1
find "Got the ACK for the <configure>" "%tmpdir%\port_trace.txt" 1>nul 2>nul && set result=y
find "Target returned NAK for your <configure> but it does not seem to be an error" "%tmpdir%\port_trace.txt" 1>nul 2>nul && set result=y
goto :eof
:qcedlsendfh-configure-tryemmc
set result=n
fh_loader.exe --port=\\.\COM%port% --memoryname=emmc --configure --mainoutputdir=%tmpdir% --noprompt 1>>%logfile% 2>&1 || call log %logger% I Chinese text . Chinese text MaxDigestTableSizeInBytes Chinese text&& fh_loader.exe --port=\\.\COM%port% --memoryname=emmc --configure --fix_config --mainoutputdir=%tmpdir% --noprompt 1>>%logfile% 2>&1
find "Got the ACK for the <configure>" "%tmpdir%\port_trace.txt" 1>nul 2>nul && set result=y
find "Target returned NAK for your <configure> but it does not seem to be an error" "%tmpdir%\port_trace.txt" 1>nul 2>nul && set result=y
goto :eof
:qcedlsendfh-configure-tryspinor
set result=n
fh_loader.exe --port=\\.\COM%port% --memoryname=spinor --configure --mainoutputdir=%tmpdir% --noprompt 1>>%logfile% 2>&1 || call log %logger% I Chinese text . Chinese text MaxDigestTableSizeInBytes Chinese text&& fh_loader.exe --port=\\.\COM%port% --memoryname=spinor --configure --fix_config --mainoutputdir=%tmpdir% --noprompt 1>>%logfile% 2>&1
find "Got the ACK for the <configure>" "%tmpdir%\port_trace.txt" 1>nul 2>nul && set result=y
find "Target returned NAK for your <configure> but it does not seem to be an error" "%tmpdir%\port_trace.txt" 1>nul 2>nul && set result=y
goto :eof
:QCEDLSENDFH-CONFIGURE-DONE
ENDLOCAL
goto :eof


:QCDIAG
SETLOCAL
set logger=write.bat-qcdiag
::Chinese text
set port=%args2%& set filepath=%args3%
call log %logger% I Chinese text:port:%port%.filepath:%filepath%
:QCDIAG-1
::Chinese text qcn Chinese text
if not exist %filepath% ECHOC {%c_e%}Chinese text %filepath%{%c_i%}{\n}& call log %logger% F Chinese text %filepath%& goto FATAL
::Chinese text auto Chinese text
if "%port%"=="auto" call chkdev qcdiag 1>nul
if "%port%"=="auto" set port=%chkdev__port__qcdiag%
::Chinese text qcn
call log %logger% I Chinese text QCN:%filepath%
QCNTool.exe -w -p %port% -f %filepath% 1>%tmpdir%\output.txt 2>&1
::Chinese text: Chinese text IMEI, Chinese text, Chinese text type Chinese text
type %tmpdir%\output.txt>>%logfile%
find "Writing Data File to phone... OK" "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}Chinese text QCN:%filepath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text QCN:%filepath% Chinese text&& pause>nul && ECHO. Chinese text ... && goto QCDIAG-1
call log %logger% I Chinese text QCN:%filepath% Chinese text
ENDLOCAL
goto :eof


:ADBPUSH
SETLOCAL
set logger=write.bat-adbpush
::Chinese text
set filepath=%args2%& set pushname_full=%args3%& set mode=%args4%
call log %logger% I Chinese text:filepath:%filepath%.pushname_full:%pushname_full%.mode:%mode%
:ADBPUSH-1
::Chinese text
if not exist %filepath% ECHOC {%c_e%}Chinese text %filepath%{%c_i%}{\n}& call log %logger% F Chinese text %filepath%& goto FATAL
::Chinese text(Chinese text)
for %%a in ("%pushname_full%") do set pushname=%%~na
::Chinese text
for %%a in ("%pushname_full%") do set var=%%~xa
if not "%var%"=="" (set pushname_ext=%var:~1,999%) else (set pushname_ext=)
::Chinese text
call chkdev all 1>nul
if not "%chkdev__mode%"=="system" (if not "%chkdev__mode%"=="recovery" ECHOC {%c_e%}Chinese text . {%c_i%}Chinese text Recovery Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text& pause>nul & ECHO. Chinese text ... & goto ADBPUSH-1)
::Chinese text
if "%mode:~0,7%"=="program" goto ADBPUSH-PROGRAM-%chkdev__mode%
goto ADBPUSH-COMMON
::Chinese text - Chinese text
:ADBPUSH-PROGRAM-SYSTEM
set pushfolder=./data/local/tmp
adb.exe push %filepath% ./sdcard/bff.tmp 1>%tmpdir%\output.txt 2>&1 || type %tmpdir%\output.txt>>%logfile% && ECHOC {%c_e%}Chinese text %filepath% Chinese text ./sdcard/bff.tmp Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text ./sdcard/bff.tmp Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-PROGRAM-%chkdev__mode%
type %tmpdir%\output.txt>>%logfile%
find " 1 file pushed, 0 skipped." "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}Chinese text %filepath% Chinese text ./sdcard/bff.tmp Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text ./sdcard/bff.tmp Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-PROGRAM-%chkdev__mode%
adb.exe shell mv -f ./sdcard/bff.tmp %pushfolder%/%pushname_full% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ./sdcard/bff.tmp Chinese text %pushfolder%/%pushname_full% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ./sdcard/bff.tmp Chinese text %pushfolder%/%pushname_full% Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-PROGRAM-%chkdev__mode%
adb.exe shell chmod 777 %pushfolder%/%pushname_full% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %pushfolder%/%pushname_full% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %pushfolder%/%pushname_full% Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-PROGRAM-%chkdev__mode%
goto ADBPUSH-DONE
::Chinese text -Recovery
:ADBPUSH-PROGRAM-RECOVERY
set pushfolder=.
adb.exe push %filepath% %pushfolder%/bff.tmp 1>%tmpdir%\output.txt 2>&1 || type %tmpdir%\output.txt>>%logfile% && ECHOC {%c_e%}Chinese text %filepath% Chinese text %pushfolder%/bff.tmp Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text %pushfolder%/bff.tmp Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-PROGRAM-%chkdev__mode%
type %tmpdir%\output.txt>>%logfile%
find " 1 file pushed, 0 skipped." "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}Chinese text %filepath% Chinese text %pushfolder%/bff.tmp Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text %pushfolder%/bff.tmp Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-PROGRAM-%chkdev__mode%
adb.exe shell mv -f %pushfolder%/bff.tmp %pushfolder%/%pushname_full% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %pushfolder%/bff.tmp Chinese text %pushfolder%/%pushname_full% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %pushfolder%/bff.tmp Chinese text %pushfolder%/%pushname_full% Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-PROGRAM-%chkdev__mode%
adb.exe shell chmod 777 %pushfolder%/%pushname_full% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %pushfolder%/%pushname_full% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %pushfolder%/%pushname_full% Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-PROGRAM-%chkdev__mode%
goto ADBPUSH-DONE
::Chinese text
:ADBPUSH-COMMON
set pushfolder=./sdcard
    ::Chinese text(b)
set filesize=
for /f "tokens=2 delims= " %%a in ('busybox.exe stat -t %filepath%') do set filesize=%%a
if "%filesize%"=="" ECHC {%c_e%}Chinese text %filepath% Chinese text{%c_i%}{\n}& call log %logger% F Chinese text %filepath% Chinese text& goto FATAL
    ::Chinese text(b)
call framework adbpre busybox
set busyboxpath=%write__adbpush__filepath%
adb.exe shell %busyboxpath% df -B 1 2>&1 | find /v "Permission denied" 1>%tmpdir%\output.txt 2>&1
type %tmpdir%\output.txt>>%logfile%
find "Filesystem" "%tmpdir%\output.txt" 1>nul 2>nul || type %tmpdir%\output.txt>>%logfile% && ECHOC {%c_e%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-COMMON
type %tmpdir%\output.txt | busybox.exe tr "\r" "\n" | busybox.exe sed "s/$/\r/g" 1>%tmpdir%\output2.txt 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\output.txt Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\output.txt Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-COMMON
del %tmpdir%\output.txt 1>>%logfile% 2>&1
for /f "tokens=4,6 delims= " %%a in ('type %tmpdir%\output2.txt') do echo.[%%a][%%b]>>%tmpdir%\output.txt
        ::df Chinese text
for /f "tokens=3,5 delims= " %%a in ('type %tmpdir%\output2.txt') do echo.[%%a][%%b]>>%tmpdir%\output.txt
    ::Chinese text, Chinese text pushfolder
if "%chkdev__mode%"=="system" (goto ADBPUSH-COMMON-CHKSPACE-SYSTEM) else (goto ADBPUSH-COMMON-CHKSPACE-RECOVERY)
        ::Chinese text(sdcard Chinese text data Chinese text sdcard Chinese text)
:ADBPUSH-COMMON-CHKSPACE-SYSTEM
call :adbpush-common-chkspace sdcard
if "%result%"=="y" set pushfolder=./sdcard& goto ADBPUSH-COMMON-PUSH
call :adbpush-common-chkspace data
if "%result%"=="y" set pushfolder=./sdcard& goto ADBPUSH-COMMON-PUSH
ECHOC {%c_e%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text& pause>nul & ECHO. Chinese text ... & goto ADBPUSH-COMMON
        ::Chinese text
:ADBPUSH-COMMON-CHKSPACE-RECOVERY
call :adbpush-common-chkspace tmp
if "%result%"=="y" set pushfolder=./tmp& goto ADBPUSH-COMMON-PUSH
call :adbpush-common-chkspace data
if "%result%"=="y" set pushfolder=./data& goto ADBPUSH-COMMON-PUSH
call :adbpush-common-chkspace sdcard
if "%result%"=="y" set pushfolder=./sdcard& goto ADBPUSH-COMMON-PUSH
ECHOC {%c_e%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text& pause>nul & ECHO. Chinese text ... & goto ADBPUSH-COMMON
        ::call :adbpush-common-chkspace Chinese text(Chinese text sdcard)
:adbpush-common-chkspace
set keyword=%1
set var=
for /f "tokens=1 delims=[] " %%a in ('type %tmpdir%\output.txt ^| find "[/%keyword%]"') do set var=%%a
            ::Chinese text
if "%var%"=="" set result=n& goto :eof
            ::Chinese text bff.tmp Chinese text
set var2=
for /f "tokens=2 delims= " %%a in ('adb.exe shell %busyboxpath% stat -t ./%keyword%/bff.tmp 2^>^&1 ^| find /v "No such file or directory" ^| find "bff.tmp"') do set var2=%%a
if not "%var2%"=="" call calc s var nodec %var% %var2%
set var2=
for /f "tokens=2 delims= " %%a in ('adb.exe shell %busyboxpath% stat -t ./%keyword%/%pushname_full% 2^>^&1 ^| find /v "No such file or directory" ^| find "%pushname_full%"') do set var2=%%a
if not "%var2%"=="" call calc s var nodec %var% %var2%
            ::Chinese text
if not "%var%"=="" call calc numcomp %var% %filesize%
if not "%var%"=="" (if "%calc__numcomp__result%"=="greater" set result=y& goto :eof)
            ::Chinese text
set result=n& goto :eof
:ADBPUSH-COMMON-PUSH
    ::Chinese text
adb.exe push %filepath% %pushfolder%/bff.tmp 1>%tmpdir%\output.txt 2>&1 || type %tmpdir%\output.txt>>%logfile% && ECHOC {%c_e%}Chinese text %filepath% Chinese text %pushfolder%/bff.tmp Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text %pushfolder%/bff.tmp Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-COMMON
type %tmpdir%\output.txt>>%logfile%
find " 1 file pushed, 0 skipped." "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}Chinese text %filepath% Chinese text %pushfolder%/bff.tmp Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text %pushfolder%/bff.tmp Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-COMMON
adb.exe shell mv -f %pushfolder%/bff.tmp %pushfolder%/%pushname_full% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %pushfolder%/bff.tmp Chinese text %pushfolder%/%pushname_full% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %pushfolder%/bff.tmp Chinese text %pushfolder%/%pushname_full% Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-COMMON
    ::Chinese text
set var=unknown
for /f "tokens=2 delims= " %%a in ('adb.exe shell %busyboxpath% stat -t %pushfolder%/%pushname_full% 2^>^&1 ^| find /v "No such file or directory" ^| find "%pushname_full%"') do set var=%%a
if not "%var%"=="%filesize%" ECHOC {%c_e%}Chinese text %filepath% Chinese text %pushfolder%/%pushname_full% Chinese text . Chinese text %filesize% Chinese text %var% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text %pushfolder%/%pushname_full% Chinese text . Chinese text %filesize% Chinese text %var% Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBPUSH-COMMON
goto ADBPUSH-DONE
:ADBPUSH-DONE
call log %logger% I adb Chinese text . Chinese text:%pushfolder%/%pushname_full%. Chinese text:%pushname_full%. Chinese text:%pushname%. Chinese text:%pushname_ext%. Chinese text:%pushfolder%
ENDLOCAL & set write__adbpush__filepath=%pushfolder%/%pushname_full%& set write__adbpush__filename_full=%pushname_full%& set write__adbpush__filename=%pushname%& set write__adbpush__folder=%pushfolder%& set write__adbpush__ext=%pushname_ext%
goto :eof


:SIDELOAD
SETLOCAL
set logger=write.bat-sideload
::Chinese text
set zippath=%args2%
call log %logger% I Chinese text:zippath:%zippath%
:SIDELOAD-1
::Chinese text
if not exist %zippath% ECHOC {%c_e%}Chinese text %zippath%{%c_i%}{\n}& call log %logger% F Chinese text %zippath%& goto FATAL
::Chinese text
call reboot recovery sideload rechk 3
call log %logger% I Chinese text %zippath%
adb.exe sideload %zippath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %zippath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %zippath% Chinese text&& pause>nul && ECHO. Chinese text ... && goto SIDELOAD-1
ENDLOCAL
goto :eof


:TWRPINST
SETLOCAL
set logger=write.bat-twrpinst
::Chinese text
set zippath=%args2%
call log %logger% I Chinese text:zippath:%zippath%
:TWRPINST-1
::Chinese text
if not exist %zippath% ECHOC {%c_e%}Chinese text %zippath%{%c_i%}{\n}& call log %logger% F Chinese text %zippath%& goto FATAL
::Chinese text
call log %logger% I Chinese text %zippath%
call write adbpush %zippath% bff.zip common
::adb.exe push %zippath% ./tmp/bff.zip 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %zippath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %zippath% Chinese text&& pause>nul && ECHO. Chinese text ... && goto TWRPINST-1
::Chinese text
call log %logger% I Chinese text %write__adbpush__filepath%
adb.exe shell twrp install %write__adbpush__filepath% 1>%tmpdir%\output.txt 2>&1 || type %tmpdir%\output.txt>>%logfile% && call log %logger% E Chinese text %zippath% Chinese text&& ECHOC {%c_e%}Chinese text %zippath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& pause>nul && ECHO. Chinese text ... && goto TWRPINST-1
type %tmpdir%\output.txt>>%logfile%
find "zip" "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}Chinese text %zippath% Chinese text, TWRP Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %zippath% Chinese text,TWRP Chinese text&& pause>nul && ECHO. Chinese text ... && goto TWRPINST-1
adb.exe shell rm %write__adbpush__filepath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %write__adbpush__filepath% Chinese text{%c_i%}{\n}&& call log %logger% E Chinese text %write__adbpush__filepath% Chinese text
ENDLOCAL
goto :eof


:QCEDLXML
SETLOCAL
set logger=write.bat-qcedlxml
::Chinese text
set port=%args2%& set memory=%args3%& set searchpath=%args4%& set xml=%args5%& set fh=%args6%
call log %logger% I Chinese text:port:%port%.memory:%memory%.searchpath:%searchpath%.xml:%xml%.fh:%fh%
:QCEDLXML-1
::Chinese text searchpath Chinese text
if not exist %searchpath% ECHOC {%c_e%}Chinese text %searchpath%{%c_i%}{\n}& call log %logger% F Chinese text %searchpath%& goto FATAL
::Chinese text xml
call log %logger% I Chinese text xml
    ::Chinese text %tmpdir%\qcedlxml
if exist %tmpdir%\qcedlxml rd /s /q %tmpdir%\qcedlxml 1>>%logfile% 2>&1
md %tmpdir%\qcedlxml 1>>%logfile% 2>&1
    ::Chinese text
set xml_new=& set num=1
:QCEDLXML-PROCESSXML
set var=
for /f "tokens=%num% delims=/" %%a in ('echo.%xml%') do set var=%%a
if "%var%"=="" (
    if "%xml_new%"=="" ECHOC {%c_e%}Chinese text xml Chinese text{%c_i%}{\n}& call log %logger% F Chinese text xml Chinese text& goto FATAL
    set xml=%xml_new%& goto QCEDLXML-FLASH-START)
if exist %searchpath%\%var% set var=%searchpath%\%var%& goto QCEDLXML-PROCESSXML-1
if exist %var% goto QCEDLXML-PROCESSXML-1
ECHOC {%c_e%}Chinese text %var%{%c_i%}{\n}& call log %logger% F Chinese text %var%& goto FATAL
:QCEDLXML-PROCESSXML-1
    ::Chinese text xml Chinese text %tmpdir%\qcedlxml\%num%.xml Chinese text copy Chinese text, Chinese text, Chinese text busybox.exe
::copy /Y %var% %tmpdir%\qcedlxml\%num%.xml 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %var% Chinese text %tmpdir%\qcedlxml\%num%.xml Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %var% Chinese text %tmpdir%\qcedlxml\%num%.xml Chinese text&& pause>nul && ECHO. Chinese text ... && goto QCEDLXML-PROCESSXML-1
busybox.exe cp -f %var% %tmpdir%\qcedlxml\%num%.xml 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %var% Chinese text %tmpdir%\qcedlxml\%num%.xml Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %var% Chinese text %tmpdir%\qcedlxml\%num%.xml Chinese text&& pause>nul && ECHO. Chinese text ... && goto QCEDLXML-PROCESSXML-1
    ::Chinese text xml. Chinese text rawprogram, Chinese text, Chinese text xml
qcedlxmlhelper.exe -f %tmpdir%\qcedlxml\%num%.xml -m formatxml -o %tmpdir%\qcedlxml\%num%.xml 1>>%logfile% 2>&1 || goto QCEDLXML-PROCESSXML-NEXT
    ::Chinese text xml- Chinese text
call :qcedlxml-xmlcustomprocessing %tmpdir%\qcedlxml\%num%.xml
:QCEDLXML-PROCESSXML-NEXT
    ::Chinese text xml Chinese text
if exist %tmpdir%\qcedlxml\%num%.xml set xml_new=%xml_new%,%tmpdir%\qcedlxml\%num%.xml
set /a num+=1& goto QCEDLXML-PROCESSXML
    ::Chinese text
:QCEDLXML-FLASH-START
::Chinese text
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
::QSaharaServer.exe -p \\.\COM%port% -d | find "[portstatus]firehose" 1>nul 2>nul || ECHOC {%c_e%}Chinese text firehose Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text firehose Chinese text&& pause>nul && ECHO. Chinese text ... && goto QCEDLXML-FLASH-START
:QCEDLXML-FLASH-COMMON
::if "%xml%"=="" call log %logger% I xml Chinese text . Chinese text& goto QCEDLXML-FLASH-SPARSE
call log %logger% I Chinese text 9008 Chinese text
call :qcedlxml-flash-run %searchpath%
if "%result%"=="n" ECHOC {%c_e%}9008 Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E 9008 Chinese text& pause>nul & ECHO. Chinese text ... & goto QCEDLXML-FLASH-COMMON
:QCEDLXML-DONE
if exist %tmpdir%\qcedlxml rd /s /q %tmpdir%\qcedlxml 1>>%logfile% 2>&1
call log %logger% I 9008 Chinese text
ENDLOCAL
goto :eof
::9008 Chinese text
:qcedlxml-flash-run
set result=y
call log %logger% I Chinese text 9008 Chinese text .search_path Chinese text sendxml Chinese text:
echo.%1 >>%logfile%
echo.%xml% >>%logfile%
fh_loader.exe --port=\\.\COM%port% --memoryname=%memory% --search_path=%1 --sendxml=%xml% --mainoutputdir=%tmpdir% --skip_config --showpercentagecomplete --noprompt 1>>%logfile% 2>&1 || call log %logger% E 9008 Chinese text&& set result=n&& goto :eof
::--testvipimpact   --zlpawarehost=1
:qcedlxml-flash-run-chkfilenotfound
find " Couldn't find the file " "%tmpdir%\port_trace.txt" 1>nul 2>nul || goto qcedlxml-flash-run-chkfilesizezero
ECHOC {%c_w%}Chinese text: & call log %logger% W Chinese text . Chinese text:
setlocal enabledelayedexpansion
for /f "tokens=*" %%a in ('find " Couldn't find the file " "%tmpdir%\port_trace.txt"') do (
    set "line=%%a"
    for /f "tokens=3 delims='" %%b in ("!line!") do (
		ECHOC {%c_w%}%%b & echo.%%b >>%logfile%))
endlocal
ECHOC {%c_w%}. Chinese text ...{%c_i%}{\n}
:qcedlxml-flash-run-chkfilesizezero
find " Filesize is 0 bytes. " "%tmpdir%\port_trace.txt" 1>%tmpdir%\tmp.txt 2>nul || goto qcedlxml-flash-run-done
busybox.exe sed -i "s/!//g" %tmpdir%\tmp.txt
ECHOC {%c_w%}Chinese text 0: & call log %logger% W Chinese text 0. Chinese text:
setlocal enabledelayedexpansion
for /f "tokens=*" %%a in ('find " Filesize is 0 bytes. " "%tmpdir%\tmp.txt"') do (
    set "line=%%a"
    for /f "tokens=2 delims='" %%b in ("!line!") do (
		ECHOC {%c_w%}%%b & echo.%%b >>%logfile%))
endlocal
ECHOC {%c_w%}. Chinese text ...{%c_i%}{\n}
:qcedlxml-flash-run-done
call log %logger% I 9008 Chinese text
goto :eof
::Chinese text xml
:qcedlxml-xmlcustomprocessing
::Chinese text rawprogram xml Chinese text . Chinese text xml Chinese text %1. Chinese text: Chinese text xml Chinese text .
goto :eof


:QCEDL
SETLOCAL
set logger=write.bat-qcedl
::Chinese text
set parname=%args2%& set filepath=%args3%& set port=%args4%& set fh=%args5%
call log %logger% I Chinese text:parname:%parname%.filepath:%filepath%.port:%port%.fh:%fh%
::Chinese text img Chinese text, Chinese text
if not exist %filepath% ECHOC {%c_e%}Chinese text %filepath%{%c_i%}{\n}& call log %logger% F Chinese text %filepath%& goto FATAL
for %%a in ("%filepath%") do set filepath_fullname=%%~nxa
for %%a in ("%filepath%") do set var=%%~dpa
set filepath_folder=%var:~0,-1%
::Chinese text img Chinese text sparse
set sparse=false
simg_dump.exe -f %filepath% -m basicinfo 1>>%logfile% 2>&1 && set sparse=true
::Chinese text auto Chinese text
if not "%port%"=="auto" (if not "%port%"=="" goto QCEDL-2)
call chkdev qcedl 1>nul
set port=%chkdev__port__qcedl%
:QCEDL-2
::Chinese text
if not "%fh%"=="" call write qcedlsendfh %port% %fh% auto
::Chinese text
call info qcedl %port%
if not "%info__qcedl__portstatus%"=="firehose" ECHOC {%c_e%}Chinese text firehose Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text firehose Chinese text& pause>nul & ECHO. Chinese text ... & goto QCEDL-2
::Chinese text, Chinese text
if exist %tmpdir%\ptanalyse rd /s /q %tmpdir%\ptanalyse 1>>%logfile% 2>&1
md %tmpdir%\ptanalyse 1>>%logfile% 2>&1
set num=0
:QCEDL-3
if "%num%"=="%info__qcedl__lunnum%" ECHOC {%c_e%}Chinese text %parname%{%c_e%}& call log %logger% F Chinese text %parname%& goto FATAL
call log %logger% I Chinese text %num%
call partable readgpt qcedl %info__qcedl__memtype% %num% gptmain %tmpdir%\ptanalyse\gpt_main%num%.bin noprompt %port%
gpttool.exe -p %tmpdir%\ptanalyse\gpt_main%num%.bin -f print:default:#insl:sector:10 -o %tmpdir%\output.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %num% Chinese text{%c_e%}&& call log %logger% F Chinese text %num% Chinese text&& goto FATAL
set parsizesec=
for /f "tokens=4,5 delims= " %%a in ('type %tmpdir%\output.txt ^| find " %parname% "') do set parstartsec=%%a& set parsizesec=%%b
if "%parsizesec%"=="" set /a num+=1& goto QCEDL-3
::Chinese text, Chinese text
call log %logger% I Chinese text 9008 Chinese text %filepath%.lun:%num%. Chinese text:%parstartsec%. Chinese text:%parsizesec%
::Chinese text xml Chinese text, Chinese text xml
echo.^<?xml version="1.0" ?^>^<data^>^<program filename="%filepath_fullname%" physical_partition_number="%num%" label="%parname%" start_sector="%parstartsec%" num_partition_sectors="%parsizesec%" SECTOR_SIZE_IN_BYTES="%info__qcedl__secsize%" sparse="%sparse%"/^>^</data^>>%tmpdir%\tmp.xml
call write qcedlxml %port% %info__qcedl__memtype% %filepath_folder% %tmpdir%\tmp.xml
call log %logger% I 9008 Chinese text
ENDLOCAL
goto :eof


:SYSTEM
SETLOCAL
set logger=write.bat-system
set target=system
goto ADBDD


:RECOVERY
SETLOCAL
set logger=write.bat-recovery
set target=recovery
goto ADBDD


:ADBDD
::Chinese text
set parname=%args2%& set imgpath=%args3%
call log %logger% I Chinese text:parname:%parname%.imgpath:%imgpath%
:ADBDD-1
::Chinese text
if not exist %imgpath% ECHOC {%c_e%}Chinese text %imgpath%{%c_i%}{\n}& call log %logger% F Chinese text %imgpath%& goto FATAL
::Chinese text Root
if "%target%"=="system" (
    call log %logger% I Chinese text Root
    echo.su>%tmpdir%\cmd.txt& echo.exit>>%tmpdir%\cmd.txt& echo.exit>>%tmpdir%\cmd.txt
    adb.exe shell < %tmpdir%\cmd.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text Root Chinese text . Chinese text Shell Chinese text Root Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text Root Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBDD-1)
::Chinese text
call log %logger% I Chinese text %imgpath%
call write adbpush %imgpath% %parname%.img common
::adb.exe push %imgpath% %target%/%parname%.img 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %imgpath% Chinese text %target%/%parname%.img Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %imgpath% Chinese text %target%/%parname%.img Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBDD-1
::Chinese text
call info par %parname%
::Chinese text
if "%target%"=="system" echo.su>%tmpdir%\cmd.txt& echo.dd if=%write__adbpush__filepath% of=%info__par__path% >>%tmpdir%\cmd.txt& echo.rm %write__adbpush__filepath%>>%tmpdir%\cmd.txt
if "%target%"=="recovery" echo.dd if=%write__adbpush__filepath% of=%info__par__path% >%tmpdir%\cmd.txt& echo.rm %write__adbpush__filepath%>>%tmpdir%\cmd.txt
echo.exit>>%tmpdir%\cmd.txt & echo.exit>>%tmpdir%\cmd.txt
call log %logger% I Chinese text %write__adbpush__filepath% Chinese text %info__par__path%
adb.exe shell < %tmpdir%\cmd.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %write__adbpush__filepath% Chinese text %info__par__path% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %write__adbpush__filepath% Chinese text %info__par__path% Chinese text&& pause>nul && ECHO. Chinese text ... && goto ADBDD-1
ENDLOCAL
goto :eof


:FASTBOOT
SETLOCAL
set logger=write.bat-fastboot
::Chinese text
set parname=%args2%& set imgpath=%args3%
call log %logger% I Chinese text:parname:%parname%.imgpath:%imgpath%
:FASTBOOT-1
::Chinese text
if not exist %imgpath% ECHOC {%c_e%}Chinese text %imgpath%{%c_i%}{\n}& call log %logger% F Chinese text %imgpath%& goto FATAL
::Chinese text
call log %logger% I Chinese text %imgpath% Chinese text %parname%
fastboot.exe flash %parname% %imgpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %imgpath% Chinese text %parname% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %imgpath% Chinese text %parname% Chinese text&& pause>nul && ECHO. Chinese text ... && goto FASTBOOT-1
ENDLOCAL
goto :eof


:FASTBOOTD
SETLOCAL
set logger=write.bat-fastbootd
::Chinese text
set parname=%args2%& set imgpath=%args3%
call log %logger% I Chinese text:parname:%parname%.imgpath:%imgpath%
:FASTBOOTD-1
::Chinese text
if not exist %imgpath% ECHOC {%c_e%}Chinese text %imgpath%{%c_i%}{\n}& call log %logger% F Chinese text %imgpath%& goto FATAL
::Chinese text
call log %logger% I Chinese text %imgpath% Chinese text %parname%
fastboot.exe flash %parname% %imgpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %imgpath% Chinese text %parname% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %imgpath% Chinese text %parname% Chinese text&& pause>nul && ECHO. Chinese text ... && goto FASTBOOTD-1
ENDLOCAL
goto :eof


:FASTBOOTBOOT
SETLOCAL
set logger=write.bat-fastbootboot
::Chinese text
set imgpath=%args2%
call log %logger% I Chinese text:imgpath:%imgpath%
:FASTBOOTBOOT-1
::Chinese text
if not exist %imgpath% ECHOC {%c_e%}Chinese text %imgpath%{%c_i%}{\n}& call log %logger% F Chinese text %imgpath%& goto FATAL
::Chinese text
call log %logger% I Chinese text %imgpath%
fastboot.exe boot %imgpath% 1>>%logfile% 2>&1 && goto FASTBOOTBOOT-DONE
ECHOC {%c_e%}Chinese text %imgpath% Chinese text{%c_i%}{\n}& call log %logger% E Chinese text %imgpath% Chinese text
ECHO.1. Chinese text, Chinese text
ECHO.2. Chinese text, Chinese text, Chinese text
call input choice [1][2]
if "%choice%"=="2" goto FASTBOOTBOOT-DONE
call chkdev fastboot
ECHO. Chinese text ...
goto FASTBOOTBOOT-1
:FASTBOOTBOOT-DONE
ENDLOCAL
goto :eof








:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)

