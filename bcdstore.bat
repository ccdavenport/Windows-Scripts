@echo off

REM disables tickless kernel, which is unneeded on systems without a battery.
bcdedit /set disabledynamictick yes
echo Disabling Dynamic tick

REM Asks the user if they want to disable data execution prevention, which is a security risk.
set /p disabledep="Do you want to disable Data Execution Prevention? This is a potential security risk, but may improve performance. (y/n) : "

IF /i disabledep==y bcdedit /set nx AlwaysOff
IF /i disabledep==n goto end

:end
echo bcdedit settings applied. You may now close this window.

@pause
