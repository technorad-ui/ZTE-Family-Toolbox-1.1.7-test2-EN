@ECHO OFF

if exist bin\conf\user.bat (call bin\conf\user.bat) else (ECHO.找不到bin\conf\user.bat & pause & EXIT)

if exist bin\res\%product%\bak (start bin\res\%product%\bak) else (找不到bin\res\%product%\bak & pause & EXIT)

EXIT
