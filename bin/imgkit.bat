::Chinese text: n

::call imgkit magiskpatch     boot Chinese text Chinese text boot Chinese text    Chinese text apk Chinese text                                   noprompt(Chinese text)
::            recinst         boot Chinese text Chinese text boot Chinese text    recovery Chinese text(Chinese text img Chinese text ramdisk.cpio)  noprompt(Chinese text)
::            patchfrp        frp Chinese text      Chinese text frp Chinese text    [oemunlockon oemunlockoff]                   noprompt(Chinese text)
::            patchvbmeta     vbmeta Chinese text   Chinese text vbmeta Chinese text [noverify verify]                            noprompt(Chinese text)
::            sparse2raw      sparse Chinese text   raw Chinese text      noprompt(Chinese text)

@ECHO OFF
chcp 65001 >nul
set args1=%1& set args2=%2& set args3=%3& set args4=%4& set args5=%5& set args6=%6& set args7=%7& set args8=%8& set args9=%9
goto %args1%



:SPARSE2RAW
SETLOCAL
set logger=imgkit.bat-sparse2raw
set filepath=%args2%& set outputpath=%args3%& set mode=%args4%
call log %logger% I Chinese text:filepath:%filepath%.outputpath:%outputpath%.mode:%mode%
::Chinese text
for %%a in ("%filepath%") do set filepath=%%~fa
::Chinese text
if not exist %filepath% ECHOC {%c_e%}Chinese text %filepath%{%c_i%}{\n}& call log %logger% F Chinese text %filepath%& goto FATAL
if not "%mode%"=="noprompt" (if exist %outputpath% ECHOC {%c_w%}Chinese text %outputpath%, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text %outputpath%. Chinese text& pause>nul & ECHO. Chinese text ...)
::Chinese text
call log %logger% I Chinese text:sparse Chinese text:%filepath%.raw Chinese text:%outputpath%
simg_dump.exe -f %filepath% -m rawimg -o %outputpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text sparse Chinese text %filepath% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text sparse Chinese text %filepath% Chinese text&& goto FATAL
::simg2img.exe %filepath% %outputpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text sparse Chinese text %filepath% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text sparse Chinese text %filepath% Chinese text&& goto FATAL
call log %logger% I Chinese text
ENDLOCAL
goto :eof


:PATCHVBMETA
SETLOCAL
set logger=imgkit.bat-patchvbmeta
set filepath=%args2%& set outputpath=%args3%& set func=%args4%& set mode=%args5%
call log %logger% I Chinese text:filepath:%filepath%.outputpath:%outputpath%.func:%func%.mode:%mode%
:PATCHVBMETA-1
::Chinese text
if not "%func%"=="noverify" (if not "%func%"=="verify" ECHOC {%c_e%}Chinese text{%c_i%}{\n}& call log %logger% F Chinese text& goto FATAL)
if not exist %filepath% ECHOC {%c_e%}Chinese text %filepath%{%c_i%}{\n}& call log %logger% F Chinese text %filepath%& goto FATAL
if not "%mode%"=="noprompt" (if exist %outputpath% ECHOC {%c_w%}Chinese text %outputpath%, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text %outputpath%. Chinese text& pause>nul & ECHO. Chinese text ...)
::Chinese text
:PATCHVBMETA-2
call log %logger% I Chinese text vbmeta Chinese text
echo.F|xcopy /Y %filepath% %outputpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %filepath% Chinese text %outputpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text %outputpath% Chinese text&& pause>nul && ECHO. Chinese text ... && goto PATCHVBMETA-2
if "%func%"=="noverify" magiskboot.exe hexpatch %outputpath% 0000000000000000617662746F6F6C20 0000000300000000617662746F6F6C20 1>>%logfile% 2>&1 || call log %logger% E Chinese text vbmeta Chinese text
if "%func%"=="verify"   magiskboot.exe hexpatch %outputpath% 0000000300000000617662746F6F6C20 0000000000000000617662746F6F6C20 1>>%logfile% 2>&1 || call log %logger% E Chinese text vbmeta Chinese text
call log %logger% I Chinese text
ENDLOCAL & goto :eof


:PATCHFRP
SETLOCAL
set logger=imgkit.bat-patchfrp
set filepath=%args2%& set outputpath=%args3%& set func=%args4%& set mode=%args5%
call log %logger% I Chinese text:filepath:%filepath%.outputpath:%outputpath%.func:%func%.mode:%mode%
:PATCHFRP-1
::Chinese text
if not "%func%"=="oemunlockon" (if not "%func%"=="oemunlockoff" ECHOC {%c_e%}Chinese text{%c_i%}{\n}& call log %logger% F Chinese text& goto FATAL)
if not exist %filepath% ECHOC {%c_e%}Chinese text %filepath%{%c_i%}{\n}& call log %logger% F Chinese text %filepath%& goto FATAL
if not "%mode%"=="noprompt" (if exist %outputpath% ECHOC {%c_w%}Chinese text %outputpath%, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text %outputpath%. Chinese text& pause>nul & ECHO. Chinese text ...)
echo.F|xcopy /Y %filepath% %outputpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %filepath% Chinese text %outputpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %filepath% Chinese text %outputpath% Chinese text&& pause>nul && ECHO. Chinese text ... && goto PATCHFRP-1
call log %logger% I Chinese text frp Chinese text
::Chinese text 1 Chinese text 00 Chinese text 01
set origvalue=
for /f "tokens=1 delims= " %%a in ('busybox.exe tail -c 1 %outputpath% ^| busybox.exe xxd -p') do set origvalue=%%a
if not "%origvalue%"=="00" (if not "%origvalue%"=="01" ECHOC {%c_e%}frp Chinese text 1 Chinese text 16 Chinese text 00 Chinese text 01.{%c_i%}{\n}& call log %logger% F frp Chinese text 1 Chinese text 16 Chinese text 00 Chinese text 01& goto FATAL)
if "%func%"=="oemunlockon" set target=01
if "%func%"=="oemunlockoff" set target=00
if "%origvalue%"=="%target%" (
    call log %logger% I frp Chinese text
    goto PATCHFRP-DONE)
::Chinese text
set filesize=
for /f "tokens=2 delims= " %%a in ('busybox.exe stat -t %outputpath%') do set filesize=%%a
if "%filesize%"=="" ECHOC {%c_e%}Chinese text %outputpath% Chinese text{%c_i%}{\n}& call log %logger% F Chinese text %outputpath% Chinese text & goto FATAL
call calc s address nodec %filesize% 1
:PATCHFRP-2
call log %logger% I Chinese text frp Chinese text:Address:%address%.Length:1.HexNumber:%target%
HexTool.exe %outputpath% %address% 1 %target% 1>%tmpdir%\output.txt 2>&1
type %tmpdir%\output.txt>>%logfile%
find "Done!" "%tmpdir%\output.txt" 1>nul 2>nul || ECHOC {%c_e%}Chinese text frp Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text frp Chinese text&& pause>nul && ECHO. Chinese text ... && goto PATCHFRP-2
goto PATCHFRP-DONE
:PATCHFRP-DONE
call log %logger% I Chinese text
ENDLOCAL & goto :eof


:MAGISKPATCH
SETLOCAL
set logger=imgkit.bat-magiskpatch
set bootpath=%args2%& set outputpath=%args3%& set zippath=%args4%& set mode=%args5%
call log %logger% I Chinese text:bootpath:%bootpath%.outputpath:%outputpath%.zippath:%zippath%.mode:%mode%
::Chinese text
if "%zippath%"=="" ECHOC {%c_e%}Chinese text{%c_i%}{\n}& call log %logger% F Chinese text& goto FATAL
if not exist %bootpath% ECHOC {%c_e%}Chinese text %bootpath%{%c_i%}{\n}& call log %logger% F Chinese text %bootpath%& goto FATAL
if not exist %zippath% ECHOC {%c_e%}Chinese text %zippath%{%c_i%}{\n}& call log %logger% F Chinese text %zippath%& goto FATAL
if not "%mode%"=="noprompt" (if exist %outputpath% ECHOC {%c_w%}Chinese text %outputpath%, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text %outputpath%. Chinese text& pause>nul & ECHO. Chinese text ...)
::Chinese text
if exist %tmpdir%\imgkit-magiskpatch rd /s /q %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch Chinese text
md %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch Chinese text
::Chinese text
::- Chinese text AVB2.0, dm-verity (27006-17000) Chinese text true
if "%imgkit__magiskpatch__option_KEEPVERITY%"=="false" (set KEEPVERITY=false) else (set KEEPVERITY=true)
::- Chinese text (27006-17000) Chinese text true
if "%imgkit__magiskpatch__option_KEEPFORCEENCRYPT%"=="false" (set KEEPFORCEENCRYPT=false) else (set KEEPFORCEENCRYPT=true)
::- Chinese text vbmeta Chinese text (27006-24000) Chinese text false
if "%imgkit__magiskpatch__option_PATCHVBMETAFLAG%"=="true" (set PATCHVBMETAFLAG=true) else (set PATCHVBMETAFLAG=false)
::- Chinese text Recovery (27006-19100) Chinese text false (Chinese text: Chinese text 23000 Chinese text, Chinese text boot Chinese text recovery_dtbo Chinese text, Chinese text true)
if "%imgkit__magiskpatch__option_RECOVERYMODE%"=="true" (set RECOVERYMODE=true) else (set RECOVERYMODE=false)
::- Chinese text rootfs (27006-26000) Chinese text true
if "%imgkit__magiskpatch__option_LEGACYSAR%"=="false" (set LEGACYSAR=false) else (set LEGACYSAR=true)
set SYSTEM_ROOT=%LEGACYSAR%
::- Chinese text (arm Chinese text x86 Chinese text, 27006-19000 Chinese text 64 Chinese text, 18100-17000 Chinese text 64 Chinese text . 27006-27005 Chinese text riscv_64) Chinese text arm64
::  arm_64   arm_32   x86_64   x86_32   riscv_64
set arch=
if "%imgkit__magiskpatch__option_arch%"=="arm_64" set arch=arm_64
if "%imgkit__magiskpatch__option_arch%"=="arm_32" set arch=arm_32
if "%imgkit__magiskpatch__option_arch%"=="x86_64" set arch=x86_64
if "%imgkit__magiskpatch__option_arch%"=="x86_32" set arch=x86_32
if "%imgkit__magiskpatch__option_arch%"=="riscv_64" set arch=riscv_64
if "%arch%"=="" set arch=arm_64
::Chinese text
call log %logger% I Chinese text:KEEPVERITY:%KEEPVERITY%.KEEPFORCEENCRYPT:%KEEPFORCEENCRYPT%.PATCHVBMETAFLAG:%PATCHVBMETAFLAG%.RECOVERYMODE:%RECOVERYMODE%.LEGACYSAR:%LEGACYSAR%.SYSTEM_ROOT:%SYSTEM_ROOT%.arch:%arch%
:MAGISKPATCH-1
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if "%arch%"=="arm_64" (
    7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!lib\armeabi-v7a\libmagiskinit.so                                  -ir!lib\armeabi-v7a\libmagisk32.so -ir!lib\armeabi-v7a\libmagisk64.so -ir!arm\magiskinit                                     %zippath% 1>>%logfile% 2>&1
    7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!lib\arm64-v8a\libmagiskinit.so   -ir!lib\arm64-v8a\libmagisk.so                                      -ir!lib\arm64-v8a\libmagisk64.so   -ir!arm\magiskinit64 -ir!lib\arm64-v8a\libinit-ld.so   %zippath% 1>>%logfile% 2>&1)
if "%arch%"=="arm_32" (
    7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!lib\armeabi-v7a\libmagiskinit.so -ir!lib\armeabi-v7a\libmagisk.so -ir!lib\armeabi-v7a\libmagisk32.so                                    -ir!arm\magiskinit   -ir!lib\armeabi-v7a\libinit-ld.so %zippath% 1>>%logfile% 2>&1)
if "%arch%"=="x86_64" (
    7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!lib\x86\libmagiskinit.so                                          -ir!lib\x86\libmagisk32.so         -ir!lib\x86\libmagisk64.so         -ir!x86\magiskinit                                     %zippath% 1>>%logfile% 2>&1
    7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!lib\x86_64\libmagiskinit.so      -ir!lib\x86_64\libmagisk.so                                         -ir!lib\x86_64\libmagisk64.so      -ir!x86\magiskinit64 -ir!lib\x86_64\libinit-ld.so      %zippath% 1>>%logfile% 2>&1)
if "%arch%"=="x86_32" (
    7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!lib\x86\libmagiskinit.so         -ir!lib\x86\libmagisk.so         -ir!lib\x86\libmagisk32.so                                            -ir!x86\magiskinit   -ir!lib\x86\libinit-ld.so         %zippath% 1>>%logfile% 2>&1)
if "%arch%"=="riscv_64" (
    7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!lib\riscv64\libmagiskinit.so     -ir!lib\riscv64\libmagisk.so                                                                                                -ir!lib\riscv64\libinit-ld.so     %zippath% 1>>%logfile% 2>&1)
7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!assets\stub.apk %zippath% 1>>%logfile% 2>&1
if exist %tmpdir%\imgkit-magiskpatch\magiskinit64 move /Y %tmpdir%\imgkit-magiskpatch\magiskinit64 %tmpdir%\imgkit-magiskpatch\magiskinit 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit64 Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit64 Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1
::if exist %tmpdir%\imgkit-magiskpatch\magiskinit (
::    7z.exe e -t#:e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!2.xz %tmpdir%\imgkit-magiskpatch\magiskinit 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1
::    7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!2 %tmpdir%\imgkit-magiskpatch\2.xz 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\2.xz Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\2.xz Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1
::    move /Y %tmpdir%\imgkit-magiskpatch\2 %tmpdir%\imgkit-magiskpatch\magisk 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\2 Chinese text %tmpdir%\imgkit-magiskpatch\magisk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\2 Chinese text %tmpdir%\imgkit-magiskpatch\magisk Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1)
if exist %tmpdir%\imgkit-magiskpatch\libmagiskinit.so move /Y %tmpdir%\imgkit-magiskpatch\libmagiskinit.so %tmpdir%\imgkit-magiskpatch\magiskinit 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\libmagiskinit.so Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\libmagiskinit.so Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1
if exist %tmpdir%\imgkit-magiskpatch\libmagisk.so     magiskboot.exe compress=xz %tmpdir%\imgkit-magiskpatch\libmagisk.so %tmpdir%\imgkit-magiskpatch\magisk.xz 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\libmagisk.so Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\libmagisk.so Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1
if exist %tmpdir%\imgkit-magiskpatch\libmagisk32.so   magiskboot.exe compress=xz %tmpdir%\imgkit-magiskpatch\libmagisk32.so %tmpdir%\imgkit-magiskpatch\magisk32.xz 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\libmagisk32.so Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\libmagisk32.so Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1
if exist %tmpdir%\imgkit-magiskpatch\libmagisk64.so   magiskboot.exe compress=xz %tmpdir%\imgkit-magiskpatch\libmagisk64.so %tmpdir%\imgkit-magiskpatch\magisk64.xz 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\libmagisk64.so Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\libmagisk64.so Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1
if exist %tmpdir%\imgkit-magiskpatch\stub.apk         magiskboot.exe compress=xz %tmpdir%\imgkit-magiskpatch\stub.apk %tmpdir%\imgkit-magiskpatch\stub.xz 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\stub.apk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\stub.apk Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1
if exist %tmpdir%\imgkit-magiskpatch\libinit-ld.so    magiskboot.exe compress=xz %tmpdir%\imgkit-magiskpatch\libinit-ld.so %tmpdir%\imgkit-magiskpatch\init-ld.xz 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\libinit-ld.so Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\libinit-ld.so Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-1
::Chinese text Magisk Chinese text md5
call log %logger% I Chinese text Magisk Chinese text md5
7z.exe e -aoa -o%tmpdir%\imgkit-magiskpatch -slp -y -ir!assets\util_functions.sh -ir!common\util_functions.sh -ir!assets\boot_patch.sh -ir!common\boot_patch.sh %zippath% 1>>%logfile% 2>&1
set magiskver=
for /f "tokens=2 delims== " %%a in ('type %tmpdir%\imgkit-magiskpatch\util_functions.sh ^| find "MAGISK_VER_CODE="') do set magiskver=%%a
for /f "tokens=2 delims== " %%a in ('type %tmpdir%\imgkit-magiskpatch\util_functions.sh ^| find "MAGISK_VER="') do set var=%%a
set magiskver_show=%var:~1,-1%
set bootpatchmd5=
for /f "tokens=1 delims= " %%a in ('busybox.exe md5sum %tmpdir%\imgkit-magiskpatch\boot_patch.sh 2^>^>%logfile%') do set bootpatchmd5=%%a
if "%bootpatchmd5%"=="" ECHOC {%c_e%}Chinese text md5 Chinese text{%c_i%}{\n}& call log %logger% F Chinese text md5 Chinese text& goto FATAL
call log %logger% I Magisk Chinese text:%magiskver%.Magisk Chinese text:%magiskver_show%. Chinese text md5:%bootpatchmd5%
::Chinese text
set vivo_suu_patch=n
set bootpatchplan=
if "%bootpatchmd5%"=="0d1bdb70f8ae72ff2fa646a8aff448b7" set bootpatchplan=ALPHA_070719db_28001
if "%bootpatchmd5%"=="b16be7340e360cfb012953dbdbda6bf4" set bootpatchplan=28000
if "%bootpatchmd5%"=="9f4409484fe73305f3e8272e34d796de" set bootpatchplan=27006
if "%bootpatchmd5%"=="266e059172686269eb7a9bba349612b2" set bootpatchplan=27005
if "%bootpatchmd5%"=="3b324a47607ae17ac0376c19043bb7b1" set bootpatchplan=26300
if "%bootpatchmd5%"=="aef5b749e978c6ea5ebd0f3df910ae6c" set bootpatchplan=26300
if "%bootpatchmd5%"=="aef5b749e978c6ea5ebd0f3df910ae6c" set bootpatchplan=26300
if "%bootpatchmd5%"=="daf3cffe200d4e492edd0ca3c676f07f" set bootpatchplan=26200
if "%bootpatchmd5%"=="ccf5647834aeefbd61ce6c2594dd43e4" set bootpatchplan=26000
if "%bootpatchmd5%"=="0e8255080363ee0f895105cdc3dfa419" set bootpatchplan=26000
if "%bootpatchmd5%"=="3d2c5bcc43373eb17939f0592b2b40f9" set bootpatchplan=26000
if "%bootpatchmd5%"=="3d2c5bcc43373eb17939f0592b2b40f9" set bootpatchplan=26000
if "%bootpatchmd5%"=="bf6ef4d02c48875ae3929d26899a868d" set bootpatchplan=25200
if "%bootpatchmd5%"=="c48a22c8ed43cd20fe406acccc600308" set bootpatchplan=25200
if "%bootpatchmd5%"=="7b40f9efd587b59bade9b9ec892e875e" set bootpatchplan=25000
if "%bootpatchmd5%"=="0fb168d5339faf37c1c86ace16fe0953" set bootpatchplan=25000
if "%bootpatchmd5%"=="55285c3ad04cdf72e6e2be9d7ba4a333" set bootpatchplan=23000
if "%bootpatchmd5%"=="49452bcb3ea3362392ab05b7fe7ec128" set bootpatchplan=23000
if "%bootpatchmd5%"=="c2e189a0a37d789dd233d19ad9236bdc" set bootpatchplan=21400
if "%bootpatchmd5%"=="b8256416216461c247c2b82d60e8dca0" set bootpatchplan=21200
if "%bootpatchmd5%"=="ac3d1448b7481d7e70d2558d4c733fee" set bootpatchplan=21200
if "%bootpatchmd5%"=="69ebab4d9513484988a48a38560c6032" set bootpatchplan=21200
if "%bootpatchmd5%"=="232aaecb0fae34baa5a13211fccde93c" set bootpatchplan=21200
if "%bootpatchmd5%"=="cafa4ed2bfe5e45c85864a9ccf52502f" set bootpatchplan=21200
if "%bootpatchmd5%"=="8595503b132d7154385a043b66e65d5d" set bootpatchplan=19400
if "%bootpatchmd5%"=="05455b21ce3ea71c7d7b5c041023d392" set bootpatchplan=19400
if "%bootpatchmd5%"=="2816b613afbca2288b753cad592299cf" set bootpatchplan=19000
if "%bootpatchmd5%"=="11dc7caa2e7e734e11cc92e226b18bb2" set bootpatchplan=18100
if "%bootpatchmd5%"=="7aacf5e27d35d6675a35969a74970172" set bootpatchplan=18100
if "%bootpatchmd5%"=="e6040a2cac1af04dc0b41560dd0a8bc8" set bootpatchplan=17200
if "%bootpatchmd5%"=="c840c6803c68ec0f91ca6e2cec21ed27" set bootpatchplan=26300& set vivo_suu_patch=y
if "%bootpatchmd5%"=="10870a74acf93ba4f87af22c19ab1677" set bootpatchplan=26300& set vivo_suu_patch=y
if "%bootpatchmd5%"=="b4a4a2be5fa2a38db5149f3c752a1104" set bootpatchplan=25200& set vivo_suu_patch=y
if "%bootpatchmd5%"=="16cbb54272b01c13bdb860e3207284b8" set bootpatchplan=26200& set vivo_suu_patch=y
if "%bootpatchmd5%"=="1e688cdfe37d1eb18b0e25181a0352de" set bootpatchplan=25210
if "%bootpatchmd5%"=="4f7a97a55135a8b684d3c99fac68f0e0" set bootpatchplan=phh-20201-20.3-15bd2da8
if "%bootpatchmd5%"=="cf9e4aa382b3e63d89197fdc68830622" set bootpatchplan=26300
if "%bootpatchplan%"=="" ECHOC {%c_e%}Chinese text Magisk Chinese text(%magiskver_show% %magiskver%). Chinese text .{%c_i%}{\n}& call log %logger% F Chinese text Magisk Chinese text . Chinese text:%magiskver_show%. Chinese text:%magiskver%. Chinese text md5:%bootpatchmd5%& goto FATAL
call log %logger% I Chinese text:%bootpatchplan%. Chinese text vivo_suu Chinese text:%vivo_suu_patch%
goto MAGISKPATCH-%bootpatchplan%

:MAGISKPATCH-ALPHA_070719db_28001
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-ALPHA_070719db_28001
if not exist %tmpdir%\imgkit-magiskpatch\magisk.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-ALPHA_070719db_28001
if not exist %tmpdir%\imgkit-magiskpatch\stub.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-ALPHA_070719db_28001
if not exist %tmpdir%\imgkit-magiskpatch\init-ld.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\init-ld.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\init-ld.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-ALPHA_070719db_28001
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-ALPHA_070719db_28001
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& set SKIP_BACKUP=#& goto MAGISKPATCH-ALPHA_070719db_28001-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
set SKIP_BACKUP=
if "%STATUS%"=="0" goto MAGISKPATCH-ALPHA_070719db_28001-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-ALPHA_070719db_28001-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-ALPHA_070719db_28001
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-ALPHA_070719db_28001-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-ALPHA_070719db_28001-MODE0)
goto MAGISKPATCH-ALPHA_070719db_28001-1
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-ALPHA_070719db_28001-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio "extract .backup/.magisk config.orig" "restore" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-ALPHA_070719db_28001-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-ALPHA_070719db_28001-MODE1
goto MAGISKPATCH-ALPHA_070719db_28001-1
:MAGISKPATCH-ALPHA_070719db_28001-1
if not exist %tmpdir%\imgkit-magiskpatch\config.orig goto MAGISKPATCH-ALPHA_070719db_28001-2
for /f "tokens=2 delims== " %%a in ('type %tmpdir%\imgkit-magiskpatch\config.orig ^| find "SHA1="') do set SHA1=%%a
:MAGISKPATCH-ALPHA_070719db_28001-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk.xz magisk.xz" "add 0644 overlay.d/sbin/stub.xz stub.xz" "add 0644 overlay.d/sbin/init-ld.xz init-ld.xz" "patch" "%SKIP_BACKUP% backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-ALPHA_070719db_28001-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-ALPHA_070719db_28001-3
::Chinese text kernel
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if exist kernel set PATCHEDKERNEL=false
if exist kernel (
    call log %logger% I Chinese text kernel. Chinese text
    if "%vivo_suu_patch%"=="y" (
        call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
        magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E patch-vivo-do_mount_check Chinese text)
    call log %logger% I Chinese text kernel- Chinese text RKP
    magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text RKP Chinese text
    call log %logger% I Chinese text kernel- Chinese text defex
    magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text defex Chinese text
    call log %logger% I Chinese text kernel- Chinese text PROCA
    magiskboot.exe hexpatch kernel 70726F63615F636F6E66696700 70726F63615F6D616769736B00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text PROCA Chinese text
    if "%LEGACYSAR%"=="true" (
        call log %logger% I Chinese text kernel- Chinese text rootfs
        magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text rootfs Chinese text))
if exist kernel (if "%PATCHEDKERNEL%"=="false" call log %logger% I kernel Chinese text . Chinese text kernel & del /F /Q kernel 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text kernel Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text kernel Chinese text&& goto FATAL)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-28000
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-28000
if not exist %tmpdir%\imgkit-magiskpatch\magisk.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-28000
if not exist %tmpdir%\imgkit-magiskpatch\stub.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-28000
if not exist %tmpdir%\imgkit-magiskpatch\init-ld.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\init-ld.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\init-ld.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-28000
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-28000
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& set SKIP_BACKUP=#& goto MAGISKPATCH-28000-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
set SKIP_BACKUP=
if "%STATUS%"=="0" goto MAGISKPATCH-28000-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-28000-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-28000
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-28000-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-28000-MODE0)
goto MAGISKPATCH-28000-1
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-28000-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio "extract .backup/.magisk config.orig" "restore" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-28000-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-28000-MODE1
goto MAGISKPATCH-28000-1
:MAGISKPATCH-28000-1
if not exist %tmpdir%\imgkit-magiskpatch\config.orig goto MAGISKPATCH-28000-2
for /f "tokens=2 delims== " %%a in ('type %tmpdir%\imgkit-magiskpatch\config.orig ^| find "SHA1="') do set SHA1=%%a
:MAGISKPATCH-28000-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk.xz magisk.xz" "add 0644 overlay.d/sbin/stub.xz stub.xz" "add 0644 overlay.d/sbin/init-ld.xz init-ld.xz" "patch" "%SKIP_BACKUP% backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-28000-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-28000-3
::Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
set dtbname=
set result=y
if exist dtb set dtbname=dtb& call :MAGISKPATCH-28000-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-28000-3
if exist kernel_dtb set dtbname=kernel_dtb& call :MAGISKPATCH-28000-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-28000-3
if exist extra set dtbname=extra& call :MAGISKPATCH-28000-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-28000-3
if "%dtbname%"=="" call log %logger% I Chinese text dtb Chinese text kernel_dtb Chinese text extra
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-28000-4
:MAGISKPATCH-28000-dtb
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% test 1>>%logfile% 2>&1 || set result=n&& ECHOC {%c_e%}Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text&& pause>nul && ECHO. Chinese text ... && goto :eof
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
goto :eof
:MAGISKPATCH-28000-4
::Chinese text kernel
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if exist kernel set PATCHEDKERNEL=false
if exist kernel (
    call log %logger% I Chinese text kernel. Chinese text
    if "%vivo_suu_patch%"=="y" (
        call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
        magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E patch-vivo-do_mount_check Chinese text)
    call log %logger% I Chinese text kernel- Chinese text RKP
    magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text RKP Chinese text
    call log %logger% I Chinese text kernel- Chinese text defex
    magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text defex Chinese text
    call log %logger% I Chinese text kernel- Chinese text PROCA
    magiskboot.exe hexpatch kernel 70726F63615F636F6E66696700 70726F63615F6D616769736B00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text PROCA Chinese text
    if "%LEGACYSAR%"=="true" (
        call log %logger% I Chinese text kernel- Chinese text rootfs
        magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text rootfs Chinese text))
if exist kernel (if "%PATCHEDKERNEL%"=="false" call log %logger% I kernel Chinese text . Chinese text kernel & del /F /Q kernel 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text kernel Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text kernel Chinese text&& goto FATAL)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-27006
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27006
if not exist %tmpdir%\imgkit-magiskpatch\magisk.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27006
if not exist %tmpdir%\imgkit-magiskpatch\stub.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27006
if not exist %tmpdir%\imgkit-magiskpatch\init-ld.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\init-ld.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\init-ld.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27006
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-27006
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& set SKIP_BACKUP=#& goto MAGISKPATCH-27006-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
set SKIP_BACKUP=
if "%STATUS%"=="0" goto MAGISKPATCH-27006-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-27006-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-27006
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-27006-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27006-MODE0)
goto MAGISKPATCH-27006-1
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-27006-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio "extract .backup/.magisk config.orig" "restore" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-27006-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27006-MODE1
goto MAGISKPATCH-27006-1
:MAGISKPATCH-27006-1
if not exist %tmpdir%\imgkit-magiskpatch\config.orig goto MAGISKPATCH-27006-2
for /f "tokens=2 delims== " %%a in ('type %tmpdir%\imgkit-magiskpatch\config.orig ^| find "SHA1="') do set SHA1=%%a
:MAGISKPATCH-27006-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk.xz magisk.xz" "add 0644 overlay.d/sbin/stub.xz stub.xz" "add 0644 overlay.d/sbin/init-ld.xz init-ld.xz" "patch" "%SKIP_BACKUP% backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-27006-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-27006-3
::Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
set dtbname=
set result=y
if exist dtb set dtbname=dtb& call :MAGISKPATCH-27006-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-27006-3
if exist kernel_dtb set dtbname=kernel_dtb& call :MAGISKPATCH-27006-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-27006-3
if exist extra set dtbname=extra& call :MAGISKPATCH-27006-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-27006-3
if "%dtbname%"=="" call log %logger% I Chinese text dtb Chinese text kernel_dtb Chinese text extra
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-27006-4
:MAGISKPATCH-27006-dtb
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% test 1>>%logfile% 2>&1 || set result=n&& ECHOC {%c_e%}Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text&& pause>nul && ECHO. Chinese text ... && goto :eof
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
goto :eof
:MAGISKPATCH-27006-4
::Chinese text kernel
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if exist kernel set PATCHEDKERNEL=false
if exist kernel (
    call log %logger% I Chinese text kernel. Chinese text
    if "%vivo_suu_patch%"=="y" (
        call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
        magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E patch-vivo-do_mount_check Chinese text)
    call log %logger% I Chinese text kernel- Chinese text RKP
    magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text RKP Chinese text
    call log %logger% I Chinese text kernel- Chinese text defex
    magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text defex Chinese text
    if "%LEGACYSAR%"=="true" (
        call log %logger% I Chinese text kernel- Chinese text rootfs
        magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text rootfs Chinese text))
if exist kernel (if "%PATCHEDKERNEL%"=="false" call log %logger% I kernel Chinese text . Chinese text kernel & del /F /Q kernel 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text kernel Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text kernel Chinese text&& goto FATAL)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-27005
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27005
if not exist %tmpdir%\imgkit-magiskpatch\magisk.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27005
if not exist %tmpdir%\imgkit-magiskpatch\stub.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27005
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-27005
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& set SKIP_BACKUP=#& goto MAGISKPATCH-27005-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
set SKIP_BACKUP=
if "%STATUS%"=="0" goto MAGISKPATCH-27005-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-27005-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-27005
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-27005-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27005-MODE0)
goto MAGISKPATCH-27005-1
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-27005-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio "extract .backup/.magisk config.orig" "restore" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-27005-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-27005-MODE1
goto MAGISKPATCH-27005-1
:MAGISKPATCH-27005-1
if not exist %tmpdir%\imgkit-magiskpatch\config.orig goto MAGISKPATCH-27005-2
for /f "tokens=2 delims== " %%a in ('type %tmpdir%\imgkit-magiskpatch\config.orig ^| find "SHA1="') do set SHA1=%%a
:MAGISKPATCH-27005-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk.xz magisk.xz" "add 0644 overlay.d/sbin/stub.xz stub.xz" "patch" "%SKIP_BACKUP% backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-27005-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-27005-3
::Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
set dtbname=
set result=y
if exist dtb set dtbname=dtb& call :MAGISKPATCH-27005-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-27005-3
if exist kernel_dtb set dtbname=kernel_dtb& call :MAGISKPATCH-27005-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-27005-3
if exist extra set dtbname=extra& call :MAGISKPATCH-27005-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-27005-3
if "%dtbname%"=="" call log %logger% I Chinese text dtb Chinese text kernel_dtb Chinese text extra
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-27005-4
:MAGISKPATCH-27005-dtb
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% test 1>>%logfile% 2>&1 || set result=n&& ECHOC {%c_e%}Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text&& pause>nul && ECHO. Chinese text ... && goto :eof
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
goto :eof
:MAGISKPATCH-27005-4
::Chinese text kernel
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if exist kernel set PATCHEDKERNEL=false
if exist kernel (
    call log %logger% I Chinese text kernel. Chinese text
    if "%vivo_suu_patch%"=="y" (
        call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
        magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E patch-vivo-do_mount_check Chinese text)
    call log %logger% I Chinese text kernel- Chinese text RKP
    magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text RKP Chinese text
    call log %logger% I Chinese text kernel- Chinese text defex
    magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text defex Chinese text
    if "%LEGACYSAR%"=="true" (
        call log %logger% I Chinese text kernel- Chinese text rootfs
        magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text rootfs Chinese text))
if exist kernel (if "%PATCHEDKERNEL%"=="false" call log %logger% I kernel Chinese text . Chinese text kernel & del /F /Q kernel 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text kernel Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text kernel Chinese text&& goto FATAL)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-26300
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26300
if not exist %tmpdir%\imgkit-magiskpatch\magisk32.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26300
if "%arch:~-2,2%"=="64" (if not exist %tmpdir%\imgkit-magiskpatch\magisk64.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26300)
if not exist %tmpdir%\imgkit-magiskpatch\stub.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26300
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-26300
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& set SKIP_BACKUP=#& goto MAGISKPATCH-26300-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
set SKIP_BACKUP=
if "%STATUS%"=="0" goto MAGISKPATCH-26300-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-26300-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-26300
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-26300-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26300-MODE0)
goto MAGISKPATCH-26300-1
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-26300-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio "extract .backup/.magisk config.orig" "restore" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-26300-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26300-MODE1
goto MAGISKPATCH-26300-1
:MAGISKPATCH-26300-1
if not exist %tmpdir%\imgkit-magiskpatch\config.orig goto MAGISKPATCH-26300-2
for /f "tokens=2 delims== " %%a in ('type %tmpdir%\imgkit-magiskpatch\config.orig ^| find "SHA1="') do set SHA1=%%a
:MAGISKPATCH-26300-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk32.xz magisk32.xz" "%var% add 0644 overlay.d/sbin/magisk64.xz magisk64.xz" "add 0644 overlay.d/sbin/stub.xz stub.xz" "patch" "%SKIP_BACKUP% backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-26300-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-26300-3
::Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
set dtbname=
set result=y
if exist dtb set dtbname=dtb& call :magiskpatch-26300-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-26300-3
if exist kernel_dtb set dtbname=kernel_dtb& call :magiskpatch-26300-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-26300-3
if exist extra set dtbname=extra& call :magiskpatch-26300-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-26300-3
if "%dtbname%"=="" call log %logger% I Chinese text dtb Chinese text kernel_dtb Chinese text extra
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-26300-4
:magiskpatch-26300-dtb
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% test 1>>%logfile% 2>&1 || set result=n&& ECHOC {%c_e%}Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text&& pause>nul && ECHO. Chinese text ... && goto :eof
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
goto :eof
:MAGISKPATCH-26300-4
::Chinese text kernel
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if exist kernel set PATCHEDKERNEL=false
if exist kernel (
    call log %logger% I Chinese text kernel. Chinese text
    if "%vivo_suu_patch%"=="y" (
        call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
        magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E patch-vivo-do_mount_check Chinese text)
    call log %logger% I Chinese text kernel- Chinese text RKP
    magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text RKP Chinese text
    call log %logger% I Chinese text kernel- Chinese text defex
    magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text defex Chinese text
    if "%LEGACYSAR%"=="true" (
        call log %logger% I Chinese text kernel- Chinese text rootfs
        magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text rootfs Chinese text))
if exist kernel (if "%PATCHEDKERNEL%"=="false" call log %logger% I kernel Chinese text . Chinese text kernel & del /F /Q kernel 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text kernel Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text kernel Chinese text&& goto FATAL)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-26200
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26200
if not exist %tmpdir%\imgkit-magiskpatch\magisk32.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26200
if "%arch:~-2,2%"=="64" (if not exist %tmpdir%\imgkit-magiskpatch\magisk64.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26200)
if not exist %tmpdir%\imgkit-magiskpatch\stub.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26200
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-26200
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& set SKIP_BACKUP=#& goto MAGISKPATCH-26200-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
set SKIP_BACKUP=
if "%STATUS%"=="0" goto MAGISKPATCH-26200-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-26200-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-26200
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-26200-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26200-MODE0)
goto MAGISKPATCH-26200-1
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-26200-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio "extract .backup/.magisk config.orig" "restore" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-26200-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26200-MODE1
goto MAGISKPATCH-26200-1
:MAGISKPATCH-26200-1
if not exist %tmpdir%\imgkit-magiskpatch\config.orig goto MAGISKPATCH-26200-2
for /f "tokens=2 delims== " %%a in ('type %tmpdir%\imgkit-magiskpatch\config.orig ^| find "SHA1="') do set SHA1=%%a
:MAGISKPATCH-26200-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.PATCHVBMETAFLAG=%PATCHVBMETAFLAG%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk32.xz magisk32.xz" "%var% add 0644 overlay.d/sbin/magisk64.xz magisk64.xz" "add 0644 overlay.d/sbin/stub.xz stub.xz" "patch" "%SKIP_BACKUP% backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-26200-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-26200-3
::Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
set dtbname=
set result=y
if exist dtb set dtbname=dtb& call :magiskpatch-26200-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-26200-3
if exist kernel_dtb set dtbname=kernel_dtb& call :magiskpatch-26200-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-26200-3
if exist extra set dtbname=extra& call :magiskpatch-26200-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-26200-3
if "%dtbname%"=="" call log %logger% I Chinese text dtb Chinese text kernel_dtb Chinese text extra
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-26200-4
:magiskpatch-26200-dtb
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% test 1>>%logfile% 2>&1 || set result=n&& ECHOC {%c_e%}Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text&& pause>nul && ECHO. Chinese text ... && goto :eof
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
goto :eof
:MAGISKPATCH-26200-4
::Chinese text kernel
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if exist kernel set PATCHEDKERNEL=false
if exist kernel (
    call log %logger% I Chinese text kernel. Chinese text
    if "%vivo_suu_patch%"=="y" (
        call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
        magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E patch-vivo-do_mount_check Chinese text)
    call log %logger% I Chinese text kernel- Chinese text RKP
    magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text RKP Chinese text
    call log %logger% I Chinese text kernel- Chinese text defex
    magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text defex Chinese text
    if "%LEGACYSAR%"=="true" (
        call log %logger% I Chinese text kernel- Chinese text rootfs
        magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text rootfs Chinese text))
if exist kernel (if "%PATCHEDKERNEL%"=="false" call log %logger% I kernel Chinese text . Chinese text kernel & del /F /Q kernel 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text kernel Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text kernel Chinese text&& goto FATAL)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-26000
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26000
if not exist %tmpdir%\imgkit-magiskpatch\magisk32.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26000
if "%arch:~-2,2%"=="64" (if not exist %tmpdir%\imgkit-magiskpatch\magisk64.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26000)
if not exist %tmpdir%\imgkit-magiskpatch\stub.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26000
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-26000
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-26000-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-26000-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-26000-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-26000
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-26000-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26000-MODE0)
goto MAGISKPATCH-26000-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-26000-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-26000-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-26000-MODE1
goto MAGISKPATCH-26000-2
:MAGISKPATCH-26000-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.PATCHVBMETAFLAG=%PATCHVBMETAFLAG%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
call random 16 abcdef0123456789
echo.RANDOMSEED=0x%random__str%|find "RANDOMSEED" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk32.xz magisk32.xz" "%var% add 0644 overlay.d/sbin/magisk64.xz magisk64.xz" "add 0644 overlay.d/sbin/stub.xz stub.xz" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-26000-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-26000-3
::Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
set dtbname=
set result=y
if exist dtb set dtbname=dtb& call :magiskpatch-26000-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-26000-3
if exist kernel_dtb set dtbname=kernel_dtb& call :magiskpatch-26000-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-26000-3
if exist extra set dtbname=extra& call :magiskpatch-26000-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-26000-3
if "%dtbname%"=="" call log %logger% I Chinese text dtb Chinese text kernel_dtb Chinese text extra
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-26000-4
:magiskpatch-26000-dtb
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% test 1>>%logfile% 2>&1 || set result=n&& ECHOC {%c_e%}Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text&& pause>nul && ECHO. Chinese text ... && goto :eof
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
goto :eof
:MAGISKPATCH-26000-4
::Chinese text kernel
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if exist kernel set PATCHEDKERNEL=false
if exist kernel (
    call log %logger% I Chinese text kernel. Chinese text
    if "%vivo_suu_patch%"=="y" (
        call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
        magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E patch-vivo-do_mount_check Chinese text)
    call log %logger% I Chinese text kernel- Chinese text RKP
    magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text RKP Chinese text
    call log %logger% I Chinese text kernel- Chinese text defex
    magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text defex Chinese text
    if "%SYSTEM_ROOT%"=="true" (
        call log %logger% I Chinese text kernel- Chinese text rootfs
        magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text rootfs Chinese text))
if exist kernel (if "%PATCHEDKERNEL%"=="false" call log %logger% I kernel Chinese text . Chinese text kernel & del /F /Q kernel 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text kernel Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text kernel Chinese text&& goto FATAL)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-25210
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25210
if not exist %tmpdir%\imgkit-magiskpatch\magisk32.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25210
if "%arch:~-2,2%"=="64" (if not exist %tmpdir%\imgkit-magiskpatch\magisk64.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25210)
if not exist %tmpdir%\imgkit-magiskpatch\stub.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\stub.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25210
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-25210
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-25210-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-25210-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-25210-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-25210
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-25210-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25210-MODE0)
goto MAGISKPATCH-25210-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-25210-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-25210-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25210-MODE1
goto MAGISKPATCH-25210-2
:MAGISKPATCH-25210-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.PATCHVBMETAFLAG=%PATCHVBMETAFLAG%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
call random 8 abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
echo.RANDOMSEED=0x%random__str%|find "RANDOMSEED" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk32.xz magisk32.xz" "%var% add 0644 overlay.d/sbin/magisk64.xz magisk64.xz" "add 0644 overlay.d/sbin/stub.xz stub.xz" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-25210-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-25210-3
::Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
set dtbname=
set result=y
if exist dtb set dtbname=dtb& call :MAGISKPATCH-25210-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-25210-3
if exist kernel_dtb set dtbname=kernel_dtb& call :MAGISKPATCH-25210-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-25210-3
if exist extra set dtbname=extra& call :MAGISKPATCH-25210-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-25210-3
if "%dtbname%"=="" call log %logger% I Chinese text dtb Chinese text kernel_dtb Chinese text extra
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-25210-4
:MAGISKPATCH-25210-dtb
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% test 1>>%logfile% 2>&1 || set result=n&& ECHOC {%c_e%}Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text&& pause>nul && ECHO. Chinese text ... && goto :eof
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
goto :eof
:MAGISKPATCH-25210-4
::Chinese text kernel
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if exist kernel set PATCHEDKERNEL=false
if exist kernel (
    call log %logger% I Chinese text kernel. Chinese text
    if "%vivo_suu_patch%"=="y" (
        call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
        magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E patch-vivo-do_mount_check Chinese text)
    call log %logger% I Chinese text kernel- Chinese text RKP
    magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text RKP Chinese text
    call log %logger% I Chinese text kernel- Chinese text defex
    magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text defex Chinese text
    if "%SYSTEM_ROOT%"=="true" (
        call log %logger% I Chinese text kernel- Chinese text rootfs
        magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 && set PATCHEDKERNEL=true || call log %logger% E Chinese text rootfs Chinese text))
if exist kernel (if "%PATCHEDKERNEL%"=="false" call log %logger% I kernel Chinese text . Chinese text kernel & del /F /Q kernel 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text kernel Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text kernel Chinese text&& goto FATAL)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-25200
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25200
if not exist %tmpdir%\imgkit-magiskpatch\magisk32.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25200
if "%arch:~-2,2%"=="64" (if not exist %tmpdir%\imgkit-magiskpatch\magisk64.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25200)
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-25200
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-25200-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-25200-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-25200-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-25200
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-25200-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25200-MODE0)
goto MAGISKPATCH-25200-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-25200-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-25200-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25200-MODE1
goto MAGISKPATCH-25200-2
:MAGISKPATCH-25200-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.PATCHVBMETAFLAG=%PATCHVBMETAFLAG%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk32.xz magisk32.xz" "%var% add 0644 overlay.d/sbin/magisk64.xz magisk64.xz" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-25200-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-25200-3
::Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
set dtbname=
set result=y
if exist dtb set dtbname=dtb& call :magiskpatch-25200-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-25200-3
if exist kernel_dtb set dtbname=kernel_dtb& call :magiskpatch-25200-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-25200-3
if exist extra set dtbname=extra& call :magiskpatch-25200-dtb
if "%result%"=="n" cd %framework_workspace% && goto MAGISKPATCH-25200-3
if "%dtbname%"=="" call log %logger% I Chinese text dtb Chinese text kernel_dtb Chinese text extra
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-25200-4
:magiskpatch-25200-dtb
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% test 1>>%logfile% 2>&1 || set result=n&& ECHOC {%c_e%}Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %dtbname% Chinese text . Chinese text boot Chinese text Magisk Chinese text&& pause>nul && ECHO. Chinese text ... && goto :eof
call log %logger% I Chinese text %dtbname%
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
goto :eof
:MAGISKPATCH-25200-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex
magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-25000
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25000
if not exist %tmpdir%\imgkit-magiskpatch\magisk32.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25000
if "%arch:~-2,2%"=="64" (if not exist %tmpdir%\imgkit-magiskpatch\magisk64.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25000)
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-25000
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-25000-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-25000-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-25000-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-25000
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-25000-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25000-MODE0)
goto MAGISKPATCH-25000-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-25000-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-25000-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-25000-MODE1
goto MAGISKPATCH-25000-2
:MAGISKPATCH-25000-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.PATCHVBMETAFLAG=%PATCHVBMETAFLAG%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk32.xz magisk32.xz" "%var% add 0644 overlay.d/sbin/magisk64.xz magisk64.xz" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-25000-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-25000-3
::Chinese text dtb
set dtbname=
if exist %tmpdir%\imgkit-magiskpatch\dtb set dtbname=dtb
if exist %tmpdir%\imgkit-magiskpatch\kernel_dtb set dtbname=kernel_dtb
if exist %tmpdir%\imgkit-magiskpatch\extra set dtbname=extra
if "%dtbname%"=="" (
    call log %logger% I Chinese text dtb Chinese text kernel_dtb
    goto MAGISKPATCH-25000-4)
call log %logger% I Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-25000-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex
magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-23000
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-23000
if not exist %tmpdir%\imgkit-magiskpatch\magisk32.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk32.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-23000
if "%arch:~-2,2%"=="64" (if not exist %tmpdir%\imgkit-magiskpatch\magisk64.xz ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk64.xz&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-23000)
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-23000
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text recovery_dtbo
if exist %tmpdir%\imgkit-magiskpatch\recovery_dtbo set RECOVERYMODE=true
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-23000-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-23000-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-23000-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-23000
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-23000-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-23000-MODE0)
goto MAGISKPATCH-23000-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-23000-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-23000-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-23000-MODE1
goto MAGISKPATCH-23000-2
:MAGISKPATCH-23000-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
if "%arch:~-2,2%"=="64" (set var=) else (set var=#)
magiskboot.exe cpio ramdisk.cpio "add 0750 init magiskinit" "mkdir 0750 overlay.d" "mkdir 0750 overlay.d/sbin" "add 0644 overlay.d/sbin/magisk32.xz magisk32.xz" "%var% add 0644 overlay.d/sbin/magisk64.xz magisk64.xz" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-23000-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-23000-3
::Chinese text dtb
set dtbname=
if exist %tmpdir%\imgkit-magiskpatch\dtb set dtbname=dtb
if exist %tmpdir%\imgkit-magiskpatch\kernel_dtb set dtbname=kernel_dtb
if exist %tmpdir%\imgkit-magiskpatch\extra set dtbname=extra
if "%dtbname%"=="" (
    call log %logger% I Chinese text dtb Chinese text kernel_dtb
    goto MAGISKPATCH-23000-4)
call log %logger% I Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-23000-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex
magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-21400
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-21400
::if not exist %tmpdir%\imgkit-magiskpatch\magisk ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-21400
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-21400
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text recovery_dtbo
if exist %tmpdir%\imgkit-magiskpatch\recovery_dtbo set RECOVERYMODE=true
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-21400-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-21400-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-21400-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-21400
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-21400-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-21400-MODE0)
goto MAGISKPATCH-21400-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-21400-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-21400-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-21400-MODE1
goto MAGISKPATCH-21400-2
:MAGISKPATCH-21400-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
magiskboot.exe cpio ramdisk.cpio "add 750 init magiskinit" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-21400-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-21400-3
::Chinese text dtb
set dtbname=
if exist %tmpdir%\imgkit-magiskpatch\dtb set dtbname=dtb
if exist %tmpdir%\imgkit-magiskpatch\kernel_dtb set dtbname=kernel_dtb
if exist %tmpdir%\imgkit-magiskpatch\extra set dtbname=extra
if "%dtbname%"=="" (
    call log %logger% I Chinese text dtb Chinese text kernel_dtb
    goto MAGISKPATCH-21400-4)
call log %logger% I Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-21400-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex
magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-21200
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-21200
::if not exist %tmpdir%\imgkit-magiskpatch\magisk ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-21200
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-21200
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text recovery_dtbo
if exist %tmpdir%\imgkit-magiskpatch\recovery_dtbo set RECOVERYMODE=true
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-21200-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-21200-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-21200-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-21200
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-21200-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-21200-MODE0)
goto MAGISKPATCH-21200-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-21200-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-21200-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-21200-MODE1
goto MAGISKPATCH-21200-2
:MAGISKPATCH-21200-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
magiskboot.exe cpio ramdisk.cpio "add 750 init magiskinit" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-21200-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-21200-3
::Chinese text dtb
set dtbname=
if exist %tmpdir%\imgkit-magiskpatch\dtb set dtbname=dtb
if exist %tmpdir%\imgkit-magiskpatch\kernel_dtb set dtbname=kernel_dtb
if exist %tmpdir%\imgkit-magiskpatch\extra set dtbname=extra
if exist %tmpdir%\imgkit-magiskpatch\recovery_dtbo set dtbname=recovery_dtbo
if "%dtbname%"=="" (
    call log %logger% I Chinese text dtb
    goto MAGISKPATCH-21200-4)
call log %logger% I Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-21200-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex
magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-19400
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19400
::if not exist %tmpdir%\imgkit-magiskpatch\magisk ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19400
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-19400
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text recovery_dtbo
if exist %tmpdir%\imgkit-magiskpatch\recovery_dtbo set RECOVERYMODE=true
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-19400-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-19400-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-19400-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-19400
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-19400-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19400-MODE0)
goto MAGISKPATCH-19400-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-19400-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-19400-MODE1
call log %logger% I Chinese text ramdisk.cpio Chinese text init.rc
magiskboot.exe cpio ramdisk.cpio "exists init.rc" 1>>%logfile% 2>&1
if "%errorlevel%"=="0" (
    call log %logger% I ramdisk.cpio Chinese text init.rc. Chinese text ramdisk.cpio
    copy /Y ramdisk.cpio ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19400-MODE1
) else (
    call log %logger% I ramdisk.cpio Chinese text init.rc. Chinese text ramdisk.cpio
    del /F /Q ramdisk.cpio 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19400-MODE1)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-19400-2
:MAGISKPATCH-19400-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
magiskboot.exe cpio ramdisk.cpio "add 750 init magiskinit" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-19400-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-19400-3
if "%KEEPVERITY%"=="true" (
    call log %logger% I Chinese text . Chinese text dtb
    goto MAGISKPATCH-19400-4)
::Chinese text dtb
set dtbname=
if exist %tmpdir%\imgkit-magiskpatch\dtb set dtbname=dtb
if exist %tmpdir%\imgkit-magiskpatch\kernel_dtb set dtbname=kernel_dtb
if exist %tmpdir%\imgkit-magiskpatch\extra set dtbname=extra
if exist %tmpdir%\imgkit-magiskpatch\recovery_dtbo set dtbname=recovery_dtbo
if "%dtbname%"=="" (
    call log %logger% I Chinese text dtb
    goto MAGISKPATCH-19400-4)
call log %logger% I Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-19400-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex
magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-19000
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19000
::if not exist %tmpdir%\imgkit-magiskpatch\magisk ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19000
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-19000
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-19000-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-19000-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-19000-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-19000
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-19000-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19000-MODE0)
goto MAGISKPATCH-19000-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-19000-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-19000-MODE1
call log %logger% I Chinese text ramdisk.cpio Chinese text init.rc
magiskboot.exe cpio ramdisk.cpio "exists init.rc" 1>>%logfile% 2>&1
if "%errorlevel%"=="0" (
    call log %logger% I ramdisk.cpio Chinese text init.rc. Chinese text ramdisk.cpio
    copy /Y ramdisk.cpio ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19000-MODE1
) else (
    call log %logger% I ramdisk.cpio Chinese text init.rc. Chinese text ramdisk.cpio
    del /F /Q ramdisk.cpio 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-19000-MODE1)
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-19000-2
:MAGISKPATCH-19000-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
magiskboot.exe cpio ramdisk.cpio "add 750 init magiskinit" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-19000-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-19000-3
if "%KEEPVERITY%"=="true" (
    call log %logger% I Chinese text . Chinese text dtb
    goto MAGISKPATCH-19000-4)
::Chinese text dtb
set dtbname=
if exist %tmpdir%\imgkit-magiskpatch\dtb set dtbname=dtb
if exist %tmpdir%\imgkit-magiskpatch\kernel_dtb set dtbname=kernel_dtb
if exist %tmpdir%\imgkit-magiskpatch\extra set dtbname=extra
if "%dtbname%"=="" (
    call log %logger% I Chinese text dtb
    goto MAGISKPATCH-19000-4)
call log %logger% I Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-19000-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex
magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-18100
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-18100
::if not exist %tmpdir%\imgkit-magiskpatch\magisk ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-18100
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-18100
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-18100-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-18100-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-18100
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-18100-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-18100-MODE0)
goto MAGISKPATCH-18100-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-18100-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-18100-MODE1
copy /Y ramdisk.cpio ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-18100-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-18100-2
:MAGISKPATCH-18100-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
magiskboot.exe cpio ramdisk.cpio "add 750 init magiskinit" "patch" "backup ramdisk.cpio.orig" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-18100-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-18100-3
if "%KEEPVERITY%"=="true" (
    call log %logger% I Chinese text . Chinese text dtb
    goto MAGISKPATCH-18100-4)
::Chinese text dtb
set dtbname=
if exist %tmpdir%\imgkit-magiskpatch\dtb set dtbname=dtb
if exist %tmpdir%\imgkit-magiskpatch\extra set dtbname=extra
if "%dtbname%"=="" (
    call log %logger% I Chinese text dtb
    goto MAGISKPATCH-18100-4)
call log %logger% I Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-18100-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex
magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-17200
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-17200
::if not exist %tmpdir%\imgkit-magiskpatch\magisk ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-17200
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-17200
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-17200-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-17200-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-17200
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-17200-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-17200-MODE0)
goto MAGISKPATCH-17200-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-17200-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-17200-MODE1
copy /Y ramdisk.cpio ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-17200-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-17200-2
:MAGISKPATCH-17200-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
magiskboot.exe cpio ramdisk.cpio "add 750 init magiskinit" "patch" "backup ramdisk.cpio.orig" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-17200-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-17200-3
if "%KEEPVERITY%"=="true" (
    call log %logger% I Chinese text . Chinese text dtb
    goto MAGISKPATCH-17200-4)
::Chinese text dtb
set dtbname=
if exist %tmpdir%\imgkit-magiskpatch\dtb set dtbname=dtb
if exist %tmpdir%\imgkit-magiskpatch\extra set dtbname=extra
if "%dtbname%"=="" (
    call log %logger% I Chinese text dtb
    goto MAGISKPATCH-17200-4)
call log %logger% I Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-17200-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex-A8_variant
magiskboot.exe hexpatch kernel 006044B91F040071802F005460DE41F9 006044B91F00006B802F005460DE41F9 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex-A8_variant Chinese text
call log %logger% I Chinese text kernel- Chinese text defex-N9_variant
magiskboot.exe hexpatch kernel 603A46B91F0400710030005460C642F9 603A46B91F00006B0030005460C642F9 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex-N9_variant Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D6673 77616E745F696E697472616D6673 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-phh-20201-20.3-15bd2da8
::Chinese text Magisk Chinese text
call log %logger% I Chinese text Magisk Chinese text
if not exist %tmpdir%\imgkit-magiskpatch\magiskinit ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magiskinit&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-phh-20201-20.3-15bd2da8
::if not exist %tmpdir%\imgkit-magiskpatch\magisk ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\magisk. {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\magisk&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-phh-20201-20.3-15bd2da8
::Chinese text boot
call log %logger% I Chinese text %bootpath%
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe unpack %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-phh-20201-20.3-15bd2da8
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text recovery_dtbo
if exist %tmpdir%\imgkit-magiskpatch\recovery_dtbo set RECOVERYMODE=true
::Chinese text ramdisk
if not exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    set STATUS=0& goto MAGISKPATCH-phh-20201-20.3-15bd2da8-MODE0)
call log %logger% I Chinese text ramdisk.cpio
magiskboot.exe cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio test 1>>%logfile% 2>&1
set STATUS=%errorlevel%
if "%STATUS%"=="0" goto MAGISKPATCH-phh-20201-20.3-15bd2da8-MODE0
if "%STATUS%"=="1" goto MAGISKPATCH-phh-20201-20.3-15bd2da8-MODE1
ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text ramdisk.cpio Chinese text:%STATUS%& pause>nul & ECHO. Chinese text ... & goto MAGISKPATCH-phh-20201-20.3-15bd2da8
::Chinese text 0-Stock boot image detected
:MAGISKPATCH-phh-20201-20.3-15bd2da8-MODE0
call log %logger% I Chinese text 0
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot sha1 %bootpath% 2^>^>%logfile%') do set SHA1=%%a
if exist %tmpdir%\imgkit-magiskpatch\ramdisk.cpio (
    call log %logger% I Chinese text ramdisk.cpio
    copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-phh-20201-20.3-15bd2da8-MODE0)
goto MAGISKPATCH-phh-20201-20.3-15bd2da8-2
::Chinese text 1-Magisk patched boot image detected
:MAGISKPATCH-phh-20201-20.3-15bd2da8-MODE1
call log %logger% I Chinese text 1
call log %logger% I Chinese text sha1
set SHA1=
for /f %%a in ('magiskboot cpio ramdisk.cpio sha1 2^>^>%logfile%') do set SHA1=%%a
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe cpio ramdisk.cpio restore 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-phh-20201-20.3-15bd2da8-MODE1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
call log %logger% I Chinese text ramdisk.cpio
copy /Y %tmpdir%\imgkit-magiskpatch\ramdisk.cpio %tmpdir%\imgkit-magiskpatch\ramdisk.cpio.orig 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-phh-20201-20.3-15bd2da8-MODE1
goto MAGISKPATCH-phh-20201-20.3-15bd2da8-2
:MAGISKPATCH-phh-20201-20.3-15bd2da8-2
::Chinese text ramdisk.cpio
call log %logger% I Chinese text ramdisk.cpio
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
echo.KEEPVERITY=%KEEPVERITY%>config& echo.KEEPFORCEENCRYPT=%KEEPFORCEENCRYPT%>>config& echo.RECOVERYMODE=%RECOVERYMODE%>>config
if not "%SHA1%"=="" echo.SHA1=%SHA1%|find "SHA1" 1>>config
busybox.exe sed -i "s/\r//g;s/^M//g" config
type config>>%logfile%
magiskboot.exe cpio ramdisk.cpio "rm init.zygote32.rc" "rm init.zygote64_32.rc" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text zygote Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text zygote Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-phh-20201-20.3-15bd2da8-2
magiskboot.exe cpio ramdisk.cpio "add 750 init magiskinit" "patch" "backup ramdisk.cpio.orig" "mkdir 000 .backup" "add 000 .backup/.magisk config" 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-phh-20201-20.3-15bd2da8-2
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-phh-20201-20.3-15bd2da8-3
::Chinese text dtb
set dtbname=
if exist %tmpdir%\imgkit-magiskpatch\dtb set dtbname=dtb
if exist %tmpdir%\imgkit-magiskpatch\kernel_dtb set dtbname=kernel_dtb
if exist %tmpdir%\imgkit-magiskpatch\extra set dtbname=extra
if exist %tmpdir%\imgkit-magiskpatch\recovery_dtbo set dtbname=recovery_dtbo
if "%dtbname%"=="" (
    call log %logger% I Chinese text dtb
    goto MAGISKPATCH-phh-20201-20.3-15bd2da8-4)
call log %logger% I Chinese text dtb
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe dtb %dtbname% patch 1>>%logfile% 2>&1 || call log %logger% E Chinese text %dtbname% Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
:MAGISKPATCH-phh-20201-20.3-15bd2da8-4
::Chinese text kernel
call log %logger% I Chinese text kernel. Chinese text
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
if "%vivo_suu_patch%"=="y" (
    call log %logger% I Chinese text kernel-patch-vivo-do_mount_check
    magiskboot.exe hexpatch kernel 0092CFC2C9CDDDDA00 0092CFC2C9CEC0DB00 1>>%logfile% 2>&1 || call log %logger% E patch-vivo-do_mount_check Chinese text)
call log %logger% I Chinese text kernel- Chinese text RKP
magiskboot.exe hexpatch kernel 49010054011440B93FA00F71E9000054010840B93FA00F7189000054001840B91FA00F7188010054 A1020054011440B93FA00F7140020054010840B93FA00F71E0010054001840B91FA00F7181010054 1>>%logfile% 2>&1 || call log %logger% E Chinese text RKP Chinese text
call log %logger% I Chinese text kernel- Chinese text defex
magiskboot.exe hexpatch kernel 821B8012 E2FF8F12 1>>%logfile% 2>&1 || call log %logger% E Chinese text defex Chinese text
call log %logger% I Chinese text kernel- Chinese text rootfs
magiskboot.exe hexpatch kernel 736B69705F696E697472616D667300 77616E745F696E697472616D667300 1>>%logfile% 2>&1 || call log %logger% E Chinese text rootfs Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
goto MAGISKPATCH-DONE

:MAGISKPATCH-DONE
::Chinese text boot
call log %logger% I Chinese text boot
cd %tmpdir%\imgkit-magiskpatch 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch Chinese text&& goto FATAL
magiskboot.exe repack %bootpath% boot_new.img 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text boot Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text boot Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto MAGISKPATCH-DONE
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text boot Chinese text
call log %logger% I Chinese text boot Chinese text
set origbootsize=
for /f "tokens=2 delims= " %%a in ('busybox.exe stat -t %bootpath%') do set origbootsize=%%a
if "%origbootsize%"=="" ECHOC {%c_e%}Chinese text %bootpath% Chinese text{%c_i%}{\n}& call log %logger% F Chinese text %bootpath% Chinese text & goto FATAL
set patchedbootsize=
for /f "tokens=2 delims= " %%a in ('busybox.exe stat -t %tmpdir%\imgkit-magiskpatch\boot_new.img') do set patchedbootsize=%%a
if "%patchedbootsize%"=="" ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\boot_new.img Chinese text{%c_i%}{\n}& call log %logger% F Chinese text %tmpdir%\imgkit-magiskpatch\boot_new.img Chinese text & goto FATAL
if not "%origbootsize%"=="%patchedbootsize%" (
    ECHOC {%c_w%}Chinese text: Chinese text boot Chinese text . Chinese text boot: %origbootsize%b. Chinese text: %patchedbootsize%b{%c_i%}{\n}
    call log %logger% W Chinese text boot Chinese text . Chinese text boot:%origbootsize%b. Chinese text:%patchedbootsize%b
    if not "%mode%"=="noprompt" ECHOC {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & ECHO. Chinese text ...)
::Chinese text
move /Y %tmpdir%\imgkit-magiskpatch\boot_new.img %outputpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-magiskpatch\boot_new.img Chinese text %outputpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-magiskpatch\boot_new.img Chinese text %outputpath% Chinese text&& pause>nul && ECHO. Chinese text ... && goto MAGISKPATCH-DONE
call log %logger% I Chinese text
ENDLOCAL & set imgkit__magiskpatch__vername=%magiskver_show%& set imgkit__magiskpatch__ver=%magiskver%
goto :eof


:RECINST
SETLOCAL
set logger=imgkit.bat-recinst
set bootpath=%args2%& set outputpath=%args3%& set recpath=%args4%& set mode=%args5%
call log %logger% I Chinese text:bootpath:%bootpath%.outputpath:%outputpath%.recpath:%recpath%.mode:%noprompt%
:RECINST-1
::Chinese text
if not exist %bootpath% ECHOC {%c_e%}Chinese text %bootpath%{%c_i%}{\n}& call log %logger% F Chinese text %bootpath%& goto FATAL
if not exist %recpath% ECHOC {%c_e%}Chinese text %recpath%{%c_i%}{\n}& call log %logger% F Chinese text %recpath%& goto FATAL
if not "%mode%"=="noprompt" (if exist %outputpath% ECHOC {%c_w%}Chinese text %outputpath%, Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% W Chinese text %outputpath%. Chinese text& pause>nul & ECHO. Chinese text ...)
::Chinese text
call log %logger% I Chinese text
if exist %tmpdir%\imgkit-recinst rd /s /q %tmpdir%\imgkit-recinst 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst Chinese text{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-recinst Chinese text
md %tmpdir%\imgkit-recinst 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst Chinese text{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-recinst Chinese text
::Chinese text rec Chinese text
for %%i in ("%recpath%") do (if not "%%~xi"==".img" goto RECINST-2)
::Chinese text img Chinese text ramdisk
call log %logger% I Chinese text recovery Chinese text img Chinese text . Chinese text
cd %tmpdir%\imgkit-recinst 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-recinst Chinese text&& goto FATAL
magiskboot.exe unpack %recpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %recpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %recpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto RECINST-1
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
if not exist %tmpdir%\imgkit-recinst\ramdisk.cpio ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst\ramdisk.cpio, Chinese text %recpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text %tmpdir%\imgkit-recinst\ramdisk.cpio. Chinese text %recpath% Chinese text& pause>nul & ECHO. Chinese text ... & goto RECINST-1
move /Y %tmpdir%\imgkit-recinst\ramdisk.cpio %tmpdir%\imgkit-recinst\ramdisk.cpio_new 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst\ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-recinst\ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto RECINST-1
call log %logger% I Chinese text ramdisk.cpio Chinese text
goto RECINST-3
:RECINST-2
::Chinese text img Chinese text ramdisk.cpio_new
echo.F|xcopy /Y %recpath% %tmpdir%\imgkit-recinst\ramdisk.cpio_new 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %recpath% Chinese text %tmpdir%\imgkit-recinst\ramdisk.cpio_new Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %recpath% Chinese text %tmpdir%\imgkit-recinst\ramdisk.cpio_new Chinese text&& pause>nul && ECHO. Chinese text ... && goto RECINST-1
goto RECINST-3
:RECINST-3
::Chinese text boot
call log %logger% I Chinese text boot
cd %tmpdir%\imgkit-recinst 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-recinst Chinese text&& goto FATAL
magiskboot.exe cleanup 1>>%logfile% 2>&1 || ECHOC {%c_e%}magiskboot Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E magiskboot Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto RECINST-3
magiskboot.exe unpack -h %bootpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %bootpath% Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto RECINST-3
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::cmdline_remove_skip_override
call log %logger% I Chinese text cmdline_remove_skip_override
if not exist %tmpdir%\imgkit-recinst\header ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst\header, Chinese text %bootpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& call log %logger% E Chinese text %tmpdir%\imgkit-recinst\header. Chinese text %bootpath% Chinese text& pause>nul & ECHO. Chinese text ... & goto RECINST-3
echo.#!/busybox ash>%tmpdir%\imgkit-recinst\cmdline_remove_skip_override.sh
echo.sed -i "s|$(grep '^cmdline=' %tmpdir%/imgkit-recinst/header | cut -d= -f2-)|$(grep '^cmdline=' %tmpdir%/imgkit-recinst/header | cut -d= -f2- | sed -e 's/skip_override//' -e 's/  */ /g' -e 's/[ \t]*$//')|" %tmpdir%/imgkit-recinst/header>>%tmpdir%\imgkit-recinst\cmdline_remove_skip_override.sh
::busybox.exe ash %tmpdir%\imgkit-recinst\cmdline_remove_skip_override.sh 1>>%logfile% 2>&1 || ECHOC {%c_e%}cmdline_remove_skip_override Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E cmdline_remove_skip_override Chinese text&& pause>nul && ECHO. Chinese text ... && goto RECINST-3
busybox.exe ash %tmpdir%\imgkit-recinst\cmdline_remove_skip_override.sh 1>>%logfile% 2>&1 || call log %logger% W cmdline_remove_skip_override Chinese text
::hexpatch_kernel
call log %logger% I Chinese text hexpatch_kernel
cd %tmpdir%\imgkit-recinst 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-recinst Chinese text&& goto FATAL
magiskboot.exe hexpatch kernel 77616E745F696E697472616D6673 736B69705F696E697472616D6673 1>>%logfile% 2>&1 || call log %logger% E hexpatch_kernel Chinese text
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
::Chinese text ramdisk
call log %logger% I Chinese text ramdisk
move /Y %tmpdir%\imgkit-recinst\ramdisk.cpio_new %tmpdir%\imgkit-recinst\ramdisk.cpio 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst\ramdisk.cpio Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-recinst\ramdisk.cpio Chinese text&& pause>nul && ECHO. Chinese text ... && goto RECINST-3
::Chinese text boot
call log %logger% I Chinese text boot
cd %tmpdir%\imgkit-recinst 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %tmpdir%\imgkit-recinst Chinese text&& goto FATAL
magiskboot.exe repack %bootpath% boot_new.img 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text boot Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text boot Chinese text&& pause>nul && ECHO. Chinese text ... && cd %framework_workspace% && goto RECINST-3
cd %framework_workspace% 1>nul 2>>%logfile% || ECHOC {%c_e%}Chinese text %framework_workspace% Chinese text{%c_i%}{\n}&& call log %logger% F Chinese text %framework_workspace% Chinese text&& goto FATAL
move /Y %tmpdir%\imgkit-recinst\boot_new.img %outputpath% 1>>%logfile% 2>&1 || ECHOC {%c_e%}Chinese text %tmpdir%\imgkit-recinst\boot_new.img Chinese text %outputpath% Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}&& call log %logger% E Chinese text %tmpdir%\imgkit-recinst\boot_new.img Chinese text %outputpath% Chinese text&& pause>nul && ECHO. Chinese text ... && goto RECINST-3
call log %logger% I Chinese text
ENDLOCAL
goto :eof







:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)











::Chinese text



