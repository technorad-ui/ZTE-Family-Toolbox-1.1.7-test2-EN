@ECHO OFF
chcp 65001 >nul

if exist bin\conf\user.bat (call bin\conf\user.bat) else (ECHO. Chinese text bin\conf\user.bat & pause & EXIT)

if exist bin\res\%product%\bak (start bin\res\%product%\bak) else (Chinese text bin\res\%product%\bak & pause & EXIT)

EXIT
