::call ztetoolbox confdevpre
::                edlsetbootablestoragedrive  Chinese text      Chinese text[auto emmc ufs spinor]   Chinese text(Chinese text,Chinese text)
::                edlreadall                  Chinese text      img Chinese text                    Chinese text(Chinese text,Chinese text)
::                chkproduct                  Chinese text


@ECHO OFF
chcp 65001 >nul
set args1=%1& set args2=%2& set args3=%3& set args4=%4& set args5=%5& set args6=%6& set args7=%7& set args8=%8& set args9=%9
goto %args1%




:CHKPRODUCT
SETLOCAL
set logger=ztetoolbox.bat-chkproduct
::Chinese text
set product_read=%args2%
call log %logger% I Chinese text:product_read:%product_read%
:CHKPRODUCT-1
if "%product_read%"=="%product%" goto CHKPRODUCT-DONE
if "%product%"=="P855A01" (
    if "%product_read%"=="P855A02" goto CHKPRODUCT-DONE
    if "%product_read%"=="P855A21" goto CHKPRODUCT-DONE)
if "%product%"=="P875A02" (
    if "%product_read%"=="P875A12" goto CHKPRODUCT-DONE
    if "%product_read%"=="P875N02" goto CHKPRODUCT-DONE
    if "%product_read%"=="NX666J" goto CHKPRODUCT-DONE)
if "%product%"=="P725A12" (
    if "%product_read%"=="P725A02" goto CHKPRODUCT-DONE)
if "%product%"=="P768A02" (
    if "%product_read%"=="P768S01" goto CHKPRODUCT-DONE)
if "%product%"=="NX729J" (
    if "%product_read%"=="NX729J-UN" goto CHKPRODUCT-DONE)
if "%product%"=="PQ83A01" (
    if "%product_read%"=="NX769J" goto CHKPRODUCT-DONE)
if "%product%"=="NP03J" (
    if "%product_read%"=="PQ83P01" goto CHKPRODUCT-DONE
    if "%product_read%"=="PQ83P02" goto CHKPRODUCT-DONE)
call log %logger% W Chinese text:Chinese text:%product_read%. Chinese text:%product%
ECHOC {%c_w%}Chinese text . Chinese text %product_read% Chinese text %product% Chinese text . Chinese text, Chinese text, Chinese text .{%c_i%}{\n}
pause>nul
ENDLOCAL
goto :eof
:CHKPRODUCT-DONE
call log %logger% I Chinese text:Chinese text:%product_read%. Chinese text:%product%
ENDLOCAL
goto :eof


:EDLREADALL
SETLOCAL
set edlreadall_customize=n
set logger=ztetoolbox.bat-edlreadall
::Chinese text
set port=%args2%& set imgpath=%args3%& set fh=%args4%
call log %logger% I Chinese text:port:%port%.imgpath:%imgpath%.fh:%fh%
:EDLREADALL-1
::Chinese text img Chinese text
if not exist %imgpath% ECHOC {%c_e%}Chinese text %imgpath%{%c_i%}{\n}& call log %logger% F Chinese text %imgpath%& goto FATAL
if not "%fh%"=="" (if not exist %fh% ECHOC {%c_e%}Chinese text %fh%{%c_i%}{\n}& call log %logger% F Chinese text %fh%& goto FATAL)
::Chinese text auto Chinese text
if not "%port%"=="auto" (if not "%port%"=="" goto EDLREADALL-2)
call chkdev qcedl 1>nul
set port=%chkdev__port__qcedl%
:EDLREADALL-2
::Chinese text
if not "%fh%"=="" call write qcedlsendfh %port% %fh% auto
::Chinese text
call info qcedl %port%
if not "%info__qcedl__portstatus%"=="firehose" ECHOC {%c_e%}Chinese text firehose Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text firehose Chinese text& pause>nul & ECHO. Chinese text ... & goto EDLREADALL-2
::Chinese text
if not exist %imgpath%\images md %imgpath%\images 1>>%logfile% 2>&1
if not exist %imgpath%\for_ROM_maker md %imgpath%\for_ROM_maker 1>>%logfile% 2>&1
if exist tool\Other\ReadAllFunc_Readme_Chs.txt copy /Y tool\Other\ReadAllFunc_Readme_Chs.txt %imgpath%\for_ROM_maker\ Chinese text .txt 1>nul
if exist tool\Other\ReadAllFunc_Readme_Eng.txt copy /Y tool\Other\ReadAllFunc_Readme_Eng.txt %imgpath%\for_ROM_maker\readme.txt 1>nul
if not exist %imgpath%\for_ROM_maker\orig md %imgpath%\for_ROM_maker\orig 1>>%logfile% 2>&1
if not exist %imgpath%\for_ROM_maker\generate md %imgpath%\for_ROM_maker\generate 1>>%logfile% 2>&1
::Chinese text, Chinese text
::    Chinese text partition.xml Chinese text
echo.^<?xml version="1.0" ?^>>%imgpath%\for_ROM_maker\orig\partition.xml
echo.^<configuration^>>>%imgpath%\for_ROM_maker\orig\partition.xml
echo.^<parser_instructions^>>>%imgpath%\for_ROM_maker\orig\partition.xml
echo.WRITE_PROTECT_BOUNDARY_IN_KB=0|find "=" 1>>%imgpath%\for_ROM_maker\orig\partition.xml
echo.SECTOR_SIZE_IN_BYTES = %info__qcedl__secsize%|find "=" 1>>%imgpath%\for_ROM_maker\orig\partition.xml
echo.GROW_LAST_PARTITION_TO_FILL_DISK=true>>%imgpath%\for_ROM_maker\orig\partition.xml
echo.^</parser_instructions^>>>%imgpath%\for_ROM_maker\orig\partition.xml
set xmls=
set num=0
:EDLREADALL-3
::    Chinese text lun Chinese text, Chinese text
if "%num%"=="%info__qcedl__lunnum%" goto EDLREADALL-5
echo.^<?xml version="1.0" ?^>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml& echo.^<data^>>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml
call partable readgpt qcedl %info__qcedl__memtype% %num% gptmain %imgpath%\for_ROM_maker\orig\gpt_main%num%.bin notice %port%
call partable readgpt qcedl %info__qcedl__memtype% %num% gptbackup %imgpath%\for_ROM_maker\orig\gpt_backup%num%.bin notice %port%
call log %logger% I Chinese text %num%
::ptanalyzer.exe -f %imgpath%\for_ROM_maker\orig\gpt_main%num%.bin -m %info__qcedl__memtype% -t gptmain -o normal_clear -shownonpartitioned y 1>%tmpdir%\output.txt 2>&1 || type %tmpdir%\output.txt>>%logfile% && ECHOC {%c_e%}Chinese text %num% Chinese text{%c_e%}&& call log %logger% F Chinese text %num% Chinese text&& goto FATAL
::type %tmpdir%\output.txt>>%logfile%
gpttool.exe -p %imgpath%\for_ROM_maker\orig\gpt_main%num%.bin -f print:default:default:sector:10 -o %tmpdir%\output.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %num% Chinese text{%c_e%}&& call log %logger% F Chinese text %num% Chinese text&& goto FATAL
::    Chinese text lun Chinese text partition.xml
echo.^<physical_partition^>>>%imgpath%\for_ROM_maker\orig\partition.xml
::ptanalyzer.exe -f %imgpath%\for_ROM_maker\orig\gpt_main%num%.bin -m %info__qcedl__memtype% -t gptmain -o xml_partition -shownonpartitioned y | find "partition label=" 1>>%imgpath%\for_ROM_maker\orig\partition.xml
gpttool.exe -p %imgpath%\for_ROM_maker\orig\gpt_main%num%.bin -f print:qcedl_partitionxml -o %tmpdir%\tmp.txt 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %num% Chinese text{%c_e%}&& call log %logger% F Chinese text %num% Chinese text&& goto FATAL
type %tmpdir%\tmp.txt>>%imgpath%\for_ROM_maker\orig\partition.xml
echo.^</physical_partition^>>>%imgpath%\for_ROM_maker\orig\partition.xml
::    Chinese text edlreadall-parlist.txt, Chinese text
echo. Chinese text %num% Chinese text . Unalloc_xxx Chinese text . Chinese text[]Chinese text . Chinese text ...>%tmpdir%\edlreadall-parlist.txt
for /f "tokens=3,6 delims= " %%a in ('type "%tmpdir%\output.txt" ^| find "["') do echo.[%%a]          %%b >>%tmpdir%\edlreadall-parlist.txt
busybox.exe sed -i "s/\[userdata\]/userdata/g;s/\[last_parti\]/last_parti/g;s/\[mindowsesp\]/mindowsesp/g;s/\[mindowswin\]/mindowswin/g;s/\[mindowsdat\]/mindowsdat/g" %tmpdir%\edlreadall-parlist.txt
if "%edlreadall_customize%"=="y" ECHOC {%c_h%}Chinese text %num% Chinese text ...{%c_i%}{\n}& start /wait tool\Win\Notepad3\Notepad3.exe %tmpdir%\edlreadall-parlist.txt & ECHO. Chinese text ...
set num2=1
:EDLREADALL-4
set parname=& set parsizesec=
for /f "tokens=3,4,6 delims= " %%a in ('type %tmpdir%\output.txt ^| find "[Item%num2%]"') do set parname=%%a& set parstartsec=%%b& set parsizesec=%%c
::    fastboot Chinese text, Chinese text lun Chinese text 1 Chinese text lun Chinese text
if "%num2%"=="1" echo.::fastboot flash partition:%num% %%~dp0images\gpt_both%num%.bin ^|^| @echo "Flash gpt_both%num%.bin error" >>%imgpath%\flash_all.bat
::    Chinese text lun Chinese text . Chinese text lun
if "%parname%"=="" (
    if "%info__qcedl__memtype%"=="ufs" (
        echo.^<program filename="gpt_main%num%.bin" label="PrimaryGPT" physical_partition_number="%num%" start_sector="0" num_partition_sectors="6" SECTOR_SIZE_IN_BYTES="%info__qcedl__secsize%"/^>>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml
        echo.^<program filename="gpt_backup%num%.bin" label="BackupGPT" physical_partition_number="%num%" start_sector="NUM_DISK_SECTORS-5." num_partition_sectors="5" SECTOR_SIZE_IN_BYTES="%info__qcedl__secsize%"/^>>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml
        echo.^</data^>>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml)
    if not "%info__qcedl__memtype%"=="ufs" (
        echo.^<program filename="gpt_main%num%.bin" label="PrimaryGPT" physical_partition_number="%num%" start_sector="0" num_partition_sectors="34" SECTOR_SIZE_IN_BYTES="%info__qcedl__secsize%"/^>>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml
        echo.^<program filename="gpt_backup%num%.bin" label="BackupGPT" physical_partition_number="%num%" start_sector="NUM_DISK_SECTORS-33." num_partition_sectors="33" SECTOR_SIZE_IN_BYTES="%info__qcedl__secsize%"/^>>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml
        echo.^</data^>>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml)
    set xmls=%xmls%/%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml
    set /a num+=1& goto EDLREADALL-3)
if "%parsizesec%"=="" ECHOC {%c_e%}Chinese text %parname% Chinese text{%c_e%}& call log %logger% F Chinese text %parname% Chinese text& goto FATAL
::Chinese text, Chinese text
find "[%parname%]" "%tmpdir%\edlreadall-parlist.txt" 1>nul 2>nul || goto EDLREADALL-6
goto EDLREADALL-7
:EDLREADALL-6
echo.^<program filename="" label="%parname%" physical_partition_number="%num%" start_sector="%parstartsec%" num_partition_sectors="%parsizesec%" SECTOR_SIZE_IN_BYTES="%info__qcedl__secsize%"/^>>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml
echo.::fastboot flash %parname% %%~dp0images\%parname%.img ^|^| @echo "Flash %parname% error" >>%imgpath%\flash_all.bat
call log %logger% I Chinese text 9008 Chinese text %parname%.lun:%num%. Chinese text:%num2%. Chinese text:%parstartsec%. Chinese text:%parsizesec%
goto EDLREADALL-8
:EDLREADALL-7
echo.^<program filename="%parname%.img" label="%parname%" physical_partition_number="%num%" start_sector="%parstartsec%" num_partition_sectors="%parsizesec%" SECTOR_SIZE_IN_BYTES="%info__qcedl__secsize%"/^>>>%imgpath%\for_ROM_maker\orig\rawprogram%num%.xml
echo.fastboot flash %parname% %%~dp0images\%parname%.img ^|^| @echo "Flash %parname% error" >>%imgpath%\flash_all.bat
goto EDLREADALL-8
:EDLREADALL-8
set /a num2+=1& goto EDLREADALL-4
:EDLREADALL-5
echo.^</configuration^>>>%imgpath%\for_ROM_maker\orig\partition.xml
if exist tool\Win\ptool.exe (
    ECHO. Chinese text xml Chinese text ...
    call log %logger% I Chinese text xml Chinese text
    ptool.exe -x %imgpath%\for_ROM_maker\orig\partition.xml -t %imgpath%\for_ROM_maker\generate 1>>%logfile% 2>&1
    call log %logger% I Chinese text xml Chinese text)
::Chinese text
ECHO. Chinese text ... & call read qcedlxml %port% %info__qcedl__memtype% %imgpath%\images %xmls%
::Chinese text rawprogram.xml
copy /Y %imgpath%\for_ROM_maker\orig\rawprogram*.xml %imgpath%\images 1>>%logfile% 2>&1
call log %logger% I 9008 Chinese text
ENDLOCAL
goto :eof


:EDLSETBOOTABLESTORAGEDRIVE
SETLOCAL
set logger=ztetoolbox.bat-edlsetbootablestoragedrive
set port=%args2%& set storagetype=%args3%& set fh=%args4%
call log %logger% I Chinese text:port:%port%.storagetype:%storagetype%.fh:%fh%
:EDLSETBOOTABLESTORAGEDRIVE-1
::Chinese text
if not "%fh%"=="" (if not exist %fh% ECHOC {%c_e%}Chinese text %fh%{%c_i%}{\n}& call log %logger% F Chinese text %fh%& goto FATAL)
::Chinese text
if not "%fh%"=="" call write qcedlsendfh %port% %fh% %storagetype%
::Chinese text
set storagetype_use=%storagetype%
if "%storagetype%"=="auto" call info qcedl %port%
if "%storagetype%"=="auto" set storagetype_use=%info__qcedl__memtype%
::Chinese text
set value=
if "%storagetype_use%"=="emmc"   set value=0
if "%storagetype_use%"=="spinor" set value=0
if "%storagetype_use%"=="ufs"    ECHO. Chinese text ... & call slot qcedl chk
if "%storagetype_use%"=="ufs"    (
    ::Chinese text: Chinese text slot.bat
    if "%slot__cur%"=="aonly" set value=1
    if "%slot__cur%"=="a"     set value=1
    if "%slot__cur%"=="b"     set value=2)
if not "%value%"=="" (
    echo.^<?xml version="1.0" ?^>^<data^>^<setbootablestoragedrive value="%value%" /^>^</data^>>%tmpdir%\cmd.xml
    fh_loader.exe --port=\\.\COM%port% --memoryname=%storagetype_use% --search_path=%tmpdir% --sendxml=cmd.xml --mainoutputdir=%tmpdir% --skip_config --noprompt 1>>%logfile% 2>&1 || ECHOC {%c_e%}setbootablestoragedrive %value% Chinese text{%c_i%}{\n}&& call log %logger% E setbootablestoragedrive%value% Chinese text
)
call log %logger% I edlsetbootablestoragedrive%value% Chinese text
ENDLOCAL & set edlsetbootablestoragedrive__value=%value%
goto :eof


:CONFDEVPRE
SETLOCAL
set logger=ztetoolbox.bat-confdevpre
set num=2
:CONFDEVPRE-1
if %num% GTR 31 ECHOC {%c_e%}Chinese text, Chinese text{%c_i%}{\n}& goto FATAL
for /f "tokens=%num% delims=[]," %%i in ('find "[product]" "conf\dev.csv"') do set name=%%i
if "%name%"=="done" goto CONFDEVPRE-2
for /f "tokens=%num% delims=," %%i in ('find "[%product%]" "conf\dev.csv"') do set value=%%i
call framework conf dev-%product%.bat %name% %value%
set /a num+=1
goto CONFDEVPRE-1
:CONFDEVPRE-2
ENDLOCAL
call conf\dev-%product%.bat
goto :eof










:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)


