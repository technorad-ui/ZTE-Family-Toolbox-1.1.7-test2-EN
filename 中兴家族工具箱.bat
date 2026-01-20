::Chinese text,Chinese text .

::Chinese text,Chinese text
@ECHO OFF
chcp 65001 >nul
cd /d %~dp0
if exist bin (cd bin) else (ECHO. Chinese text bin. Chinese text, Chinese text . & goto FATAL)

::Chinese text,Chinese text
if exist conf\fixed.bat (call conf\fixed) else (ECHO. Chinese text conf\fixed.bat & goto FATAL)
if exist conf\user.bat call conf\user
if not "%product%"=="" (if exist conf\dev-%product%.bat call conf\dev-%product%.bat)

::Chinese text,Chinese text
if "%framework_theme%"=="" set framework_theme=default
call framework theme %framework_theme%
COLOR %c_i%

::Chinese text,Chinese text
TITLE Chinese text ...
mode con cols=71

::Chinese text,Chinese text
if not exist tool\Win\gap.exe ECHO. Chinese text gap.exe. Chinese text, Chinese text . & goto FATAL
tool\Win\gap.exe %0 || EXIT

::Chinese text,Chinese text
call framework startpre
::call framework startpre skiptoolchk

::Chinese text . Chinese text
TITLE [Chinese text] Chinese text %prog_ver% by Chinese text@Chinese text [Chinese text Chinese text]
CLS
if "%product%"=="" goto SELDEV
if not exist conf\dev-%product%.bat goto SELDEV
goto MENU



:MENU
TITLE [%model%] Chinese text %prog_ver% by Chinese text@Chinese text [Chinese text Chinese text]
if not exist res\%product%\bak md res\%product%\bak
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text %prog_ver% by Chinese text@Chinese text [Chinese text Chinese text]
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO.
ECHOC {%c_w%}[%model%]{%c_i%} %cpu%{%c_i%}{\n}
ECHOC {%c_we%}Chinese text"Chinese text"Chinese text{%c_i%}{\n}
ECHO.
ECHO.
ECHO.^< Chinese text: Root Chinese text BL Chinese text, Chinese text! ^>
ECHO.
ECHO.0. Chinese text BL           000. Chinese text BL(Chinese text)
ECHO.1. Chinese text Root         111.Root Chinese text
ECHO.2.9008 Chinese text
ECHO.3. Chinese text Recovery(TWRP)
ECHO.4. Chinese text(Chinese text)
ECHO.
::ECHO.10. Chinese text  11.9008 Chinese text
::ECHO.11.9008 Chinese text    
ECHO.14.adb Chinese text
ECHO.12. Chinese text    13. Chinese text
::ECHO.         15. Chinese text Fastboot
ECHO.16. Chinese text, Chinese text  17. Chinese text QCN
ECHO.
ECHO.A. Chinese text
ECHO.B. Chinese text
ECHO.C. Chinese text (Chinese text: ebxn)
ECHO.D. Chinese text
ECHO.
ECHO.E. Chinese text
ECHO.F. Chinese text (Chinese text 9008 Chinese text, TWRP Chinese text)
ECHO.G. Chinese text BFF
ECHO.
call input choice [0][000][1][111][2][3][4][12][13][14][16][17][A][B][C][D]#[E][F][G]
if "%choice%"=="0" goto UNLOCKBL
if "%choice%"=="000" goto LOCKBL
if "%choice%"=="1" goto ROOT
if "%choice%"=="111" goto ROOT-REC
if "%choice%"=="2" goto EDLFLASHFULL
if "%choice%"=="3" goto FLASHREC
if "%choice%"=="4" goto BAKALL
if "%choice%"=="10" goto NUBIAUNLOCK
if "%choice%"=="11" goto EDLSENDFH
if "%choice%"=="12" goto WRITEPAR
if "%choice%"=="13" goto READPAR
if "%choice%"=="14" call scrcpy Chinese text -adb Chinese text
if "%choice%"=="15" goto ENTERDBGFB
if "%choice%"=="16" goto SLOT
if "%choice%"=="17" goto QCN
if "%choice%"=="A" call open folder res\%product%\bak
if "%choice%"=="B" goto SELDEV
if "%choice%"=="C" call open common https://syxz.lanzoue.com/b01g0i33c
if "%choice%"=="D" goto THEME
if "%choice%"=="E" start "" "https://yhfx.jwznb.com/share?key=BBmdd7wE9CNv&ts=1707895931 "
if "%choice%"=="F" call open common https://www.yhcres.top/
if "%choice%"=="G" call open common https://gitee.com/mouzei/bff
goto MENU




:ENLARGESUPER
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text super
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. [%model%]
ECHO.
ECHO.- Chinese text:
ECHO. Chinese text super Chinese text
ECHO. Chinese text userdata Chinese text super, Chinese text super Chinese text super_other
ECHO. Chinese text, Chinese text
ECHO. 
ECHO.
ECHO.
ECHO.
EXIT






:QCN
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text, Chinese text QCN
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. [%model%]
ECHO.
ECHO.QCN Chinese text, Chinese text . Chinese text QFIL Chinese text QCN Chinese text . Chinese text Root Chinese text .
ECHO.
ECHO.1. Chinese text QCN   2. Chinese text QCN   A. Chinese text
ECHO.
call input choice [1][2][A]
ECHO.
if "%choice%"=="A" goto MENU
if "%choice%"=="1" goto QCN-READ
if "%choice%"=="2" goto QCN-WRITE
EXIT
:QCN-READ
ECHOC {%c_h%}Chinese text USB Chinese text ...{%c_i%}{\n}& call chkdev system rechk 1
ECHO. Chinese text ... & call reboot system qcdiag rechk 1
for /f %%a in ('gettime.exe') do set baktime=%%a
ECHO. Chinese text QCN Chinese text bin\res\%product%\bak\qcnbak_%baktime%.qcn . Chinese text, Chinese text ... & call read qcdiag %chkdev__port__qcdiag% res\%product%\bak\qcnbak_%baktime%.qcn
goto QCN-DONE
:QCN-WRITE
ECHOC {%c_h%}Chinese text QCN Chinese text ...{%c_i%}{\n}& call sel file s %framework_workspace%\res\%product%\bak [qcn]
ECHOC {%c_h%}Chinese text USB Chinese text ...{%c_i%}{\n}& call chkdev system rechk 1
ECHO. Chinese text ... & call reboot system qcdiag rechk 1
ECHO. Chinese text QCN. Chinese text, Chinese text ... & call write qcdiag %chkdev__port__qcdiag% %sel__file_path%
goto QCN-DONE
:QCN-DONE
ECHOC {%c_s%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto MENU


:BAKALL
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text(Chinese text)
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. [%model%]
ECHO.
ECHO.- Chinese text:
ECHO. Chinese text(userdata Chinese text last_parti Chinese text)Chinese text
ECHO. Chinese text
ECHO. Chinese text xml, Chinese text"9008 Chinese text"Chinese text
ECHO. Chinese text, Chinese text, Chinese text, Chinese text, Chinese text
ECHO. Chinese text
ECHO.
ECHOC {%c_h%}Chinese text, Chinese text ...{%c_i%}{\n}& pause>nul
ECHO.
ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& call sel folder s %framework_workspace%\..
ECHOC {%c_h%}Chinese text 9008...{%c_i%}{\n}& call chkdev qcedl rechk 1
for /f %%a in ('gettime.exe ^| find "."') do set baktime=%%a
md %sel__folder_path%\ZTEToolBoxParBak_%baktime% 1>nul || ECHOC {%c_e%}Chinese text %sel__folder_path%\ZTEToolBoxParBak_%baktime% Chinese text{%c_i%}{\n}&& goto FATAL
start framework logviewer start %logfile%
ECHO. Chinese text ... & call write qcedlsendfh %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
ECHO. Chinese text 9008 Chinese text ... & call ztetoolbox edlreadall %chkdev__port__qcedl% %sel__folder_path%\ZTEToolBoxParBak_%baktime%
ECHO.9008 Chinese text . Chinese text ... & call reboot qcedl system
call framework logviewer end
ECHOC {%c_s%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto MENU


:SLOT
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text, Chinese text
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. [%model%]
ECHO.
if "%parlayout%"=="aonly" ECHO.%model% Chinese text . Chinese text ... & pause>nul & goto MENU
set slot__a_unbootable=& set slot__b_unbootable=
ECHOC {%c_h%}Chinese text, Recovery, Fastboot Chinese text 9008 Chinese text ...{%c_i%}{\n}& call chkdev all
::if not "%chkdev__mode%"=="system" (if not "%chkdev__mode%"=="recovery" (if not "%chkdev__mode%"=="fastboot" ECHOC {%c_e%}Chinese text, Chinese text, Recovery Chinese text Fastboot Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text:%chkdev__mode%. Chinese text Recovery Chinese text Fastboot Chinese text& pause>nul & ECHO. Chinese text ... & goto SLOT))
if "%chkdev__mode%"=="qcedl" ECHO. Chinese text ... & call write qcedlsendfh %chkdev__port% %framework_workspace%\res\%product%\devprg auto
ECHO. Chinese text ... & call slot %chkdev__mode% chk
ECHO.
    ECHOC {%c_i%}Chinese text: %slot__cur%{%c_i%}
    if "%slot__cur_unbootable%"=="yes" ECHOC {%c_e%}(Chinese text){%c_i%}
    ECHOC {%c_i%}   {%c_i%}
    ECHOC {%c_i%}Chinese text: %slot__cur_oth%{%c_i%}
    if "%slot__cur_unbootable%"=="yes" ECHOC {%c_e%}(Chinese text){%c_i%}
    ECHOC {%c_i%}{\n}
ECHO.
ECHO.A. Chinese text a Chinese text   B. Chinese text b Chinese text   C. Chinese text
ECHO.
call input choice [A][B]#[C]
if "%choice%"=="A" set target=a
if "%choice%"=="B" set target=b
if "%choice%"=="C" goto MENU
ECHO. Chinese text %target% ... & call slot %chkdev__mode% set %target%
if "%chkdev__mode%"=="qcedl" call reboot qcedl qcedl
goto SLOT


:FLASHREC
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text Recovery(TWRP)
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. [%model%]  Chinese text: %parlayout%
ECHO.
ECHO.- Chinese text:
ECHO. Chinese text BL Chinese text
if not "%parlayout%"=="ab" ECHO. Chinese text boot Chinese text recovery Chinese text . Chinese text Root Chinese text .
ECHO.
ECHO.1. Chinese text   2.Fastboot Chinese text   3. Chinese text TWRP Chinese text boot Chinese text(Chinese text recovery Chinese text)
ECHO.A. Chinese text TWRP   B. Chinese text
ECHO.
call input choice #[1][2][3][A][B]
if "%choice%"=="1" set func=flash
if "%choice%"=="2" set func=boot
if "%choice%"=="3" set func=recinst
if "%choice%"=="A" call open common https://yhcres.top/ & call open common https://twrp.me/Devices/ & goto FLASHREC
if "%choice%"=="B" goto MENU
ECHO.
goto FLASHREC-%func%
:FLASHREC-RECINST
if not "%parlayout%"=="ab" ECHO.%model% Chinese text . Chinese text ... & pause>nul & goto FLASHREC
ECHOC {%c_h%}Chinese text TWRP Chinese text ...{%c_i%}{\n}& call sel file s %framework_workspace%\.. [img]
set recpath=%sel__file_path%
ECHOC {%c_h%}Chinese text boot Chinese text ...{%c_i%}{\n}& call sel file s %framework_workspace%\.. [img]
set bootpath=%sel__file_path%
ECHOC {%c_h%}Chinese text boot Chinese text ...{%c_i%}{\n}& call sel folder s %framework_workspace%\..
ECHO. Chinese text recovery... & call imgkit recinst %bootpath% %sel__folder_path%\boot_new.img %recpath%
ECHO. Chinese text boot Chinese text %sel__folder_path%\boot_new.img.
goto FLASHREC-DONE
:FLASHREC-BOOT
ECHOC {%c_h%}Chinese text TWRP Chinese text ...{%c_i%}{\n}& call sel file s %framework_workspace%\.. [img]
ECHOC {%c_h%}Chinese text Fastboot...{%c_i%}{\n}& call chkdev fastboot
ECHO. Chinese text ... & call write fastbootboot %sel__file_path%
goto FLASHREC-DONE
:FLASHREC-FLASH
ECHOC {%c_h%}Chinese text TWRP Chinese text ...{%c_i%}{\n}& call sel file s %framework_workspace%\.. [img]
ECHOC {%c_h%}Chinese text USB Chinese text ...{%c_i%}{\n}& call chkdev system rechk 1
if not "%parlayout%"=="aonly" ECHO. Chinese text ... & call slot system chk
ECHO. Chinese text: %slot__cur%
ECHO. Chinese text 9008... & call reboot system qcedl rechk 1
goto FLASHREC-FLASH-%parlayout%
:FLASHREC-FLASH-AONLY
ECHO. Chinese text recovery...
for /f %%a in ('gettime.exe ^| find "."') do set baktime=%%a
call read qcedl recovery res\%product%\bak\recovery_%baktime%.img notice %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
ECHO. Chinese text bin\res\%product%\bak\recovery_%baktime%.img.
ECHO. Chinese text recovery... & call write qcedl recovery %sel__file_path%
goto FLASHREC-FLASH-DONE
:FLASHREC-FLASH-AB_REC
ECHO. Chinese text recovery_%slot__cur%...
for /f %%a in ('gettime.exe ^| find "."') do set baktime=%%a
call read qcedl recovery_%slot__cur% res\%product%\bak\recovery_%slot__cur%_%baktime%.img notice %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
ECHO. Chinese text bin\res\%product%\bak\recovery_%slot__cur%_%baktime%.img.
ECHO. Chinese text recovery_%slot__cur%... & call write qcedl recovery_%slot__cur% %sel__file_path%
goto FLASHREC-FLASH-DONE
:FLASHREC-FLASH-AB
ECHO. Chinese text boot_%slot__cur%...
for /f %%a in ('gettime.exe ^| find "."') do set baktime=%%a
call read qcedl boot_%slot__cur% res\%product%\bak\boot_%slot__cur%_%baktime%.img notice %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
ECHO. Chinese text bin\res\%product%\bak\boot_%slot__cur%_%baktime%.img.
ECHO. Chinese text recovery... & call imgkit recinst %framework_workspace%\res\%product%\bak\boot_%slot__cur%_%baktime%.img %tmpdir%\boot_rec.img %sel__file_path% noprompt
ECHO. Chinese text boot_%slot__cur%... & call write qcedl boot_%slot__cur% %tmpdir%\boot_rec.img
goto FLASHREC-FLASH-DONE
:FLASHREC-FLASH-DONE
ECHO.
ECHO.1. Chinese text Recovery   2. Chinese text
call input choice #[1][2]
if "%choice%"=="1" ECHO. Chinese text Recovery... & call reboot qcedl recovery
goto FLASHREC-DONE
:FLASHREC-DONE
ECHO. & ECHOC {%c_s%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto FLASHREC


:NUBIAUNLOCK
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
if not "%product:~0,2%"=="NX" ECHO.%model% Chinese text . Chinese text ... & pause>nul & goto MENU
ECHOC {%c_h%}Chinese text Fastboot...{%c_i%}{\n}& call chkdev fastboot
ECHO.fastboot.exe oem nubia_unlock NUBIA_%product% & ECHO.
fastboot.exe oem nubia_unlock NUBIA_%product%
ECHO. & ECHO. Chinese text . Chinese text ... & pause>nul & goto MENU


:READPAR
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text(Chinese text Root), TWRP, 9008 Chinese text
ECHO. Chinese text exit Chinese text
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& call sel folder s %framework_workspace%\..
ECHO.
:READPAR-1
ECHOC {%c_i%}=--------------------------------------------------------------------={%c_i%}{\n}
if not "%parname%"=="" ECHO. Chinese text: %parname%
ECHOC {%c_h%}Chinese text: {%c_i%}& set /p parname=
if "%parname%"=="" goto READPAR-1
if "%parname%"=="exit" goto MENU
:READPAR-2
call chkdev all
ECHO. Chinese text ... & call read %chkdev__mode% %parname% %sel__folder_path%\%parname%.img notice %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
if "%chkdev__mode%"=="qcedl" call reboot qcedl qcedl
ECHOC {%c_s%}Chinese text{%c_i%}{\n}& goto READPAR-1


:WRITEPAR
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text(Chinese text Root), TWRP, Fastboot, 9008 Chinese text
ECHO. Chinese text exit Chinese text
ECHO.
:WRITEPAR-1
ECHOC {%c_i%}=--------------------------------------------------------------------={%c_i%}{\n}
if not "%parname%"=="" ECHO. Chinese text: %parname%
ECHOC {%c_h%}Chinese text: {%c_i%}& set /p parname=
if "%parname%"=="" goto WRITEPAR-1
if "%parname%"=="exit" goto MENU
if "%imgfolder%"=="" set imgfolder=%framework_workspace%\..
ECHOC {%c_h%}Chinese text %parname% Chinese text ...{%c_i%}{\n}& call sel file s %imgfolder%
set imgfolder=%sel__file_folder%
:WRITEPAR-2
call chkdev all
ECHO. Chinese text ... & call write %chkdev__mode% %parname% %sel__file_path% %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
if "%chkdev__mode%"=="qcedl" call reboot qcedl qcedl
ECHOC {%c_s%}Chinese text{%c_i%}{\n}& goto WRITEPAR-1


:EDLFLASHFULL
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO.9008 Chinese text
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. [%model%]  Chinese text: %parlayout%
ECHO.
ECHO. Chinese text: Chinese text . Chinese text[Chinese text]Chinese text 9008 Chinese text .
ECHO.
:EDLFLASHFULL-NOTICE
ECHO.1. Chinese text   2. Chinese text   3. Chinese text
call input choice #[1][2][3]
ECHO.
if "%choice%"=="1" call open common https://gitee.com/geekflashtool
if "%choice%"=="1" goto EDLFLASHFULL-NOTICE
if "%choice%"=="3" goto MENU
ECHO.- Chinese text
ECHO. Chinese text QFIL Chinese text 9008 Chinese text
ECHO. 9008 Chinese text
ECHO. Chinese text
ECHO. Chinese text, Chinese text, Chinese text, Chinese text
ECHO. Chinese text 9008 Chinese text, Chinese text userdata.img, Chinese text
ECHO. Chinese text, Chinese text
ECHO.
ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul
ECHO.
set alreadypreedl=n
:EDLFLASHFULL-1
ECHOC {%c_h%}Chinese text 9008 Chinese text xml Chinese text ...{%c_i%}{\n}& call sel folder s %framework_workspace%\..
if "%alreadypreedl%"=="y" goto EDLFLASHFULL-3
set fhpath=%framework_workspace%\res\%product%\devprg
if not exist %framework_workspace%\res\%product%\devprg ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& call sel file s %sel__folder_path% [elf][mbn]
if not exist %framework_workspace%\res\%product%\devprg set fhpath=%sel__file_path%
ECHOC {%c_h%}Chinese text 9008. Chinese text, Chinese text, Chinese text 9008, Chinese text ...{%c_i%}{\n}& call chkdev qcedl rechk 1
ECHO. Chinese text ... & call write qcedlsendfh %chkdev__port__qcedl% %fhpath%
ECHO. Chinese text ... & call info qcedl %chkdev__port__qcedl%
ECHO. Chinese text: %info__qcedl__memtype%
set alreadypreedl=y
:EDLFLASHFULL-3
ECHO. Chinese text ...
goto EDLFLASHFULL-%info__qcedl__memtype%
:EDLFLASHFULL-UFS
    if exist %sel__folder_path%\rawprogram0.xml (set xmls=rawprogram0.xml) else (goto EDLFLASHFULL-FILENOTFOUND)
    if exist %sel__folder_path%\patch0.xml set xmls=%xmls%/patch0.xml
    if exist %sel__folder_path%\rawprogram1.xml (set xmls=%xmls%/rawprogram1.xml) else (goto EDLFLASHFULL-FILENOTFOUND)
    if exist %sel__folder_path%\patch1.xml set xmls=%xmls%/patch1.xml
    if exist %sel__folder_path%\rawprogram2.xml (set xmls=%xmls%/rawprogram2.xml) else (goto EDLFLASHFULL-FILENOTFOUND)
    if exist %sel__folder_path%\patch2.xml set xmls=%xmls%/patch2.xml
    if exist %sel__folder_path%\rawprogram3.xml (set xmls=%xmls%/rawprogram3.xml) else (goto EDLFLASHFULL-FILENOTFOUND)
    if exist %sel__folder_path%\patch3.xml set xmls=%xmls%/patch3.xml
    if exist %sel__folder_path%\rawprogram4.xml (set xmls=%xmls%/rawprogram4.xml) else (goto EDLFLASHFULL-FILENOTFOUND)
    if exist %sel__folder_path%\patch4.xml set xmls=%xmls%/patch4.xml
    if exist %sel__folder_path%\rawprogram5.xml (set xmls=%xmls%/rawprogram5.xml) else (goto EDLFLASHFULL-FILENOTFOUND)
    if exist %sel__folder_path%\patch5.xml set xmls=%xmls%/patch5.xml
goto EDLFLASHFULL-2
:EDLFLASHFULL-EMMC
    if not exist %sel__folder_path%\rawprogram0.xml goto EDLFLASHFULL-FILENOTFOUND
    set xmls=rawprogram0.xml
    if exist %sel__folder_path%\patch0.xml set xmls=%xmls%/patch0.xml
goto EDLFLASHFULL-2
:EDLFLASHFULL-2
ECHO. Chinese text xml: & ECHOC {%c_we%}%xmls%{%c_i%}{\n}
start framework logviewer start %logfile%
ECHO. Chinese text 9008 Chinese text ... & call write qcedlxml %chkdev__port__qcedl% %info__qcedl__memtype% %sel__folder_path% %xmls%
ECHO.setbootablestoragedrive... & call ztetoolbox edlsetbootablestoragedrive %chkdev__port__qcedl% %info__qcedl__memtype%
ECHO. Chinese text .
call framework logviewer end
ECHO.
ECHO.1. Chinese text(Chinese text)   2. Chinese text
call input choice #[1][2]
ECHO.
if "%choice%"=="2" ECHO. Chinese text misc... & call write qcedl misc tool\Android\misc_wipedata.img %chkdev__port__qcedl%
ECHO. Chinese text ... & call reboot qcedl system
ECHO.
ECHOC {%c_s%}Chinese text . {%c_i%}Chinese text, Chinese text Recovery Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto MENU
:EDLFLASHFULL-FILENOTFOUND
ECHOC {%c_e%}Chinese text(Chinese text rawprogram0.xml). Chinese text . {%c_h%}Chinese text, Chinese text ...{%c_i%}{\n}& pause>nul & goto EDLFLASHFULL-1


:ROOT-REC
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO.Root Chinese text
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. [%model%]   Chinese text: Chinese text %bootpar%
ECHO.
ECHO.- Chinese text
ECHO. Chinese text Root Chinese text %bootpar%.
if "%parlayout:~0,2%"=="ab" ECHO. Chinese text ab Chinese text .
ECHO.
ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul
ECHO.
ECHOC {%c_h%}Chinese text %bootpar% Chinese text ...{%c_i%}{\n}& call sel file s %framework_workspace%\res\%product%\bak [img]
ECHOC {%c_h%}Chinese text 9008...{%c_i%}{\n}& call chkdev qcedl rechk 1
if "%parlayout:~0,2%"=="ab" (
    ECHO. Chinese text %bootpar%_a... & call write qcedl %bootpar%_a %sel__file_path% %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
    ECHO. Chinese text %bootpar%_b... & call write qcedl %bootpar%_b %sel__file_path% %chkdev__port__qcedl%)
if not "%parlayout:~0,2%"=="ab" ECHO. Chinese text %bootpar%... & call write qcedl %bootpar% %sel__file_path% %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
ECHO. Chinese text ... & call reboot qcedl system
ECHO.
ECHOC {%c_s%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto MENU


:ROOT
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text Root
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. [%model%]   Root Chinese text: Magisk Chinese text %bootpar%
ECHO.
ECHO.- Chinese text
ECHO. Root Chinese text BL
ECHO. Chinese text Magisk Chinese text
ECHO. Chinese text, Chinese text
ECHO. Chinese text Root Chinese text, Chinese text Magisk Chinese text
ECHO. Chinese text Magisk, Chinese text %bootpar% Chinese text
ECHO. Chinese text Root Chinese text, Chinese text Root Chinese text
ECHO.
ECHO.
ECHO.1.[Chinese text]Chinese text Magisk Chinese text
ECHO.A. Chinese text Magisk Chinese text
ECHO.B. Chinese text
ECHO.C. Chinese text
ECHO.
call input choice #[1][A][B][C]
ECHO.
if "%choice%"=="1" set zippath=..\Magisk29.0.apk
if "%choice%"=="A" ECHOC {%c_h%}Chinese text Magisk Chinese text apk...{%c_i%}{\n}& call sel file s %framework_workspace%\.. [zip][apk]
if "%choice%"=="A" set zippath=%sel__file_path%
if "%choice%"=="B" call open pic pic\magiskqa.jpg & goto ROOT
if "%choice%"=="C" goto MENU
ECHOC {%c_h%}Chinese text, Chinese text USB Chinese text ...{%c_i%}{\n}& call chkdev system rechk 1
start framework logviewer start %logfile%
ECHO. Chinese text ...
call info adb
call ztetoolbox chkproduct %info__adb__product%
if "%parlayout:~0,2%"=="ab" call slot system chk
if "%parlayout:~0,2%"=="ab" (set targetpar=%bootpar%_%slot__cur%) else (set targetpar=%bootpar%)
ECHOC {%c_we%}Chinese text: %info__adb__product%{%c_i%}{\n}
ECHOC {%c_we%}Chinese text: %info__adb__androidver%{%c_i%}{\n}
ECHOC {%c_we%}Chinese text: %targetpar%{%c_i%}{\n}
ECHO. Chinese text 9008... & call reboot system qcedl rechk 1
ECHO. Chinese text %targetpar%...
for /f %%a in ('gettime.exe ^| find "."') do set baktime=%%a
call read qcedl %targetpar% res\%product%\bak\%targetpar%_%baktime%.img notice %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
ECHO. Chinese text bin\res\%product%\bak.
ECHO.Magisk Chinese text ... & call imgkit magiskpatch %framework_workspace%\res\%product%\bak\%targetpar%_%baktime%.img %tmpdir%\boot_patched.img %zippath% noprompt
ECHO. Chinese text %targetpar%... & call write qcedl %targetpar% %tmpdir%\boot_patched.img %chkdev__port__qcedl%
ECHO. Chinese text ... & call reboot qcedl system
call framework logviewer end
ECHO.
ECHOC {%c_s%}Chinese text . {%c_h%}Chinese text
if "%zippath%"=="..\Magisk29.0.apk" (ECHOC {%c_h%}Chinese text Magisk29.0.apk. ) else (ECHOC {%c_h%}Chinese text Magisk APP. )
ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto MENU


:LOCKBL
set lockbl_chk=n
set lockbl_autoerase=n
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text BL
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
if "%blplan%"=="n" ECHO.%model% Chinese text BL. Chinese text ... & pause>nul & goto MENU
ECHO. [%model%]   Chinese text: %blplan%
ECHO.
ECHO.- Chinese text BL Chinese text:
ECHO. Chinese text
ECHO. Chinese text
ECHO. ...
ECHO.
ECHO.- Chinese text BL Chinese text (Chinese text):
ECHO. Chinese text
ECHO. Chinese text
ECHO. Chinese text
ECHO. Chinese text, Chinese text, Chinese text
ECHO. Chinese text
ECHO. Chinese text
ECHO. Chinese text 9008 Chinese text
ECHO.
ECHO.- Chinese text BL Chinese text, Chinese text BL. Chinese text, Chinese text .
ECHO.
ECHO.
ECHOC {%c_h%}Chinese text, Chinese text ...{%c_i%}{\n}& pause>nul
ECHO.
:LOCKBL-1
ECHOC {%c_h%}Chinese text, Chinese text USB Chinese text ...{%c_i%}{\n}& call chkdev all rechk 1
if "%chkdev__mode%"=="system" goto LOCKBL-2
if "%blplan%"=="direct" (if not "%chkdev__mode%"=="fastboot" ECHOC {%c_e%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto LOCKBL-1)
if "%blplan%"=="flashabl" (if not "%chkdev__mode%"=="qcedl" ECHOC {%c_e%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto LOCKBL-1)
if "%blplan%"=="special__ailsa_ii" (if not "%chkdev__mode%"=="qcedl" ECHOC {%c_e%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto LOCKBL-1)
ECHOC {%c_w%}Chinese text %chkdev__mode% Chinese text . %chkdev__mode% Chinese text . Chinese text, Chinese text USB Chinese text, Chinese text Enter Chinese text .{%c_i%}{\n}
ECHO.1.[Chinese text]Chinese text   2. Chinese text %chkdev__mode% Chinese text
call input choice #[1][2]
if "%choice%"=="1" goto LOCKBL-1
if "%parlayout:~0,2%"=="ab" set slot__cur=unknown
goto LOCKBL-%blplan%-START
EXIT
:LOCKBL-2
ECHO. Chinese text ...
call info adb
call ztetoolbox chkproduct %info__adb__product%
if "%parlayout:~0,2%"=="ab" call slot system chk
ECHOC {%c_we%}Chinese text: %info__adb__product%{%c_i%}{\n}
ECHOC {%c_we%}Chinese text: %info__adb__androidver%{%c_i%}{\n}
if "%parlayout:~0,2%"=="ab" ECHOC {%c_we%}Chinese text: %slot__cur%{%c_i%}{\n}
goto LOCKBL-%blplan%
EXIT
:LOCKBL-special__ailsa_ii
ECHO. Chinese text 9008... & call reboot system qcedl rechk 1
goto LOCKBL-special__ailsa_ii-START
:LOCKBL-special__ailsa_ii-START
ECHO. Chinese text ... & call write qcedlsendfh %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
for /f %%a in ('gettime.exe ^| find "."') do set baktime=%%a
ECHO. Chinese text aboot... & call read qcedl aboot res\%product%\bak\aboot_%baktime%.mbn notice %chkdev__port__qcedl%
ECHO. Chinese text fbop...  & call read qcedl fbop  res\%product%\bak\fbop_%baktime%.img  notice %chkdev__port__qcedl%
::ECHO. Chinese text frp...   & call read qcedl frp   res\%product%\bak\frp_%baktime%.img   notice %chkdev__port__qcedl%
::ECHO. Chinese text frp Chinese text OEM Chinese text ... & call imgkit patchfrp res\%product%\bak\frp_%baktime%.img %tmpdir%\frp_oemunlockon.img oemunlockon noprompt
ECHO. Chinese text aboot... & call write qcedl aboot res\%product%\aboot_unlock.mbn %chkdev__port__qcedl%
ECHO. Chinese text fbop...  & call write qcedl fbop  res\%product%\fbop_unlock.img  %chkdev__port__qcedl%
::ECHO. Chinese text frp...   & call write qcedl frp   %tmpdir%\frp_oemunlockon.img        %chkdev__port__qcedl%
ECHO. Chinese text ... & call reboot qcedl system
ECHO. Chinese text . Chinese text USB Chinese text, Chinese text USB Chinese text . Chinese text, Chinese text .
call chkdev system rechk 1
ECHO. Chinese text Fastboot... & call reboot system fastboot rechk 1
ECHO. Chinese text ...
fastboot.exe oem lock 1>%tmpdir%\output.txt 2>&1 || ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
type %tmpdir%\output.txt>>%logfile%
find "Device already : locked!" "%tmpdir%\output.txt" 1>nul 2>nul && ECHOC {%c_s%}Chinese text .{%c_i%}{\n}&& set lockbl_chk=y&& goto LOCKBL-DONE
goto LOCKBL-DONE
:LOCKBL-FLASHABL
if "%presskeytoedl%"=="y" (goto LOCKBL-FLASHABL-PRESSKEYTOEDL) else (goto LOCKBL-FLASHABL-CMDTOEDL)
:LOCKBL-FLASHABL-PRESSKEYTOEDL
ECHOC {%c_h%}Chinese text, Chinese text, Chinese text . Chinese text ...{%c_i%}{\n}& pause>nul
ECHO. Chinese text ... & adb.exe reboot bootloader 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& pause>nul && goto LOCKBL
ECHO. Chinese text: Chinese text . Chinese text, Chinese text, Chinese text, Chinese text .
ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}
call chkdev qcedl rechk 1
ECHOC {%c_h%}Chinese text{%c_i%}{\n}
goto LOCKBL-FLASHABL-START
:LOCKBL-FLASHABL-CMDTOEDL
ECHO. Chinese text 9008... & call reboot system qcedl rechk 1
goto LOCKBL-FLASHABL-START
:LOCKBL-FLASHABL-START
ECHO. Chinese text ... & call write qcedlsendfh %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
for /f %%a in ('gettime.exe ^| find "."') do set baktime=%%a
if "%blplan_frp%"=="y" ECHO. Chinese text frp... & call read qcedl frp res\%product%\bak\frp_%baktime%.img notice %chkdev__port__qcedl%
if not "%parlayout:~0,2%"=="ab" (
    ECHO. Chinese text abl... & call read qcedl abl res\%product%\bak\abl_%baktime%.elf notice %chkdev__port__qcedl%
    ECHO. Chinese text bin\res\%product%\bak.
    ECHO. Chinese text abl... & call write qcedl abl res\%product%\abl_unlock.elf %chkdev__port__qcedl%)
if "%parlayout:~0,2%"=="ab" (
    ::ECHO. Chinese text lun4 Chinese text ... & call partable qcedl readgpt %chkdev__port__qcedl% auto 4 main res\%product%\bak\gpt_main4_%baktime%.bin notice
    if "%slot__cur%"=="unknown" ECHO. Chinese text ... & call slot qcedl chk
    ECHO. Chinese text abl_%slot__cur%... & call read qcedl abl_%slot__cur% res\%product%\bak\abl_%slot__cur%_%baktime%.elf notice %chkdev__port__qcedl%
    ECHO. Chinese text bin\res\%product%\bak.
    ECHO. Chinese text abl_%slot__cur%... & call write qcedl abl_%slot__cur% res\%product%\abl_unlock.elf %chkdev__port__qcedl%)
if "%blplan_frp%"=="y" ECHO. Chinese text frp... & call write qcedl frp tool\Android\frp_unlock.img %chkdev__port__qcedl%
ECHO. Chinese text ... & call reboot qcedl system
ECHO. Chinese text Fastboot. Chinese text, Chinese text . Chinese text Fastboot Chinese text . Chinese text, Chinese text, Chinese text .
:LOCKBL-FLASHABL-4
ECHO.1. Chinese text Fastboot Chinese text   2. Chinese text   3. Chinese text Fastboot
call input choice #[1][2][3]
if "%choice%"=="2" ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}& goto LOCKBL-FLASHABL-1
if "%choice%"=="3" call open pic pic\fastboot.jpg & goto LOCKBL-FLASHABL-4
fastboot.exe devices -l 2>&1 | find "fastboot" 1>nul 2>nul || ECHOC {%c_e%}Chinese text . {%c_i%}Chinese text, Chinese text .{%c_i%}{\n}&& goto LOCKBL-FLASHABL-4
call chkdev fastboot
ECHO. Chinese text ... & call info fastboot
if "%info__fastboot__unlocked%"=="no" ECHOC {%c_s%}Chinese text . {%c_i%}{\n}& set lockbl_chk=y& goto LOCKBL-FLASHABL-1
ECHO. Chinese text . Chinese text, Chinese text"LOCK THE BOOTLOADER", Chinese text . Chinese text, Chinese text, Chinese text, Chinese text .
fastboot.exe flashing lock 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
:LOCKBL-FLASHABL-2
ECHO.1. Chinese text   2. Chinese text
call input choice [1][2]
::if "%choice%"=="3" call open pic pic\lockbl.jpg & goto LOCKBL-FLASHABL-2
if "%choice%"=="1" set lockbl_autoerase=y
if "%choice%"=="2" ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
goto LOCKBL-FLASHABL-1
:LOCKBL-FLASHABL-1
ECHOC {%c_w%}Chinese text Chinese text@Chinese text Chinese text, Chinese text, Chinese text{%c_i%}{\n}
ECHOC {%c_i%}Chinese text, Chinese text . Chinese text, Chinese text, Chinese text . {%c_h%}Chinese text, Chinese text, Chinese text 9008 (Chinese text"Chinese text")...{%c_i%}{\n}& call chkdev qcedl rechk 1
ECHO. Chinese text ... & call write qcedlsendfh %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
if "%blplan_frp%"=="y" ECHO. Chinese text frp... & call write qcedl frp res\%product%\bak\frp_%baktime%.img %chkdev__port__qcedl%
if not "%parlayout:~0,2%"=="ab" (
    ECHO. Chinese text abl... & call write qcedl abl res\%product%\bak\abl_%baktime%.elf %chkdev__port__qcedl%)
if "%parlayout:~0,2%"=="ab" (
    ::ECHO. Chinese text lun4 Chinese text ... & call partable qcedl writegpt %chkdev__port__qcedl% auto 4 main res\%product%\bak\gpt_main4_%baktime%.bin
    ECHO. Chinese text abl_%slot__cur%... & call write qcedl abl_%slot__cur% res\%product%\bak\abl_%slot__cur%_%baktime%.elf %chkdev__port__qcedl%
    ECHO. Chinese text %slot__cur% Chinese text ... & call slot qcedl set %slot__cur%)
if "%lockbl_autoerase%"=="y" ECHO. Chinese text ... & call write qcedl misc tool\Android\misc_wipedata.img %chkdev__port__qcedl%
ECHO. Chinese text ... & call reboot qcedl system
goto LOCKBL-DONE
:LOCKBL-DIRECT
ECHO. Chinese text fastboot... & call reboot system fastboot rechk 1
:LOCKBL-DIRECT-START
ECHO. Chinese text ... & call info fastboot
if "%info__fastboot__unlocked%"=="no" ECHOC {%c_s%}Chinese text . {%c_i%}{\n}& set lockbl_chk=y& goto LOCKBL-DONE
ECHO. Chinese text . Chinese text, Chinese text"LOCK THE BOOTLOADER", Chinese text . Chinese text, Chinese text .
fastboot.exe flashing lock 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
ECHO.1. Chinese text   2. Chinese text
call input choice [1][2]
if "%choice%"=="2" ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
goto LOCKBL-DONE
:LOCKBL-DONE
if "%lockbl_chk%"=="y" goto LOCKBL-DONE-1
::ECHO.
::ECHO.1. Chinese text
::ECHO.2. Chinese text
::call input choice #[1][2]
::ECHO.
::if "%choice%"=="1" goto LOCKBL-1
:LOCKBL-DONE-1
ECHO. & ECHOC {%c_s%}Chinese text . {%c_i%}Chinese text, Chinese text Recovery Chinese text . Chinese text, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto MENU


:UNLOCKBL
set unlockbl_chk=n
set unlockbl_autoerase=n
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text BL
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
if "%blplan%"=="n" ECHO.%model% Chinese text BL. Chinese text ... & pause>nul & goto MENU
ECHO. [%model%]   Chinese text: %blplan%
ECHO.
ECHO.- Chinese text BL Chinese text:
ECHO. Chinese text(Chinese text)
ECHO. TEE Chinese text
ECHO. Chinese text
ECHO. Chinese text
ECHO. Chinese text
ECHO. Chinese text
ECHO. Chinese text
ECHO. ...
ECHO.
ECHO.- Chinese text BL Chinese text (Chinese text):
ECHO. Chinese text
ECHO. Chinese text
if "%product%"=="NX563J" ECHO. Chinese text yhcres.top Chinese text V6.28 Chinese text 9008 Chinese text& ECHO. (Chinese text: Chinese text - Chinese text - Chinese text Z17-NubiaUI-9008 Chinese text)
if "%blplan_frp%"=="n" ECHO. Chinese text OEM Chinese text
ECHO. Chinese text, Chinese text, Chinese text
ECHO. Chinese text
ECHO. Chinese text
ECHO. Chinese text 9008 Chinese text
ECHO.
ECHO.- Chinese text, Chinese text, Chinese text .
ECHO.
ECHO.
ECHOC {%c_h%}Chinese text, Chinese text ...{%c_i%}{\n}& pause>nul
ECHO.
:UNLOCKBL-1
ECHOC {%c_h%}Chinese text, Chinese text USB Chinese text ...{%c_i%}{\n}& call chkdev all rechk 1
if "%chkdev__mode%"=="system" goto UNLOCKBL-2
if "%blplan%"=="direct" (if not "%chkdev__mode%"=="fastboot" ECHOC {%c_e%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto UNLOCKBL-1)
if "%blplan%"=="flashabl" (if not "%chkdev__mode%"=="qcedl" ECHOC {%c_e%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto UNLOCKBL-1)
if "%blplan%"=="special__ailsa_ii" (if not "%chkdev__mode%"=="qcedl" ECHOC {%c_e%}Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto UNLOCKBL-1)
ECHOC {%c_w%}Chinese text %chkdev__mode% Chinese text . %chkdev__mode% Chinese text . Chinese text, Chinese text USB Chinese text, Chinese text Enter Chinese text .{%c_i%}{\n}
ECHO.1.[Chinese text]Chinese text   2. Chinese text %chkdev__mode% Chinese text
call input choice #[1][2]
if "%choice%"=="1" goto UNLOCKBL-1
if "%parlayout:~0,2%"=="ab" set slot__cur=unknown
goto UNLOCKBL-%blplan%-START || EXIT
:UNLOCKBL-2
ECHO. Chinese text ...
call info adb
call ztetoolbox chkproduct %info__adb__product%
if "%parlayout:~0,2%"=="ab" call slot system chk
ECHOC {%c_we%}Chinese text: %info__adb__product%{%c_i%}{\n}
ECHOC {%c_we%}Chinese text: %info__adb__androidver%{%c_i%}{\n}
if "%parlayout:~0,2%"=="ab" ECHOC {%c_we%}Chinese text: %slot__cur%{%c_i%}{\n}
goto UNLOCKBL-%blplan% || EXIT
:UNLOCKBL-special__ailsa_ii
ECHO. Chinese text 9008... & call reboot system qcedl rechk 1
goto UNLOCKBL-special__ailsa_ii-START
:UNLOCKBL-special__ailsa_ii-START
ECHO. Chinese text ... & call write qcedlsendfh %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
for /f %%a in ('gettime.exe ^| find "."') do set baktime=%%a
ECHO. Chinese text aboot... & call read qcedl aboot res\%product%\bak\aboot_%baktime%.mbn notice %chkdev__port__qcedl%
ECHO. Chinese text fbop...  & call read qcedl fbop  res\%product%\bak\fbop_%baktime%.img  notice %chkdev__port__qcedl%
::ECHO. Chinese text frp...   & call read qcedl frp   res\%product%\bak\frp_%baktime%.img   notice %chkdev__port__qcedl%
::ECHO. Chinese text frp Chinese text OEM Chinese text ... & call imgkit patchfrp res\%product%\bak\frp_%baktime%.img %tmpdir%\frp_oemunlockon.img oemunlockon noprompt
ECHO. Chinese text aboot... & call write qcedl aboot res\%product%\aboot_unlock.mbn %chkdev__port__qcedl%
ECHO. Chinese text fbop...  & call write qcedl fbop  res\%product%\fbop_unlock.img  %chkdev__port__qcedl%
::ECHO. Chinese text frp...   & call write qcedl frp   %tmpdir%\frp_oemunlockon.img        %chkdev__port__qcedl%
ECHO. Chinese text ... & call reboot qcedl system
ECHO. Chinese text . Chinese text USB Chinese text, Chinese text USB Chinese text . Chinese text, Chinese text .
call chkdev system rechk 1
ECHO. Chinese text Fastboot... & call reboot system fastboot rechk 1
ECHO. Chinese text ...
fastboot.exe oem unlock 1>%tmpdir%\output.txt 2>&1 || ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
type %tmpdir%\output.txt>>%logfile%
find "Device already : unlocked!" "%tmpdir%\output.txt" 1>nul 2>nul && ECHOC {%c_s%}Chinese text .{%c_i%}{\n}&& set unlockbl_chk=y&& goto UNLOCKBL-DONE
ECHO. Chinese text, Chinese text"Yes", Chinese text . Chinese text .
ECHO.1. Chinese text   2. Chinese text
call input choice [1][2]
if "%choice%"=="2" ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
goto UNLOCKBL-DONE
:UNLOCKBL-FLASHABL
if "%presskeytoedl%"=="y" (goto UNLOCKBL-FLASHABL-PRESSKEYTOEDL) else (goto UNLOCKBL-FLASHABL-CMDTOEDL)
:UNLOCKBL-FLASHABL-PRESSKEYTOEDL
ECHOC {%c_h%}Chinese text, Chinese text, Chinese text . Chinese text ...{%c_i%}{\n}& pause>nul
ECHO. Chinese text ... & adb.exe reboot bootloader 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& pause>nul && goto UNLOCKBL
ECHO. Chinese text: Chinese text . Chinese text, Chinese text, Chinese text, Chinese text .
ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}
call chkdev qcedl rechk 1
ECHOC {%c_h%}Chinese text{%c_i%}{\n}
goto UNLOCKBL-FLASHABL-START
:UNLOCKBL-FLASHABL-CMDTOEDL
ECHO. Chinese text 9008... & call reboot system qcedl rechk 1
goto UNLOCKBL-FLASHABL-START
:UNLOCKBL-FLASHABL-START
ECHO. Chinese text ... & call write qcedlsendfh %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
for /f %%a in ('gettime.exe ^| find "."') do set baktime=%%a
if "%blplan_frp%"=="y" ECHO. Chinese text frp... & call read qcedl frp res\%product%\bak\frp_%baktime%.img notice %chkdev__port__qcedl%
if not "%parlayout:~0,2%"=="ab" (
    ECHO. Chinese text abl... & call read qcedl abl res\%product%\bak\abl_%baktime%.elf notice %chkdev__port__qcedl%
    ECHO. Chinese text bin\res\%product%\bak.
    ECHO. Chinese text abl... & call write qcedl abl res\%product%\abl_unlock.elf %chkdev__port__qcedl%)
if "%parlayout:~0,2%"=="ab" (
    ::ECHO. Chinese text lun4 Chinese text ... & call partable qcedl readgpt %chkdev__port__qcedl% auto 4 main res\%product%\bak\gpt_main4_%baktime%.bin notice
    if "%slot__cur%"=="unknown" ECHO. Chinese text ... & call slot qcedl chk
    ECHO. Chinese text abl_%slot__cur%... & call read qcedl abl_%slot__cur% res\%product%\bak\abl_%slot__cur%_%baktime%.elf notice %chkdev__port__qcedl%
    ECHO. Chinese text bin\res\%product%\bak.
    ECHO. Chinese text abl_%slot__cur%... & call write qcedl abl_%slot__cur% res\%product%\abl_unlock.elf %chkdev__port__qcedl%)
if "%blplan_frp%"=="y" ECHO. Chinese text frp... & call write qcedl frp tool\Android\frp_unlock.img %chkdev__port__qcedl%
ECHO. Chinese text ... & call reboot qcedl system
ECHO. Chinese text Fastboot. Chinese text, Chinese text . Chinese text Fastboot Chinese text . Chinese text, Chinese text, Chinese text .
:UNLOCKBL-FLASHABL-4
ECHO.1. Chinese text Fastboot Chinese text   2. Chinese text   3. Chinese text Fastboot
call input choice #[1][2][3]
if "%choice%"=="2" ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}& goto UNLOCKBL-FLASHABL-1
if "%choice%"=="3" call open pic pic\fastboot.jpg & goto UNLOCKBL-FLASHABL-4
fastboot.exe devices -l 2>&1 | find "fastboot" 1>nul 2>nul || ECHOC {%c_e%}Chinese text . {%c_i%}Chinese text, Chinese text .{%c_i%}{\n}&& goto UNLOCKBL-FLASHABL-4
call chkdev fastboot
ECHO. Chinese text ... & call info fastboot
if "%info__fastboot__unlocked%"=="yes" ECHOC {%c_s%}Chinese text . {%c_i%}{\n}& set unlockbl_chk=y& goto UNLOCKBL-FLASHABL-1
ECHO. Chinese text . Chinese text, Chinese text"UNLOCK THE BOOTLOADER", Chinese text . Chinese text, Chinese text, Chinese text, Chinese text .
fastboot.exe flashing unlock 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
:UNLOCKBL-FLASHABL-2
ECHO.1. Chinese text   2. Chinese text   3. Chinese text
call input choice [1][2][3]
if "%choice%"=="3" call open pic pic\unlockbl.jpg & goto UNLOCKBL-FLASHABL-2
if "%choice%"=="1" set unlockbl_autoerase=y
if "%choice%"=="2" ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
goto UNLOCKBL-FLASHABL-1
:UNLOCKBL-FLASHABL-1
ECHOC {%c_w%}Chinese text Chinese text@Chinese text Chinese text, Chinese text, Chinese text{%c_i%}{\n}
ECHOC {%c_i%}Chinese text, Chinese text . Chinese text, Chinese text, Chinese text . {%c_h%}Chinese text, Chinese text, Chinese text 9008 (Chinese text"Chinese text")...{%c_i%}{\n}& call chkdev qcedl rechk 1
ECHO. Chinese text ... & call write qcedlsendfh %chkdev__port__qcedl% %framework_workspace%\res\%product%\devprg
if "%blplan_frp%"=="y" ECHO. Chinese text frp... & call write qcedl frp res\%product%\bak\frp_%baktime%.img %chkdev__port__qcedl%
if not "%parlayout:~0,2%"=="ab" (
    ECHO. Chinese text abl... & call write qcedl abl res\%product%\bak\abl_%baktime%.elf %chkdev__port__qcedl%)
if "%parlayout:~0,2%"=="ab" (
    ::ECHO. Chinese text lun4 Chinese text ... & call partable qcedl writegpt %chkdev__port__qcedl% auto 4 main res\%product%\bak\gpt_main4_%baktime%.bin
    ECHO. Chinese text abl_%slot__cur%... & call write qcedl abl_%slot__cur% res\%product%\bak\abl_%slot__cur%_%baktime%.elf %chkdev__port__qcedl%
    ECHO. Chinese text %slot__cur% Chinese text ... & call slot qcedl set %slot__cur%)
if "%unlockbl_autoerase%"=="y" ECHO. Chinese text ... & call write qcedl misc tool\Android\misc_wipedata.img %chkdev__port__qcedl%
ECHO. Chinese text ... & call reboot qcedl system
goto UNLOCKBL-DONE
:UNLOCKBL-DIRECT
ECHO. Chinese text fastboot... & call reboot system fastboot rechk 1
:UNLOCKBL-DIRECT-START
ECHO. Chinese text ... & call info fastboot
if "%info__fastboot__unlocked%"=="yes" ECHOC {%c_s%}Chinese text . {%c_i%}{\n}& set unlockbl_chk=y& goto UNLOCKBL-DONE
ECHO. Chinese text . Chinese text, Chinese text"UNLOCK THE BOOTLOADER", Chinese text . Chinese text, Chinese text .
fastboot.exe flashing unlock 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
ECHO.1. Chinese text   2. Chinese text
call input choice [1][2]
if "%choice%"=="2" ECHOC {%c_e%}Chinese text . Chinese text .{%c_i%}{\n}
goto UNLOCKBL-DONE
:UNLOCKBL-DONE
if "%unlockbl_chk%"=="y" goto UNLOCKBL-DONE-1
ECHO.
::ECHO.1.[Chinese text]Chinese text
ECHO.1. Chinese text BL Chinese text
ECHO.2. Chinese text (Chinese text BL Chinese text, Chinese text)
call input choice #[1][2]
ECHO.
::if "%choice%"=="1" goto UNLOCKBL-1
if "%choice%"=="1" call open pic pic\blunlockedfeatures.jpg & goto UNLOCKBL-DONE
:UNLOCKBL-DONE-1
ECHO. & ECHOC {%c_s%}Chinese text . {%c_i%}Chinese text . Chinese text, Chinese text Recovery Chinese text . Chinese text, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & goto MENU


:SELDEV
type conf\dev.csv | find /v "[product]" | find "[" | find /N "]" 1>%tmpdir%\dev.txt
CLS
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO. Chinese text \ Chinese text
ECHO.
ECHO.=--------------------------------------------------------------------=
ECHO.
ECHO.
ECHO. Chinese text Chinese text / Chinese text / Chinese text Chinese text, Chinese text .
ECHO.
ECHO.
for /f "tokens=1,3,4 delims=[]," %%a in (%tmpdir%\dev.txt) do (ECHO.[%%a] %%c  %%b& ECHO.)
ECHO.
call input choice
if "%choice%"=="" goto SELDEV
find "[%choice%][" "%tmpdir%\dev.txt" 1>nul 2>nul || goto SELDEV
ECHO. Chinese text . Chinese text ...
for /f "tokens=2 delims=[]," %%a in ('type %tmpdir%\dev.txt ^| find "[%choice%]["') do set product=%%a
call ztetoolbox confdevpre
call framework conf user.bat product %product%
call conf\dev-%product%.bat
goto MENU


:THEME
CLS
ECHOC {%c_a%}=--------------------------------------------------------------------={%c_i%}{\n}
ECHO.
ECHO. Chinese text
ECHO.
ECHOC {%c_a%}=--------------------------------------------------------------------={%c_i%}{\n}
ECHO.
ECHO.
ECHO. Chinese text: Chinese text . Chinese text .
ECHO.
ECHO.
ECHO.1. Chinese text
ECHO.2. Chinese text
ECHO.3. Chinese text
ECHO.4. Chinese text
ECHO.5. Chinese text
ECHO.6.DOS
ECHO.7. Chinese text
ECHO.
call input choice [1][2][3][4][5][6][7]
if "%choice%"=="1" set target=default
if "%choice%"=="2" set target=classic
if "%choice%"=="3" set target=ubuntu
if "%choice%"=="4" set target=douyinhacker
if "%choice%"=="5" set target=gold
if "%choice%"=="6" set target=dos
if "%choice%"=="7" set target=ChineseNewYear
::Chinese text
call framework theme %target%
echo.@ECHO OFF>%tmpdir%\theme.bat
echo.mode con cols=50 lines=17 >>%tmpdir%\theme.bat
echo.cd ..>>%tmpdir%\theme.bat
echo.set path=%framework_workspace%;%framework_workspace%\tool\Win;%framework_workspace%\tool\Android;%path% >>%tmpdir%\theme.bat
echo.COLOR %c_i% >>%tmpdir%\theme.bat
echo.TITLE Chinese text: %target% >>%tmpdir%\theme.bat
echo.ECHO. >>%tmpdir%\theme.bat
echo.ECHOC {%c_i%}Chinese text{%c_i%}{\n}>>%tmpdir%\theme.bat
echo.ECHO. >>%tmpdir%\theme.bat
echo.ECHOC {%c_w%}Chinese text{%c_i%}{\n}>>%tmpdir%\theme.bat
echo.ECHO. >>%tmpdir%\theme.bat
echo.ECHOC {%c_e%}Chinese text{%c_i%}{\n}>>%tmpdir%\theme.bat
echo.ECHO. >>%tmpdir%\theme.bat
echo.ECHOC {%c_s%}Chinese text{%c_i%}{\n}>>%tmpdir%\theme.bat
echo.ECHO. >>%tmpdir%\theme.bat
echo.ECHOC {%c_h%}Chinese text{%c_i%}{\n}>>%tmpdir%\theme.bat
echo.ECHO. >>%tmpdir%\theme.bat
echo.ECHOC {%c_a%}Chinese text{%c_i%}{\n}>>%tmpdir%\theme.bat
echo.ECHO. >>%tmpdir%\theme.bat
echo.ECHOC {%c_we%}Chinese text{%c_i%}{\n}>>%tmpdir%\theme.bat
echo.ECHO. >>%tmpdir%\theme.bat
echo.pause^>nul>>%tmpdir%\theme.bat
echo.EXIT>>%tmpdir%\theme.bat
call framework theme
start %tmpdir%\theme.bat
::Chinese text
ECHO.
ECHO. Chinese text . Chinese text
ECHO.1. Chinese text   2. Chinese text
call input choice #[1][2]
if "%choice%"=="1" call framework conf user.bat framework_theme %target%& ECHOC {%c_i%}Chinese text, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% I Chinese text %target%& pause>nul & EXIT
if "%choice%"=="2" goto THEME






:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)
