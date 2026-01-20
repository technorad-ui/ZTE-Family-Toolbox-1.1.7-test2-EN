::Chinese text: n

::call random Chinese text Chinese text(Chinese text,Chinese text)

::abcdefghijklmnopqrstuvwxyz0123456789 (Chinese text)
::ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
::abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
::abcdef0123456789 (Magisk Chinese text)


@ECHO OFF
chcp 65001 >nul
set args1=%1& set args2=%2& set args3=%3& set args4=%4& set args5=%5& set args6=%6& set args7=%7& set args8=%8& set args9=%9
::goto %args1%


SETLOCAL EnableDelayedExpansion
set length=%args1%& set str=%args2%
call log %logger% I Chinese text:length:%length%.str:%str%
if "%str%"=="" set str=abcdefghijklmnopqrstuvwxyz0123456789
for /f %%a in ('busybox.exe expr length "%str%"') do set str_length=%%a
for /l %%a in (1,1,%length%) do call :random-generate "%%a"
call log %logger% I Chinese text %str% Chinese text %length% Chinese text:%random_str%
ENDLOCAL & set random__str=%random_str%
goto :eof
:random-generate
if "%~1"=="" goto :eof
set /a var=%random%%%%str_length%
set random_str=%random_str%!str:~%var%,1!
goto :eof




:FATAL
ECHO. & if exist tool\Win\ECHOC.exe (tool\Win\ECHOC {%c_e%}Chinese text, Chinese text, Chinese text . Chinese text . {%c_h%}Chinese text ...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO. Chinese text, Chinese text, Chinese text . Chinese text ...& pause>nul & EXIT)

