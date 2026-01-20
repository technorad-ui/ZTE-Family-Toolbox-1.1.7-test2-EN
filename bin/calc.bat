::Chinese text: n

::call calc p       Chinese text  [nodec nodec-intp1 dec- Chinese text]  Chinese text 1   Chinese text 2
::          s       Chinese text  [nodec nodec-intp1 dec- Chinese text]  Chinese text 1   Chinese text 2
::          m       Chinese text  [nodec nodec-intp1 dec- Chinese text]  Chinese text 1   Chinese text 2
::          d       Chinese text  [nodec nodec-intp1 dec- Chinese text]  Chinese text 1   Chinese text 2
::          b2sec   Chinese text  [nodec nodec-intp1 dec- Chinese text]  b       Chinese text
::          sec2b   Chinese text  [nodec nodec-intp1 dec- Chinese text]  Chinese text Chinese text
::          b2kb    Chinese text  [nodec nodec-intp1 dec- Chinese text]  b
::          kb2b    Chinese text  [nodec nodec-intp1 dec- Chinese text]  kb
::          b2mb    Chinese text  [nodec nodec-intp1 dec- Chinese text]  b
::          mb2b    Chinese text  [nodec nodec-intp1 dec- Chinese text]  mb
::          b2gb    Chinese text  [nodec nodec-intp1 dec- Chinese text]  b
::          gb2b    Chinese text  [nodec nodec-intp1 dec- Chinese text]  gb
::          sec2kb  Chinese text  [nodec nodec-intp1 dec- Chinese text]  Chinese text Chinese text
::          kb2sec  Chinese text  [nodec nodec-intp1 dec- Chinese text]  kb      Chinese text
::          kb2mb   Chinese text  [nodec nodec-intp1 dec- Chinese text]  kb
::          mb2kb   Chinese text  [nodec nodec-intp1 dec- Chinese text]  mb
::          kb2gb   Chinese text  [nodec nodec-intp1 dec- Chinese text]  kb
::          gb2kb   Chinese text  [nodec nodec-intp1 dec- Chinese text]  gb

::          numcomp Chinese text 1       Chinese text 2


@ECHO OFF
chcp 65001 >nul
set args1=%1& set args2=%2& set args3=%3& set args4=%4& set args5=%5& set args6=%6& set args7=%7& set args8=%8& set args9=%9

SETLOCAL
set logger=calc.bat-%args1%
goto %args1%




:NUMCOMP
set num1=%args2%& set num2=%args3%
set result=
for /f "tokens=1 delims=#" %%a in ('numcomp.exe %num1% %num2%') do set result=%%a
if not "%result%"=="greater" (if not "%result%"=="less" (if not "%result%"=="equal" goto NUMCOMP-FAILED))
call log %logger% I Chinese text 1:%num1%. Chinese text 2:%num2%. Chinese text:%result%
ENDLOCAL & set calc__numcomp__result=%result%
goto :eof
:NUMCOMP-FAILED
ECHOC {%c_e%}Chinese text:Chinese text 1:%num1%. Chinese text 2:%num2%. Chinese text:%result%{%c_i%}{\n}& call log %logger% F Chinese text:Chinese text 1:%num1%. Chinese text 2:%num2%. Chinese text:%result%
goto FATAL


:B2GB
call :calcmode-argsprocess
set b=%args4%
for /f %%a in ('calc.exe %b% d 1073741824 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:b:%b%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:GB2B
call :calcmode-argsprocess
set gb=%args4%
for /f %%a in ('calc.exe %gb% m 1073741824 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:gb:%gb%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:B2MB
call :calcmode-argsprocess
set b=%args4%
for /f %%a in ('calc.exe %b% d 1048576 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:b:%b%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:MB2B
call :calcmode-argsprocess
set mb=%args4%
for /f %%a in ('calc.exe %mb% m 1048576 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:mb:%mb%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:SEC2B
call :calcmode-argsprocess
set sec=%args4%& set secsize=%args5%
for /f %%a in ('calc.exe %sec% m %secsize% %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:sec:%sec%.secsize:%secsize%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:B2SEC
call :calcmode-argsprocess
set b=%args4%& set secsize=%args5%
for /f %%a in ('calc.exe %b% d %secsize% %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:b:%b%.secsize:%secsize%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:SEC2KB
call :calcmode-argsprocess
set sec=%args4%& set secsize=%args5%
for /f %%a in ('calc.exe %sec% m %secsize% 12') do set var=%%a
for /f %%a in ('calc.exe %var% d 1024 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:sec:%sec%.secsize:%secsize%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:KB2SEC
call :calcmode-argsprocess
set kb=%args4%& set secsize=%args5%
for /f %%a in ('calc.exe %kb% m 1024 12') do set var=%%a
for /f %%a in ('calc.exe %var% d %secsize% %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:kb:%kb%.secsize:%secsize%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:KB2MB
call :calcmode-argsprocess
set kb=%args4%
for /f %%a in ('calc.exe %kb% d 1024 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:kb:%kb%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:MB2KB
call :calcmode-argsprocess
set mb=%args4%
for /f %%a in ('calc.exe %mb% m 1024 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:mb:%mb%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:KB2GB
call :calcmode-argsprocess
set kb=%args4%
for /f %%a in ('calc.exe %kb% d 1048576 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:kb:%kb%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:GB2KB
call :calcmode-argsprocess
set gb=%args4%
for /f %%a in ('calc.exe %gb% m 1048576 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:gb:%gb%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:B2KB
call :calcmode-argsprocess
set b=%args4%
for /f %%a in ('calc.exe %b% d 1024 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:b:%b%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:KB2B
call :calcmode-argsprocess
set kb=%args4%
for /f %%a in ('calc.exe %kb% m 1024 %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text:kb:%kb%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:P
set func=p& goto PSMD
:S
set func=s& goto PSMD
:M
set func=m& goto PSMD
:D
set func=d& goto PSMD
:PSMD
call :calcmode-argsprocess
set input1=%args4%& set input2=%args5%
for /f %%a in ('calc.exe %input1% %func% %input2% %decnum%') do set result=%%a
if "%decmode%"=="nodec-intp1" call :calcmode-nodec-intp1
call log %logger% I Chinese text 1:%input1%. Chinese text:%func%. Chinese text 2:%input2%. Chinese text:%decmode%. Chinese text:%output%:%result%
ENDLOCAL & set %output%=%result%
goto :eof

:calcmode-argsprocess
set output=%args2%& set decmode=%args3%
if "%decmode%"=="nodec" set decnum=0
if "%decmode%"=="nodec-intp1" set decnum=13
if "%decmode%"=="dec" set decnum=2
if "%decmode:~0,4%"=="dec-" set decnum=%decmode:~4,999%
goto :eof

:calcmode-nodec-intp1
for /f "tokens=1,2 delims=. " %%a in ('echo.%result%') do set args1=%%a& set args2=%%b
if "%args2%"=="0000000000000" (set result=%args1%) else (for /f %%a in ('calc.exe %args1% p 1 0') do set result=%%a)
goto :eof






:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)

