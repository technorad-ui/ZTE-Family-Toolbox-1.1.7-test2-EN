::Chinese text: n

::call clean twrpfactoryreset
::           twrpformatdata
::           formatfat32       [name:Chinese text path:Chinese text]  [Chinese text(Chinese text,Chinese text)]
::           formatntfs        [name:Chinese text path:Chinese text]  [Chinese text(Chinese text,Chinese text)]
::           formatexfat       [name:Chinese text path:Chinese text]  [Chinese text(Chinese text,Chinese text)]
::           formatext4        [name:Chinese text path:Chinese text]  [Chinese text(Chinese text,Chinese text)]
::           qcedl             Chinese text                      Chinese text(Chinese text auto)        Chinese text(Chinese text,Chinese text)


@ECHO OFF
chcp 65001 >nul
set args1=%1& set args2=%2& set args3=%3& set args4=%4& set args5=%5& set args6=%6& set args7=%7& set args8=%8& set args9=%9
goto %args1%







:QCEDL
SETLOCAL
set logger=clean.bat-qcedl
::Chinese text
set parname=%args2%& set port=%args3%& set fh=%args4%
call log %logger% I Chinese text:parname:%parname%.port:%port%.fh:%fh%
:QCEDL-1
::Chinese text auto Chinese text
if "%port%"=="auto" call chkdev qcedl 1>nul
if "%port%"=="auto" set port=%chkdev__port__qcedl%
if "%port%"=="" call chkdev qcedl 1>nul
if "%port%"=="" set port=%chkdev__port__qcedl%
::Chinese text
if not "%fh%"=="" call write qcedlsendfh %port% %fh% auto
::Chinese text
call info qcedl %port%
if not "%info__qcedl__portstatus%"=="firehose" ECHOC {%c_e%}Chinese text firehose Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text firehose Chinese text& pause>nul & ECHO. Chinese text ... & goto QCEDL-1
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
call log %logger% I Chinese text 9008 Chinese text %parname%.lun:%num%. Chinese text:%parstartsec%. Chinese text:%parsizesec%
echo.^<erase SECTOR_SIZE_IN_BYTES="%info__qcedl__secsize%" physical_partition_number="%num%" label="%parname%" start_sector="%parstartsec%" num_partition_sectors="%parsizesec%"/^>>%tmpdir%\tmp.xml
fh_loader.exe --port=\\.\COM%port% --memoryname=%info__qcedl__memtype% --search_path=%tmpdir% --sendxml=%tmpdir%\tmp.xml --mainoutputdir=%tmpdir% --skip_config --noprompt 1>>%logfile% 2>&1 || goto QCEDL-FAILED
find "Erasing the whole disk" "%tmpdir%\port_trace.txt" 1>nul 2>nul && ECHOC {%c_e%}Chinese text %num%. Chinese text . Chinese text, Chinese text, Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %num% && goto FATAL
find "invalid " "%tmpdir%\port_trace.txt" | find " result -1" 1>nul 2>nul && goto QCEDL-FAILED
call log %logger% I 9008 Chinese text
ENDLOCAL
goto :eof
:QCEDL-FAILED
ECHOC {%c_e%}9008 Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E 9008 Chinese text& pause>nul & ECHO. Chinese text ...
goto QCEDL-1


:FORMATEXT4
SETLOCAL
set logger=clean.bat-formatext4
set target=%args2%& set label=%args3%
call log %logger% I Chinese text:target:%target%.label:%label%
call framework adbpre mke2fs
if "%target:~0,4%"=="name" (goto FORMATEXT4-1) else (goto FORMATEXT4-2)
:FORMATEXT4-1
call info par %target:~5,999%
set parpath=%info__par__path%
goto FORMATEXT4-3
:FORMATEXT4-2
set parpath=%target:~5,999%
goto FORMATEXT4-3
:FORMATEXT4-3
call log %logger% I Chinese text %parpath%. Chinese text
adb.exe shell umount -f -d %parpath% 1>>%logfile% 2>&1
call log %logger% I Chinese text EXT4. Chinese text:%parpath%
set var=
if not "%label%"=="" adb.exe shell ./mke2fs -F -v -t ext4 -L %label% %parpath% 1>>%logfile% 2>&1 || set var=n
if "%label%"=="" adb.exe shell ./mke2fs -F -v -t ext4 %parpath% 1>>%logfile% 2>&1 || set var=n
if "%var%"=="n" ECHOC {%c_e%}Chinese text EXT4 Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text EXT4 Chinese text& pause>nul & ECHO. Chinese text ... & goto FORMATEXT4-3
call log %logger% I Chinese text EXT4 Chinese text
ENDLOCAL
goto :eof


:FORMATEXFAT
SETLOCAL
set logger=clean.bat-formatexfat
set target=%args2%& set label=%args3%
call log %logger% I Chinese text:target:%target%.label:%label%
call framework adbpre mkfs.exfat
if "%target:~0,4%"=="name" (goto FORMATEXFAT-1) else (goto FORMATEXFAT-2)
:FORMATEXFAT-1
call info par %target:~5,999%
set parpath=%info__par__path%
goto FORMATEXFAT-3
:FORMATEXFAT-2
set parpath=%target:~5,999%
goto FORMATEXFAT-3
:FORMATEXFAT-3
call log %logger% I Chinese text %parpath%. Chinese text
adb.exe shell umount -f -d %parpath% 1>>%logfile% 2>&1
call log %logger% I Chinese text EXFAT. Chinese text:%parpath%
set var=
if not "%label%"=="" adb.exe shell ./mkfs.exfat -n %label% %parpath% 1>>%logfile% 2>&1 || set var=n
if "%label%"=="" adb.exe shell ./mkfs.exfat %parpath% 1>>%logfile% 2>&1 || set var=n
if "%var%"=="n" ECHOC {%c_e%}Chinese text EXFAT Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text EXFAT Chinese text& pause>nul & ECHO. Chinese text ... & goto FORMATEXFAT-3
call log %logger% I Chinese text EXFAT Chinese text
ENDLOCAL
goto :eof


:FORMATFAT32
SETLOCAL
set logger=clean.bat-formatfat32
set target=%args2%& set label=%args3%
call log %logger% I Chinese text:target:%target%.label:%label%
call framework adbpre mkfs.fat
if "%target:~0,4%"=="name" (goto FORMATFAT32-1) else (goto FORMATFAT32-2)
:FORMATFAT32-1
call info par %target:~5,999%
set parpath=%info__par__path%
goto FORMATFAT32-3
:FORMATFAT32-2
set parpath=%target:~5,999%
goto FORMATFAT32-3
:FORMATFAT32-3
call log %logger% I Chinese text %parpath%. Chinese text
adb.exe shell umount -f -d %parpath% 1>>%logfile% 2>&1
call log %logger% I Chinese text FAT32. Chinese text:%parpath%
set var=
if not "%label%"=="" adb.exe shell ./mkfs.fat -F 32 -n %label% %parpath% 1>>%logfile% 2>&1 || set var=n
if "%label%"=="" adb.exe shell ./mkfs.fat -F 32 %parpath% 1>>%logfile% 2>&1 || set var=n
::-S %disksecsize%
if "%var%"=="n" ECHOC {%c_e%}Chinese text FAT32 Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text FAT32 Chinese text& pause>nul & ECHO. Chinese text ... & goto FORMATFAT32-3
call log %logger% I Chinese text FAT32 Chinese text
ENDLOCAL
goto :eof


:FORMATNTFS
SETLOCAL
set logger=clean.bat-formatntfs
set target=%args2%& set label=%args3%
call log %logger% I Chinese text:target:%target%.label:%label%
call framework adbpre mkntfs
if "%target:~0,4%"=="name" (goto FORMATNTFS-1) else (goto FORMATNTFS-2)
:FORMATNTFS-1
call info par %target:~5,999%
set parpath=%info__par__path%
goto FORMATNTFS-3
:FORMATNTFS-2
set parpath=%target:~5,999%
goto FORMATNTFS-3
:FORMATNTFS-3
call log %logger% I Chinese text %parpath%. Chinese text
adb.exe shell umount -f -d %parpath% 1>>%logfile% 2>&1
call log %logger% I Chinese text NTFS. Chinese text:%parpath%
set var=
if not "%label%"=="" adb.exe shell ./mkntfs -Q -L %label% %parpath% 1>>%logfile% 2>&1 || set var=n
if "%label%"=="" adb.exe shell ./mkntfs -Q %parpath% 1>>%logfile% 2>&1 || set var=n
::-s %disksecsize%
if "%var%"=="n" ECHOC {%c_e%}Chinese text NTFS Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text NTFS Chinese text& pause>nul & ECHO. Chinese text ... & goto FORMATNTFS-3
call log %logger% I Chinese text NTFS Chinese text
ENDLOCAL
goto :eof


:TWRPFACTORYRESET
SETLOCAL
set logger=clean.bat-twrpfactoryreset
call log %logger% I Chinese text TWRP Chinese text
:TWRPFACTORYRESET-1
adb.exe shell twrp wipe data 1>%tmpdir%\output.txt 2>&1 || ECHOC {%c_e%}TWRP Chinese text Data Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& type %tmpdir%\output.txt>>%logfile% && call log %logger% E TWRP Chinese text Data Chinese text&& pause>nul && goto TWRPFACTORYRESET-1
type %tmpdir%\output.txt>>%logfile%
find "ata" "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}TWRP Chinese text Data Chinese text, TWRP Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E TWRP Chinese text Data Chinese text .TWRP Chinese text&& pause>nul && goto TWRPFACTORYRESET-1
adb.exe shell twrp wipe cache 1>%tmpdir%\output.txt 2>&1 || ECHOC {%c_e%}TWRP Chinese text Cache Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& type %tmpdir%\output.txt>>%logfile% && call log %logger% E TWRP Chinese text Cache Chinese text&& pause>nul && goto TWRPFACTORYRESET-1
type %tmpdir%\output.txt>>%logfile%
find "ache" "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}TWRP Chinese text Cache Chinese text, TWRP Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E TWRP Chinese text Cache Chinese text .TWRP Chinese text&& pause>nul && goto TWRPFACTORYRESET-1
adb.exe shell twrp wipe dalvik 1>%tmpdir%\output.txt 2>&1 || ECHOC {%c_e%}TWRP Chinese text Dalvik Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& type %tmpdir%\output.txt>>%logfile% && call log %logger% E TWRP Chinese text Dalvik Chinese text&& pause>nul && goto TWRPFACTORYRESET-1
type %tmpdir%\output.txt>>%logfile%
find "alvik" "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}TWRP Chinese text Dalvik Chinese text, TWRP Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E TWRP Chinese text Dalvik Chinese text .TWRP Chinese text&& pause>nul && goto TWRPFACTORYRESET-1
call log %logger% I TWRP Chinese text
ENDLOCAL
goto :eof


:TWRPFORMATDATA
SETLOCAL
set logger=clean.bat-twrpformatdata
call log %logger% I Chinese text TWRP Chinese text Data
:TWRPFORMATDATA-1
adb.exe shell twrp format data 1>%tmpdir%\output.txt 2>&1 || ECHOC {%c_e%}TWRP Chinese text Data Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& type %tmpdir%\output.txt>>%logfile% && call log %logger% E TWRP Chinese text Data Chinese text && pause>nul && goto TWRPFORMATDATA-1
type %tmpdir%\output.txt>>%logfile%
find "ata" "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}TWRP Chinese text Data Chinese text, TWRP Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E TWRP Chinese text Data Chinese text .TWRP Chinese text&& pause>nul && goto TWRPFORMATDATA-1
call reboot recovery recovery rechk 3
call log %logger% I TWRP Chinese text Data Chinese text
ENDLOCAL
goto :eof





:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)
